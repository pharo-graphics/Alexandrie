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
	"Compare along different blur radius (or sigmas), on the same figure."
	<sampleInstance>

	| circleRadius margin surfaces maxBlurSigma surfaceExtent |
	circleRadius := 45.
	maxBlurSigma := 20.
	margin := maxBlurSigma * 3.
	surfaceExtent := ((circleRadius + margin) * 2) asPoint.

	surfaces := (1 to: maxBlurSigma by: 1)
		collect: [ :blurSigma |
			| aSurface |
			aSurface := AeCairoImageSurface
				extent: surfaceExtent
				format: AeCairoSurfaceFormat a8.
			aSurface newContext
				sourceColor: Color black;
				translateBy: margin asPoint;
				circleRadius: circleRadius;
				fill.

			[ AeCairoA8FastGaussianBlurFilter new
					surface: aSurface;
					applySigma: blurSigma ]
							timeToRun asMilliSeconds traceCr.

			aSurface ].

"	(surfaces collect: [ :each |
		| samples |
		samples := (1 to: surfaceExtent x) collect: [ :i |
			(each colorAtX: i - 1 y: surfaceExtent y // 2) alpha ].
		RSScatterPlot x: (1 to: samples size) y: samples ]) inspect."

	^ surfaces
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example2MultiplePasses [
	"Compare along different box-blur number of passes (commonly 3 passes)"
	<sampleInstance>
	
	| lineLength blurSigma margin surfaceExtent aSurface surfaces |
	lineLength := 200.
	blurSigma := 10.
	margin := blurSigma * 3.
	surfaceExtent := (lineLength + margin) asPoint.

	surfaces := (1 to: 6) collect: [ :eachN | 
		aSurface := AeCairoImageSurface
			extent: surfaceExtent
			format: AeCairoSurfaceFormat a8.
		aSurface newContext
			sourceColor: Color black;
			strokeSize: blurSigma * 2;
			lineTo: (margin/2) asPoint;
			relativeLineTo: lineLength asPoint;
			stroke.

		[ AeCairoA8FastGaussianBlurFilter new
				surface: aSurface;
				applySigma: blurSigma n: eachN ]
						timeToRun asMilliSeconds traceCr.

		aSurface ].
	
	^ surfaces
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example3Text [
	"Render a text that drops a shadow."
	<sampleInstance>

	| fontSize string surfaceSize shadowSurface aFTLibrary aFTFace aFontFace aScaledFont aGlyphArray mainSurface blurSigma shadowOffset |
	blurSigma := 5.
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
			applySigma: blurSigma ] timeToRun asMilliSeconds traceCr.

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
		maskSurface: shadowSurface at: shadowOffset;

		translateByX: 5 y: fontSize;
		sourceColor: Color blue muchDarker;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

"	mainSurface finish. <-- Use it with PDF surface "
	^ mainSurface
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example4RectangleStroke [
	"Blur a rectangle stroke."
	<sampleInstance>

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

	AeCairoA8FastGaussianBlurFilter new
		surface: aSurface;
		applyRadius: blurRadius.

	^ aSurface
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example5DottedCircle [
	"Blur a circle with dotted (dashed) stroke."
	<sampleInstance>

	| circleRadius blurSigma margin aSurface strokeSize |
	circleRadius := 50.
	blurSigma := 2.5.
	margin := blurSigma * 3.
	strokeSize := 20.

	aSurface := AeCairoImageSurface
		extent: (((circleRadius + margin) * 2) + strokeSize) asPoint
		format: AeCairoSurfaceFormat a8.
	aSurface newContext
		sourceColor: Color black;
		circleCenter: aSurface extent / 2 radius: circleRadius;
		strokeSize: strokeSize;
		useStrokeCapSquare;
		strokeDashPattern: { 0. strokeSize*2 };
		stroke.

	[ AeCairoA8FastGaussianBlurFilter new
		surface: aSurface;
		applySigma: blurSigma ] timeToRun asMilliSeconds traceCr.

	^ aSurface
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example6GaussEstimation [
	"Playing with Gaussian function to emulate the slow blur."
	<sampleInstance>

	^ (3 to: 18 by: 2) reversed collect: [ :blurSigma |
		| rectangleMiddle shadowGap aSurface samples mu sigma gauss estimated coef samplesMu |
		rectangleMiddle := 100.
		coef := Float twoPi sqrt.
		shadowGap := (blurSigma * coef) ceiling.
		aSurface :=
			AeCairoImageSurface
				extent: ((rectangleMiddle + shadowGap * 2)) asPoint
				format: AeCairoSurfaceFormat a8.
		aSurface newContext
			sourceColor: Color black;
			rectangle: (shadowGap asPoint extent: (rectangleMiddle * 2) asPoint);
			fill.

		AeCairoA8FastGaussianBlurFilter new
			surface: aSurface;
			applySigma: blurSigma.


		samples := (1 to: rectangleMiddle) collect: [ :i |
			(aSurface colorAtX: i-1 y: rectangleMiddle) alpha ].

		(samples first: 5) traceCr.
		samplesMu := samples detectIndex: [ :s | s > 0.99 ].
		samples := samples first: samplesMu.

		mu := samplesMu.
		sigma := blurSigma * 1.5.
		gauss := [ :x | (-0.5 * (x - mu) squared / sigma squared) exp ].
		estimated := (1 to: mu) collect: [ :i | (gauss value: i) ].
		(((RSScatterPlot x: (1 to: samples size) y: samples) color: Color black)
		+ ((RSScatterPlot x: (1 to: estimated size) y: estimated) color: Color blue)).


		"aSurface"]
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example7SigmoidEstimation [
	<sampleInstance>

	| indexOfNonZero |
	^ (3 to: 18 by: 1) collect: [ :blurSigma |
		| rectangleMiddle margin aSurface samples mu sigmoidFunction estimated indexOfMax indexOfBreak k |
		rectangleMiddle := 100.
		margin := (blurSigma * Float e) ceiling.
		aSurface :=
			AeCairoImageSurface
				extent: ((rectangleMiddle + margin * 2)) asPoint
				format: AeCairoSurfaceFormat a8.
		aSurface newContext
			sourceColor: Color black;
			rectangle: (margin asPoint extent: (rectangleMiddle * 2) asPoint);
			fill.

		AeCairoA8FastGaussianBlurFilter new
			surface: aSurface;
			applySigma: blurSigma.

		samples := (1 to: rectangleMiddle) collect: [ :i |
			(aSurface colorAtX: i-1 y: rectangleMiddle-1) alpha ].

		indexOfMax := samples detectIndex: [ :s | s = samples max ].
		indexOfNonZero := samples detectIndex: [ :s | s > 0.0 ].
		indexOfBreak := samples detectIndex: [ :s | s >= 0.5 ].

		{	{blurSigma. margin}.
			{indexOfNonZero. indexOfBreak. indexOfMax}.
			{samples at: indexOfNonZero. samples at: indexOfMax} } traceCr.

		mu := margin+1.
		k := 1.1* Float e sqrt / blurSigma.
		sigmoidFunction := [ :x | 1.0 / (1.0 + (((x - mu) * k negated) exp)) ].

		samples := samples first: margin*2.
		estimated := (1 to: samples size) collect: [ :i | sigmoidFunction value: i ].
		(((RSScatterPlot x: (1 to: samples size) y: samples) color: Color black)
		+ ((RSScatterPlot x: (1 to: estimated size) y: estimated) color: Color green)).

	"[|refAlpha |
	refAlpha := (aSurface colorAtX: rectangleMiddle y: mu) alpha.
	(rectangleMiddle to: 0 by: -1) detectIndex: [ :x | (aSurface colorAtX: x y: mu) alpha < refAlpha ]] value."

	"{blurSigma. (0 to: mu*2) collect: [ :x | (aSurface colorAtX: x y: mu) alpha ]}."
"	Halt if: [ blurSigma = 10 ]."
"	blurSigma -> (margin * 2)"

"	aSurface newContext
			sourceColor: Color yellow;
			strokeSize: 1;
			rectangle: (-1 asPoint corner: (2*margin) + 0.5 asPoint);
			stroke;
			rectangle: (-1 asPoint corner: ((margin*1.6) ceiling - 0.5) asPoint);
			stroke.

	aSurface"

"	'blur.csv' asFileReference ensureDelete; writeStreamDo: [ :stream |
		| writer |
		writer := NeoCSVWriter on: stream.
		writer fieldWriter: #raw.
		samples withIndexDo: [ :each :index | writer nextPut: {index. each} ] ]."

		]
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
AeCairoA8FastGaussianBlurFilter >> boxBlurTFrom: scl to: tcl boxRadius: r [

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
