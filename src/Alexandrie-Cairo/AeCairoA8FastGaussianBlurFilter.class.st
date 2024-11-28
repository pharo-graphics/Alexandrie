"
I implement a Gaussian blur algorithm.

Based on:
- Explained by Ivan Kuckir in: https://blog.ivank.net/fastest-gaussian-blur.html
- Implemented in C++: https://github.com/WurmD/LowPass/blob/22c2e6826cc94ad44dd8150da652e34769a8f7e3/LowPassV.cpp
- Implemented in C#: https://github.com/mdymel/superfastblur/blob/1611c1a8c8a4d08b1f1991aeab7beabce049320a/SuperfastBlur/GaussianBlur.cs

"
Class {
	#name : #AeCairoA8FastGaussianBlurFilter,
	#superclass : #Object,
	#instVars : [
		'surface',
		'w',
		'h',
		'surfaceBuffer',
		'bufferA',
		'bufferB'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example1MultipleRadius [

	| circleRadius shadowGap aSurface surfaces maxBlurRadius surfaceExtent |
	circleRadius := 45.
	maxBlurRadius := 100.
	shadowGap := maxBlurRadius * 3.
	surfaceExtent := (circleRadius*2 + shadowGap) asPoint.

	surfaces := (2 to: maxBlurRadius by: 10)
		collect: [ :blurRadius | 
			aSurface := AeCairoImageSurface
				extent: surfaceExtent
				format: AeCairoSurfaceFormat a8.
			aSurface newContext
				sourceColor: Color black;
				translateBy: (shadowGap/2) asPoint;
				circleRadius: circleRadius;
				fill.
			aSurface flush.

			[ AeCairoA8FastGaussianBlurFilter new
					surface: aSurface;
					applyRadius: blurRadius ]
							timeToRun asMilliSeconds traceCr.

			aSurface ].
		
	surfaces inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example2MultiplePasses [

	| lineLength blurRadius shadowGap surfaceExtent aSurface surfaces |
	lineLength := 200.
	blurRadius := 25.
	shadowGap := blurRadius * 3.
	surfaceExtent := (lineLength + shadowGap) asPoint.

	surfaces := (1 to: 6) collect: [ :eachN | 
		aSurface := AeCairoImageSurface
			extent: surfaceExtent
			format: AeCairoSurfaceFormat a8.
		aSurface newContext
			sourceColor: Color black;
			lineWidth: blurRadius * 2;
			lineTo: (shadowGap/2) asPoint;
			relativeLineTo: lineLength asPoint;
			stroke.
		aSurface flush.

		[ AeCairoA8FastGaussianBlurFilter new
				surface: aSurface;
				applyRadius: blurRadius
				n: eachN ]
						timeToRun asMilliSeconds traceCr.

		aSurface ].
	
	surfaces inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example3Text [

	| fontSize string surfaceSize shadowSurface aFTLibrary aFTFace aFontFace aScaledFont aGlyphArray mainSurface shadowRadius shadowOffset |

	shadowRadius := 6.
	shadowOffset := 3@5.

	fontSize := 72.
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 920 @ (fontSize * 1.4).
	shadowSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat a8.
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Bold firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.
	aGlyphArray := aScaledFont glyphArrayForString: string.
	shadowSurface newContext
		translateByX: 5 y: fontSize;
		sourceColor: Color black;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.
	[ AeCairoA8FastGaussianBlurFilter new
			surface: shadowSurface;
			applyRadius: shadowRadius ] timeToRun asMilliSeconds traceCr.



	mainSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.

"	mainSurface := AeCairoPDFSurface
		  extent: surfaceSize
		  fileName: Time microsecondClockValue asString, '.pdf'."

	mainSurface newContext
		sourceColor: Color white;
		paint;

		sourceColor: Color red darker;
		maskSurface: shadowSurface
			x: shadowOffset x
			y: shadowOffset y;

		translateByX: 5 y: fontSize;
		sourceColor: Color blue muchDarker;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

"	mainSurface finish."
	mainSurface inspect
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example4RectangleStroke [

	| rectangleWidth blurRadius shadowGap aSurface |
	rectangleWidth := 80.
	blurRadius := 5.
	shadowGap := blurRadius * 3.

	aSurface := AeCairoImageSurface
		extent: (rectangleWidth + shadowGap) asPoint
		format: AeCairoSurfaceFormat a8.
	aSurface newContext
		sourceColor: Color black;
		rectangle: ((shadowGap/2) asPoint extent: rectangleWidth asPoint);
		stroke.
	aSurface flush.

	AeCairoA8FastGaussianBlurFilter new
		surface: aSurface;
		applyRadius: blurRadius.

	aSurface inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example5DottedCircle [

	| circleRadius blurRadius shadowGap aSurface |
	circleRadius := 130.
	blurRadius := 5.
	shadowGap := blurRadius * 3.

	aSurface := AeCairoImageSurface
		extent: (circleRadius*2 + shadowGap) asPoint
		format: AeCairoSurfaceFormat a8.
	aSurface newContext
		sourceColor: Color black;
		translateBy: (shadowGap/2) asPoint;
		lineWidth: 10;
		lineCap: AeCairoCapStyle square;
		dash: (AeFFIDoubleArray newFrom: #(0 20)) offset: 0;
		circleRadius: circleRadius;
		stroke.
	aSurface flush.

	[ AeCairoA8FastGaussianBlurFilter new
		surface: aSurface;
		applyRadius: blurRadius ] timeToRun asMilliSeconds traceCr.

	aSurface inspect
]

{ #category : #initialization }
AeCairoA8FastGaussianBlurFilter class >> initialize [

	"See: https://www.w3.org/TR/SVG11/filters.html#feGaussianBlurElement"
	GaussianScaleFactor := (3 * (Float twoPi sqrt) / 4) * 1.5
]

{ #category : #processing }
AeCairoA8FastGaussianBlurFilter >> applyRadius: blurRadius [

	self applyRadius: blurRadius n: 3
]

{ #category : #private }
AeCairoA8FastGaussianBlurFilter >> applyRadius: blurRadius n: n [
	"Apply blur with the specified radius, with in n passes."

	(blurRadius closeTo: 0) ifTrue: [ ^ self ].

	"See: https://github.com/pharo-graphics/Alexandrie/issues/71
	gaussianScaleFactor := (3 * (Float twoPi sqrt) / 4) * 1.5"
	self applySigma: (blurRadius / 2.8199568089598754) rounded n: n
]

{ #category : #processing }
AeCairoA8FastGaussianBlurFilter >> applySigma: blurSigma [

	self applySigma: blurSigma n: 3
]

{ #category : #private }
AeCairoA8FastGaussianBlurFilter >> applySigma: sigma n: n [
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
AeCairoA8FastGaussianBlurFilter >> boxBlurHFrom: scl to: tcl boxRadius: r [

	| diam iarr |
	diam := r+r+1.
	iarr := 1.0 / diam.
	
	0 to: h-1 do: [ :i |
		| ti li ri fv lv val |
		ti := i*w.
		li := ti.
		ri := ti+r.
		
		fv := scl zeroBasedAt: ti.
		lv := scl zeroBasedAt: ti+w-1.
		val := (r+1)*fv.

		0 to: r-1 do: [ :j |
			val := val + (scl zeroBasedAt: ti+j) ].
		r+1 timesRepeat: [
			val := val + (scl zeroBasedAt: ri) - fv.
			ri := ri+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ].
		w-diam timesRepeat: [
			val := val + (scl zeroBasedAt: ri) - (scl zeroBasedAt: li).
			ri := ri+1. li := li+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ].
		r timesRepeat: [
			val := val + lv - (scl zeroBasedAt: li).
			li := li+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ]
		]
]

{ #category : #private }
AeCairoA8FastGaussianBlurFilter >> boxBlurTFrom: scl to: tcl boxRadius: r [

	| diam iarr |
	diam := r+r+1.
	iarr := 1.0 / diam.
	
	0 to: w-1 do: [ :i |
		| ti li ri fv lv val |
		ti := i.
		li := ti.
		ri := ti+(r*w).

		fv := scl zeroBasedAt: ti.
		lv := scl zeroBasedAt: ti+(w*(h-1)).
		val := (r+1)*fv.

		0 to: r-1 do: [ :j |
			val := val + (scl zeroBasedAt: ti+(j*w)) ].
		r+1 timesRepeat: [
			val := val + (scl zeroBasedAt: ri) - fv.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ri := ri + w. ti := ti + w. ].
		h-diam timesRepeat: [
			val := val + (scl zeroBasedAt: ri) - (scl zeroBasedAt: li).
			tcl zeroBasedAt: ti putUint8: val*iarr.
			li := li + w. ri := ri + w. ti := ti + w. ].
		r timesRepeat: [
			val := val + lv - (scl zeroBasedAt: li).
			tcl zeroBasedAt: ti putUint8: val*iarr.
			li := li + w. ti := ti + w. ].
		].
	

]

{ #category : #private }
AeCairoA8FastGaussianBlurFilter >> boxRadiusStreamForSigma: sigma n: n [
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
AeCairoA8FastGaussianBlurFilter >> prepareBuffers [

	surface flush.
	surfaceBuffer := AeFFIUInt8Array
		fromHandle: surface data
		size: surface byteSize.
	bufferA := ByteArray withAll: surfaceBuffer.
	bufferB := ByteArray new: surfaceBuffer size
]

{ #category : #processing }
AeCairoA8FastGaussianBlurFilter >> surface: aSurface [

	surface := aSurface.
	w := surface stride.
	h := surface height.

]
