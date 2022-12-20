Class {
	#name : #AeCairoGaussianFilter,
	#superclass : #Object,
	#instVars : [
		'surface',
		'radius',
		'w',
		'h'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #examples }
AeCairoGaussianFilter class >> example0 [

	| circleRadius blurRadius margin aSurface aContext f |
	circleRadius := 20.
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
		"circleRadius: circleRadius;"
		rectangleTo: circleRadius asPoint;
		fill.
	aSurface flush.

	f := AeCairoGaussianFilter new.

	[f applyOn: aSurface radius: blurRadius] timeToRun traceCr.

	aSurface
]

{ #category : #examples }
AeCairoGaussianFilter class >> example1 [

	| circleRadius margin aSurface aContext f surfaces |
	surfaces := (0 to: 20 "by: 5") collect: [ :blurRadius | 

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

		f := AeCairoGaussianFilter new.

		
		[f applyOn: aSurface radius: blurRadius] timeToRun asMilliSeconds.
		aSurface.
		
		].
	
	surfaces inspect.
]

{ #category : #examples }
AeCairoGaussianFilter class >> example2 [

	| fontSize string surfaceSize aSurface aContext aFTFace aFontFace aScaledFont aGlyphArray f mainSurface mainContext |
	fontSize := 32.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 400 @ (fontSize*2).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_A8.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTFace := AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self error ].
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

	f := AeCairoGaussianFilter new.
	[f applyOn: aSurface radius: 4] timeToRun asMilliSeconds traceCr.


	mainSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat CAIRO_FORMAT_RGB24.
	mainContext := mainSurface newContext.

	mainContext
		sourceColorRGB: Color paleGreen;
		paint;

"		sourceSurface: aSurface x: 5 y: 5;
		paint;
"

		sourceColorRGB: Color purple;
		maskSurface: aSurface x: 0 y: 0;

		translateByX: 5 y: fontSize;
		sourceColorRGB: Color white;
		scaledFont: aScaledFont;
		showGlyphs: aGlyphArray.

	mainSurface inspect
]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> applyOn: aSurface radius: aRadius [

	| inputData tmpData |
	radius := aRadius.
	surface := aSurface.
	w := surface width.
	h := surface height.

	(radius closeTo: 0) ifTrue: [ ^self ].
	self assert: [ radius <= w or: [ radius <= h ] ].

	inputData := FFIExternalArray
		fromHandle: surface data getHandle
		type: FFIUInt8
		size: surface height * surface stride.

"	tmpData := FFIExternalArray externalNewType: FFIUInt8 size: inputData size."
	tmpData := ByteArray new: inputData size.

	self gaussBlurFrom: inputData to: tmpData.

	surface markDirty.
]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> asUint8: aNumber [

	aNumber > 255 ifTrue: [ ^ 255 ].
	aNumber < 0 ifTrue: [ ^ 0 ].
	^ aNumber rounded.

]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> boxBlurFrom: scl to: tcl s: s [
"
function boxBlur_4 (scl, tcl, w, h, r) {
    for(var i=0; i<scl.length; i++) tcl[i] = scl[i];
    boxBlurH_4(tcl, scl, w, h, r);
    boxBlurT_4(scl, tcl, w, h, r);
}"

	1 to: scl size do: [ :index |
		tcl at: index put: (scl at: index) ].
	
	self
		boxBlurHFrom: tcl to: scl s: s;
		boxBlurTFrom: scl to: tcl s: s.
]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> boxBlurHFrom: scl to: tcl s: r [
"function boxBlurH_4 (scl, tcl, w, h, r) {
    var iarr = 1 / (r+r+1);
    for(var i=0; i<h; i++) {
        var ti = i*w, li = ti, ri = ti+r;
        var fv = scl[ti], lv = scl[ti+w-1], val = (r+1)*fv;
        for(var j=0; j<r; j++) val += scl[ti+j];
        for(var j=0  ; j<=r ; j++) { val += scl[ri++] - fv       ;   tcl[ti++] = Math.round(val*iarr); }
        for(var j=r+1; j<w-r; j++) { val += scl[ri++] - scl[li++];   tcl[ti++] = Math.round(val*iarr); }
        for(var j=w-r; j<w  ; j++) { val += lv        - scl[li++];   tcl[ti++] = Math.round(val*iarr); }
    }
}"
	| iarr |
	iarr := 1.0 / (r+r+1).
	
	1 to: h-1 do: [ :i |
"	1 to: h do: [ :i |"
		| ti li ri fv lv val |
		ti := i*w.
		li := ti.
		ri := ti+r.
		
		fv := scl at: ti.
		lv := scl at: (ti+w-1).
		val := (r+1)*fv.

		1 to: r do: [ :j |
			val := val + (scl at: ti+j) ].
		1 to: r+1 do: [ :j |
			val := val + (scl at: ri) - fv.
			ri := ri+1.
			tcl at: ti put: (self asUint8: val*iarr).
			ti := ti+1 ].
		r+2 to: w-r do: [ :j |
			val := val + (scl at: ri) - (scl at: li).
			ri := ri+1.
			li := li+1.
			tcl at: ti put: (self asUint8: val*iarr).
			ti := ti+1 ].
		w-r+1 to: w do: [ :j |
			val := val + lv - (scl at: li).
			li := li+1.
			tcl at: ti put: (self asUint8: val*iarr).
			ti := ti+1 ]
		]
]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> boxBlurTFrom: scl to: tcl s: r [
"function boxBlurT_4 (scl, tcl, w, h, r) {
    var iarr = 1 / (r+r+1);
    for(var i=0; i<w; i++) {
        var ti = i, li = ti, ri = ti+r*w;
        var fv = scl[ti], lv = scl[ti+w*(h-1)], val = (r+1)*fv;
        for(var j=0; j<r; j++) val += scl[ti+j*w];
        for(var j=0  ; j<=r ; j++) { val += scl[ri] - fv     ;  tcl[ti] = Math.round(val*iarr);  ri+=w; ti+=w; }
        for(var j=r+1; j<h-r; j++) { val += scl[ri] - scl[li];  tcl[ti] = Math.round(val*iarr);  li+=w; ri+=w; ti+=w; }
        for(var j=h-r; j<h  ; j++) { val += lv      - scl[li];  tcl[ti] = Math.round(val*iarr);  li+=w; ti+=w; }
    }
}"
	| iarr |
	iarr := 1 / (r+r+1).
	
	1 to: w do: [ :i |
		| ti li ri fv lv val |
		ti := i.
		li := ti.
		ri := ti+(r*w).
		
		fv := scl at: ti.
		lv := scl at: ti+(w*(h-1)).
		val := (r+1)*fv.

		1 to: r do: [ :j |
			val := val + (scl at: ti+(j*w)) ].
		1 to: r+1 do: [ :j |
			val := val + (scl at: ri) - fv.
			tcl at: ti put: (self asUint8: val*iarr).
			ri := ri + w.
			ti := ti + w. ].
		r+2 to: h-r do: [ :j |
			val := val + (scl at: ri) - (scl at: li).
			tcl at: ti put: (self asUint8: val*iarr).
			li := li + w.
			ri := ri + w.
			ti := ti + w. ].
		h-r+1 to: h do: [ :j |
			val := val + lv - (scl at: li).
			tcl at: ti put: (self asUint8: val*iarr).
			li := li+w.
			ti := ti + w. ]
		]
]

{ #category : #'api - processing' }
AeCairoGaussianFilter >> boxesForGaussSigma: sigma n: n [
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
AeCairoGaussianFilter >> gaussBlurFrom: scl to: tcl [

"function gaussBlur_4 (scl, tcl, w, h, r) {
    var bxs = boxesForGauss(r, 3);
    boxBlur_4 (scl, tcl, w, h, (bxs[0]-1)/2);
    boxBlur_4 (tcl, scl, w, h, (bxs[1]-1)/2);
    boxBlur_4 (scl, tcl, w, h, (bxs[2]-1)/2);
}"

	| bxs |
	bxs := self boxesForGaussSigma: radius n: 3.
	
	self boxBlurFrom: scl to: tcl s: (bxs first  - 1) / 2.
	self boxBlurFrom: tcl to: scl s: (bxs second - 1) / 2.
	self boxBlurFrom: scl to: tcl s: (bxs third  - 1) / 2.

]
