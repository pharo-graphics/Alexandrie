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
		'radius',
		'w',
		'h',
		'sigma',
		'surfaceBuffer',
		'buffer1',
		'buffer2'
	],
	#classVars : [
		'GaussianScaleFactor'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example1sequence [

	| circleRadius shadowGap aSurface aContext f surfaces maxBlurRadius surfaceExtent |
	"ok only when both circleRadius and maxBlurRadius are pair"
	"=> related to extent"
	circleRadius := 45.
	maxBlurRadius := 40.
	shadowGap := maxBlurRadius * 3.
	surfaceExtent := (circleRadius*2 + shadowGap) asPoint.
	surfaceExtent traceCr.

	surfaces := (2 to: maxBlurRadius by: 5)
		collect: [ :blurRadius | 
			aSurface := AeCairoImageSurface
				extent: surfaceExtent
				format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
			aContext := aSurface newContext.

			aContext
				sourceColorRGB: Color black;
				translateBy: (shadowGap/2) asPoint;
				circleRadius: circleRadius;
				fill.
			aSurface flush.

			[ AeCairoA8FastGaussianBlurFilter new
					applyOn: aSurface
					radius: blurRadius ]
							timeToRun asMilliSeconds traceCr.

			aSurface ].
		
	surfaces inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example2text [

	| fontSize string surfaceSize shadowSurface aContext aFTLibrary aFTFace aFontFace aScaledFont aGlyphArray mainSurface mainContext shadowRadius shadowOffset |

	shadowRadius := 6.
	shadowOffset := 3@5.

	fontSize := 62.
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 800 @ (fontSize*1.5).
	shadowSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aContext := shadowSurface newContext.
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Bold firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.
	aGlyphArray := aScaledFont glyphArrayForString: string.
	aContext
		translateByX: 5 y: fontSize;
		sourceColorRGB: Color black;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.
	[ AeCairoA8FastGaussianBlurFilter new
			applyOn: shadowSurface
			radius: shadowRadius ] timeToRun asMilliSeconds traceCr.



	mainSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_RGB24.
	mainContext := mainSurface newContext.

	mainContext
		sourceColorRGB: Color white;
		paint;

		sourceColorRGB: Color red darker;
		maskSurface: shadowSurface
			x: shadowOffset x
			y: shadowOffset y;

		translateByX: 5 y: fontSize;
		sourceColorRGB: Color blue muchDarker;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

	mainSurface inspect
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example3rectangleLine [

	| rectangleWidth blurRadius shadowGap aSurface surfaceExtent |
	"Both par or impar is ok? not always
	9,5=ok    
	8,5=wrong
	5,5=ok
	4,5=w
	4,3=w desde 1ero
	3,5=w
	3,4=w
	3,3=ok
	3,2=w desde 2do (mitad)
	2,2=ok
	1,2=w pero desde la mitad
	si cambio alto de surface => no cambia
	si cambio ancho => si cambia
	"
	rectangleWidth := 8.
	blurRadius := 5.
	shadowGap := blurRadius * 3.
	surfaceExtent := (rectangleWidth + shadowGap) asPoint..
	surfaceExtent traceCr.

	aSurface := AeCairoImageSurface
		extent: surfaceExtent
		format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aSurface newContext
		sourceColorRGB: Color black;
		rectangle: ((shadowGap/2) asPoint extent: rectangleWidth asPoint);
		fill.
	aSurface flush.

	AeCairoA8FastGaussianBlurFilter new
			applyOn: aSurface
			radius: blurRadius.

	aSurface inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example4circle [

	| circleRadius blurRadius shadowGap aSurface aContext |
	circleRadius := 502.
	blurRadius := 10.
	shadowGap := blurRadius * 3.

	aSurface := AeCairoImageSurface
		extent: (circleRadius*2 + shadowGap) asPoint
		format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aContext := aSurface newContext.

	aContext
		sourceColorRGB: Color black;
		translateBy: (shadowGap/2) asPoint;
		circleRadius: circleRadius;
		fill.
	aSurface flush.

	[ AeCairoA8FastGaussianBlurFilter new
		applyOn: aSurface
		radius: blurRadius ] timeToRun asMilliSeconds traceCr.

	aSurface inspect
]

{ #category : #initialization }
AeCairoA8FastGaussianBlurFilter class >> initialize [

	"See: https://www.w3.org/TR/SVG11/filters.html#feGaussianBlurElement"
	GaussianScaleFactor := (3 * (Float twoPi sqrt) / 4) * 1.5
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> applyOn: aSurface radius: aRadius [

	(aRadius closeTo: 0) ifTrue: [ ^self ].

	surface := aSurface.
	w := surface stride.
	h := surface height.
	sigma := aRadius / GaussianScaleFactor.

	self filterThreeTimes.

]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlur: scl tmp: tcl s: s [

	self
		boxBlurHFrom: scl to: tcl s: s;
		boxBlurTFrom: tcl to: scl s: s.
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlurHFrom: scl to: tcl s: r [

	| iarr |
	iarr := 1.0 / (r+r+1).
	
	0 to: h -1 do: [ :i |
		| ti li ri fv lv val |
		ti := i*w. li := ti. ri := ti+r.
		
		fv := scl zeroBasedAt: ti.
		lv := scl zeroBasedAt: ti+w-1.
		val := (r+1)*fv.

		0 to: r -1 do: [ :j |
			val := val + (scl zeroBasedAt: ti+j) ].
		0 to: r do: [ :j |
			val := val + (scl zeroBasedAt: ri) - fv.
			ri := ri+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ].
		r+1 to: w-r -1 do: [ :j |
			val := val + (scl zeroBasedAt: ri) - (scl zeroBasedAt: li).
			ri := ri+1. li := li+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ].
		w-r to: w -1 do: [ :j |
			val := val + lv - (scl zeroBasedAt: li).
			li := li+1.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ti := ti+1 ]
		]
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlurTFrom: scl to: tcl s: r [

	| iarr |
	iarr := 1.0 / (r+r+1).
	
	0 to: w -1 do: [ :i |
		| ti li ri fv lv val |
		ti := i. li := ti. ri := ti+(r*w).

		fv := scl zeroBasedAt: ti.
		lv := scl zeroBasedAt: ti+(w*(h-1)).
		val := (r+1)*fv.

		0 to: r -1 do: [ :j |
			val := val + (scl zeroBasedAt: ti+(j*w)) ].
		0 to: r do: [ :j |
			val := val + (scl zeroBasedAt: ri) - fv.
			tcl zeroBasedAt: ti putUint8: val*iarr.
			ri := ri + w. ti := ti + w. ].
		r+1 to: h-r -1 do: [ :j |
			val := val + (scl zeroBasedAt: ri) - (scl zeroBasedAt: li).
			tcl zeroBasedAt: ti putUint8: val*iarr.
			li := li + w. ri := ri + w. ti := ti + w. ].
		h-r to: h -1 do: [ :j |
			val := val + lv - (scl zeroBasedAt: li).
			tcl zeroBasedAt: ti putUint8: val*iarr.
			li := li + w. ti := ti + w. ].
		].
	

]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> filterThreeTimes [

	| solver stream |
	surfaceBuffer := FFIExternalArray
		fromHandle: surface data getHandle
		type: FFIUInt8
		size: surface height * surface stride.
	buffer1 := ByteArray withAll: surfaceBuffer. 
	buffer2 := ByteArray new: surfaceBuffer size.

	solver := AeIntegralImageSolver new
		calculateForSigma: sigma n: 3;
		yourself.
	stream := solver boxRadiiStream.

	self
		boxBlur: buffer1
			tmp: buffer2
			s: stream next;
		boxBlur: buffer1
			tmp: buffer2
			s: stream next;
		boxBlur: buffer1
			tmp: buffer2
			s: stream next.

	LibC memCopy: buffer1 to: surfaceBuffer size: surfaceBuffer size.
	surface markDirty.

]
