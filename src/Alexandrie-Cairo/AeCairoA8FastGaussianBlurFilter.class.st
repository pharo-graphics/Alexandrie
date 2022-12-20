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
		'h'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example0 [

	| circleRadius blurRadius margin aSurface aContext f |
	circleRadius := 200.
	blurRadius := 10.
	margin := blurRadius * 2.

	aSurface := AeCairoImageSurface
		extent: (circleRadius+margin) "* 2" asPoint
		format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aContext := aSurface newContext.

	"draw circle"
	aContext
		translateByX: margin y: margin;
		sourceColorRGB: Color black;
		circleRadius: circleRadius;
"		rectangleTo: circleRadius asPoint;"
		fill.
	aSurface flush.

	f := AeCairoA8FastGaussianBlurFilter new.

	[f applyOn: aSurface radius: blurRadius] timeToRun asMilliSeconds traceCr.

	aSurface inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example1 [

	| circleRadius margin aSurface aContext f surfaces |
	surfaces := (0 to: 20 by: 2) collect: [ :blurRadius | 

		circleRadius := 50.
		margin := 50.

		aSurface := AeCairoImageSurface
			extent: (circleRadius+margin) * 2 asPoint
			format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
		aContext := aSurface newContext.

		"draw circle"
		aContext
			translateByX: margin y: margin;
			sourceColorRGB: Color black;
	"		circleRadius: circleRadius;"
			rectangleTo: circleRadius asPoint;
			fill.
		aSurface flush.

		f := AeCairoA8FastGaussianBlurFilter new.

		
		[f applyOn: aSurface radius: blurRadius] timeToRun asMilliSeconds traceCr.
		aSurface.
		
		].
	
	surfaces inspect.
]

{ #category : #examples }
AeCairoA8FastGaussianBlurFilter class >> example2 [

	| fontSize string surfaceSize aSurface aContext aFTLibrary aFTFace aFontFace aScaledFont aGlyphArray f mainSurface mainContext |
	fontSize := 62.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 800 @ (fontSize*1.5).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Bold firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.

	"Create text glyphs to draw"	
	aGlyphArray := aScaledFont glyphArrayForString: string.

	"Draw glyphs"
	aContext
		translateByX: 5 y: fontSize;
		sourceColorRGB: Color black;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

	f := AeCairoA8FastGaussianBlurFilter new.
	[f applyOn: aSurface radius: 4] timeToRun asMilliSeconds traceCr.


	mainSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_RGB24.
	mainContext := mainSurface newContext.

	mainContext
		sourceColorRGB: Color white;
		paint;

		sourceColorRGB: Color red darker;
		maskSurface: aSurface x: 5 y: 5;

		translateByX: 5 y: fontSize;
		sourceColorRGB: Color blue muchDarker;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

	mainSurface inspect
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> applyOn: aSurface radius: aRadius [

	| buffer1 buffer2 surfaceData |
	radius := aRadius.
	surface := aSurface.
	w := surface width.
	h := surface height.

	(radius closeTo: 0) ifTrue: [ ^self ].
	self assert: [ radius <= w or: [ radius <= h ] ].

	surfaceData := FFIExternalArray
		fromHandle: surface data getHandle
		type: FFIUInt8
		size: surface height * surface stride.
	buffer1 := ByteArray withAll: surfaceData. 
	buffer2 := ByteArray new: buffer1 size.

	self gaussBlurFrom: buffer1 to: buffer2.

	LibC memCopy: buffer1 to: surfaceData size: buffer1 size.
	surface markDirty.
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> asUint8Rounded: aNumber [

	aNumber > 254.5 ifTrue: [ ^ 255 ].
	aNumber < 0.5 ifTrue: [ ^ 0 ].
	^ aNumber rounded
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlurFrom: scl to: tcl s: s [
"
function boxBlur_4 (scl, tcl, w, h, r) {
    for(var i=0; i<scl.length; i++) tcl[i] = scl[i];
    boxBlurH_4(tcl, scl, w, h, r);
    boxBlurT_4(scl, tcl, w, h, r);
}"

	LibC memCopy: scl to: tcl size: scl size.
	
	self
		boxBlurHFrom: tcl to: scl s: s;
		boxBlurTFrom: scl to: tcl s: s.
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlurHFrom: scl to: tcl s: r [
"function boxBlurH_4 (scl, tcl, w, h, r) {
    var iarr = 1 / (r+r+1);
    for(var i=0; i<h; i++) {
        var ti = i*w, li = ti, ri = ti+r;
        var fv = scl[ti], lv = scl[ti+w-1], val = (r+1)*fv;
        for(var j=0; j<r; j++) val += scl[ti+j];
        for(var j=0  ; j<=r ; j++) { val += scl[ri++] - fv       ;   tcl[ti++] = Math.round(val*iarr); }
        for(var j=r+1; j<w-r; j++) { val += scl[ri++] - scl[li++];   tcl[ti++] = Math.round(val*iarr); }
        for(var j=w-r; j<w  ; j++) { val += lv        - scl[li++];   tcl[ti++] = Math.round(val*iarr); }
    } }"
	| iarr |
	iarr := 1.0 / (r+r+1).
	
	0 to: h -1 do: [ :i |
		| ti li ri fv lv val |
		ti := i*w. 	li := ti. 	ri := ti+r.
		
		fv := scl zeroIndexAt: ti. 		lv := scl zeroIndexAt: (ti+w-1).
		val := (r+1)*fv.

		0 to: r -1 do: [ :j |
			val := val + (scl zeroIndexAt: ti+j) ].
		0 to: r do: [ :j |
			val := val + (scl zeroIndexAt: ri) - fv. 						ri := ri+1.
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr). 	ti := ti+1 ].
		r+1 to: w-r -1 do: [ :j |
			val := val + (scl zeroIndexAt: ri) - (scl zeroIndexAt: li). 	ri := ri+1. 		li := li+1.
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr).		ti := ti+1 ].
		w-r to: w-1 do: [ :j |
			val := val + lv - (scl zeroIndexAt: li). 						li := li+1.
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr). 	ti := ti+1 ]
		]
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxBlurTFrom: scl to: tcl s: r [
"function boxBlurT_4 (scl, tcl, w, h, r) {
    var iarr = 1 / (r+r+1);
    for(var i=0; i<w; i++) {
        var ti = i, li = ti, ri = ti+r*w;
        var fv = scl[ti], lv = scl[ti+w*(h-1)], val = (r+1)*fv;
        for(var j=0; j<r; j++) val += scl[ti+j*w];
        for(var j=0  ; j<=r ; j++) { val += scl[ri] - fv     ;  tcl[ti] = Math.round(val*iarr);  ri+=w; ti+=w; }
        for(var j=r+1; j<h-r; j++) { val += scl[ri] - scl[li];  tcl[ti] = Math.round(val*iarr);  li+=w; ri+=w; ti+=w; }
        for(var j=h-r; j<h  ; j++) { val += lv      - scl[li];  tcl[ti] = Math.round(val*iarr);  li+=w; ti+=w; }
    } }"
	| iarr |
	iarr := 1.0 / (r+r+1).
	
	0 to: w -1 do: [ :i |
		| ti li ri fv lv val |
		ti := i. 		li := ti. 	ri := ti+(r*w).
		
		fv := scl zeroIndexAt: ti. 		lv := scl zeroIndexAt: ti+(w*(h-1)).
		val := (r+1)*fv.

		0 to: r -1 do: [ :j |
			val := val + (scl zeroIndexAt: ti+(j*w)) ].
		0 to: r do: [ :j |
			val := val + (scl zeroIndexAt: ri) - fv.
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr). 			ri := ri + w. 	ti := ti + w. ].
		r+1 to: h-r -1 do: [ :j |
			val := val + (scl zeroIndexAt: ri) - (scl zeroIndexAt: li).
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr). 			li := li + w. 	ri := ri + w. 	ti := ti + w. ].
		h-r to: h -1 do: [ :j |
			val := val + lv - (scl zeroIndexAt: li).
			tcl zeroIndexAt: ti put: (self asUint8Rounded: val*iarr). 			li := li + w. 	ti := ti + w. ]
		]
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> boxesForGaussSigma: sigma n: n [
	"Parameters: standard deviation, number of boxes"

"function boxesForGauss(sigma, n)  // standard deviation, number of boxes
{
    var wIdeal = Math.sqrt((12*sigma*sigma/n)+1);  // Ideal averaging filter width 
    var wl = Math.floor(wIdeal);  if(wl%2==0) wl--;
    var wu = wl+2;
				
    var mIdeal = (12*sigma*sigma - n*wl*wl - 4*n*wl - 3*n)/(-4*wl - 4);
    var m = Math.round(mIdeal);
    // var sigmaActual = Math.sqrt( (m*wl*wl + (n-m)*wu*wu - n)/12 );
				
    var sizes = [];  for(var i=0; i<n; i++) sizes.push(i<m?wl:wu);
    return sizes;
}"

	| wIdeal wl wu mIdeal m |
	wIdeal := ((12*sigma*sigma/n)+1) sqrt.
	wl := wIdeal floor.
	wl even ifTrue: [ wl := wl-1 ].
	wu := wl+2.
	
	mIdeal := ((12*sigma*sigma) - (n*wl*wl) - (4*n*wl) - (3*n)) / ((-4*wl) - 4).
	m := mIdeal rounded.
	
	^ Array streamContents: [ :sizesStream |
		0 to: n-1 do: [ :index |
			sizesStream nextPut: ((index < m)
				ifTrue: [ wl ]
				ifFalse: [ wu ]) ] ]
]

{ #category : #'api - processing' }
AeCairoA8FastGaussianBlurFilter >> gaussBlurFrom: scl to: tcl [

"function gaussBlur_4 (scl, tcl, w, h, r) {
    var bxs = boxesForGauss(r, 3);
    boxBlur_4 (scl, tcl, w, h, (bxs[0]-1)/2);
    boxBlur_4 (tcl, scl, w, h, (bxs[1]-1)/2);
    boxBlur_4 (scl, tcl, w, h, (bxs[2]-1)/2);
}"

	| boxes |
	boxes := self boxesForGaussSigma: radius n: 3.
	
	self boxBlurFrom: scl to: tcl s: (boxes first  - 1) / 2.
	self boxBlurFrom: tcl to: scl s: (boxes second - 1) / 2.
	self boxBlurFrom: scl to: tcl s: (boxes third  - 1) / 2.

]
