"
I implement a Gaussian blur algorithm.

Based on:
- Explained by Ivan Kuckir in: https://blog.ivank.net/fastest-gaussian-blur.html
- Implemented in C++: https://github.com/WurmD/LowPass/blob/22c2e6826cc94ad44dd8150da652e34769a8f7e3/LowPassV.cpp
- Implemented in C#: https://github.com/mdymel/superfastblur/blob/1611c1a8c8a4d08b1f1991aeab7beabce049320a/SuperfastBlur/GaussianBlur.cs

"
Class {
	#name : #AeCairoA8GaussianBlurFilter,
	#superclass : #Object,
	#instVars : [
		'surface',
		'w',
		'h',
		'surfaceBuffer',
		'bufferA',
		'bufferB'
	],
	#category : #'Alexandrie-Blur'
}

{ #category : #processing }
AeCairoA8GaussianBlurFilter >> applyRadius: blurRadius [

	self applyRadius: blurRadius n: 3
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> applyRadius: blurRadius n: n [
	"Apply blur with the specified radius, with in n passes."

	(blurRadius closeTo: 0) ifTrue: [ ^ self ].

	"See: https://github.com/pharo-graphics/Alexandrie/issues/71
	gaussianScaleFactor := (3 * (Float twoPi sqrt) / 4) * 1.5"
	self applySigma: (blurRadius / 2.8199568089598754) rounded n: n
]

{ #category : #processing }
AeCairoA8GaussianBlurFilter >> applySigma: blurSigma [

	self applySigma: blurSigma n: 3
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> applySigma: sigma n: n [
	"Apply blur with the specified sigma (standard deviation), in n passes."

	| stream |
	(sigma closeTo: 0.0) ifTrue: [ ^ self ].

	stream := self boxRadiusStreamForSigma: sigma n: n.

	self prepareBuffers.

	n timesRepeat: [
		| eachBoxRadius |
		eachBoxRadius := stream next.
		self
			boxBlurHFrom: bufferA to: bufferB boxRadius: eachBoxRadius;
			boxBlurTFrom: bufferB to: bufferA boxRadius: eachBoxRadius ].

	LibC memCopy: bufferA to: surfaceBuffer size: surfaceBuffer size.
	surface markDirty
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> boxBlurHFrom: scl to: tcl boxRadius: r [

	| diam iarr |
	diam := r+r+1.
	iarr := 1.0 / diam.
	
	0 to: h - 1 do: [ :i |
		| ti li ri fv lv val |
		ti := (i * w) + 1.
		li := ti.
		ri := ti+r.
		
		fv := scl at: ti.
		lv := scl at: ti + w - 1.
		val := (r+1) * fv.

		0 to: r-1 do: [ :j |
			val := val + (scl at: ti+j) ].
		r+1 timesRepeat: [
			val := val + (scl at: ri) - fv.
			ri := ri+1.
			tcl at: ti put: (val * iarr) floor.
			ti := ti+1 ].
		w-diam timesRepeat: [
			val := val + (scl at: ri) - (scl at: li).
			ri := ri+1. li := li+1.
			tcl at: ti put: (val * iarr) floor.
			ti := ti+1 ].
		r timesRepeat: [
			val := val + lv - (scl at: li).
			li := li+1. 
			tcl at: ti put: (val * iarr) floor.
			ti := ti+1 ]
		]
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> boxBlurTFrom: scl to: tcl boxRadius: r [

	| diam iarr |
	diam := r+r+1.
	iarr := 1.0 / diam.
	
	1 to: w do: [ :i |
		| ti li ri fv lv val |
		ti := i.
		li := ti.
		ri := ti + (r*w).

		fv := scl at: ti.
		lv := scl at: ti + (w*(h-1)).
		val := (r+1) * fv.

		0 to: r-1 do: [ :j |
			val := val + (scl at: ti + (j*w)) ].
		r+1 timesRepeat: [
			val := val + (scl at: ri) - fv.
			tcl at: ti put: (val * iarr) floor.
			ri := ri + w. ti := ti + w. ].
		h-diam timesRepeat: [
			val := val + (scl at: ri) - (scl at: li).
			tcl at: ti put: (val * iarr) floor.
			li := li + w. ri := ri + w. ti := ti + w. ].
		r timesRepeat: [
			val := val + lv - (scl at: li).
			tcl at: ti put: (val * iarr) floor.
			li := li + w. ti := ti + w. ].
		]
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> boxRadiusStreamForSigma: sigma n: n [
	"Answer a read stream with n values. The sigma is the blur standard deviation.
	Based on the `boxesForGauss` function in the reference implementation (see class comment for the URL)."

	| widthIdeal widthL widthU radiusL radiusU mIdeal m |
	widthIdeal := (((12 * sigma squared) / n) + 1) sqrt.
	widthL := widthIdeal floor.
	widthL even ifTrue: [ widthL := widthL - 1 ].
	widthU := widthL + 2.
	radiusL := (widthL - 1) bitShift: -1.
	radiusU := (widthU - 1) bitShift: -1.
	mIdeal :=
		((12 * sigma squared)
		- (n * widthL squared)
		- (4 * n * widthL)
		- (3 * n)) / ((-4 * widthL) - 4).
	m := mIdeal rounded.
	
	^ Generator on: [ :generator |
		m timesRepeat: [
			generator yield: radiusL ].
		(n - m) timesRepeat: [ 
			generator yield: radiusU ] ]
]

{ #category : #private }
AeCairoA8GaussianBlurFilter >> prepareBuffers [

	surface flush.
	surfaceBuffer := AeFFIUInt8Array
		fromHandle: surface data
		size: surface byteSize.
	bufferA := ByteArray withAll: surfaceBuffer.
	bufferB := ByteArray new: surfaceBuffer size
]

{ #category : #processing }
AeCairoA8GaussianBlurFilter >> surface: aSurface [

	surface := aSurface.
	w := surface stride.
	h := surface height
]
