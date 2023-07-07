Class {
	#name : #AeCairoExamplesRenderTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #convenience }
AeCairoExamplesRenderTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AeCairoExamplesRenderTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #convenience }
AeCairoExamplesRenderTest class >> inspectMismatches [
	<script: 'self inspectMismatches' >

	super inspectMismatches
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithColoredIcons [

	| inputForm inputSurface outputColors outputSurface outputContext |
	inputForm := self iconNamed: #windowClose.
	inputSurface := AeCairoImageSurface fromForm: inputForm.

	outputColors := Color wheel: 7.

	"Create a surface and associated context"
	outputSurface := AeCairoImageSurface
	    extent: (inputSurface width * outputColors size) @ inputSurface height
	    format: AeCairoSurfaceFormat argb32.
	outputContext := outputSurface newContext.

	"Paint the inputSurface with each color"
	outputColors
	    do: [ :eachColor |
	        outputContext
	            sourceColorRGBA: eachColor;
	            maskSurface: inputSurface x: 0 y: 0 ]
	    separatedBy: [
	        outputContext
	            translateByX: inputSurface width
	            y: 0 ].

	^ outputSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithDeviceOffset [

	| aSurface aSquare offsetPoint surfaceWidth surfaceHeight |
	aSquare := 5 @ 5 extent: 10 @ 10.
	offsetPoint := 20 @ 10.
	surfaceWidth := (aSquare right + offsetPoint x) + 1.
	surfaceHeight := (aSquare bottom + offsetPoint y) + 1.
	
	aSurface := AeCairoImageSurface
		extent: surfaceWidth @ surfaceHeight
		format: AeCairoSurfaceFormat argb32.

	aSurface deviceOffset: offsetPoint.

	aSurface newContext
		" clear background "
		sourceColorRGB: Color yellow;
		paint;

		" mark 0@0 "
		sourceColorRGB: Color black;
		rectangleTo: 1 asPoint;
		fill;

		" draw a square "
		sourceColorRGB: Color blue;
		rectangle: aSquare;
		fill.

	self
		assert: aSurface deviceOffset
		equals: offsetPoint.

	^ aSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithDeviceScale [

	| aSurface aSquare scalePoint surfaceWidth surfaceHeight |
	aSquare := 5 @ 5 extent: 10 @ 10.
	scalePoint := 3 @ 1.2.
	surfaceWidth := (aSquare right * scalePoint x) + 1.
	surfaceHeight := (aSquare bottom * scalePoint y) + 1.
	
	aSurface := AeCairoImageSurface
		extent: surfaceWidth @ surfaceHeight
		format: AeCairoSurfaceFormat argb32.

	aSurface deviceScale: scalePoint.

	aSurface newContext
		" clear background "
		sourceColorRGB: Color yellow;
		paint;

		" mark 0@0 "
		sourceColorRGB: Color black;
		rectangleTo: 1 asPoint;
		fill;

		" draw square (that won't look as a square due
		to device scale)"
		sourceColorRGB: Color blue;
		rectangle: aSquare;
		fill.

	self
		assert: aSurface deviceScale
		equals: scalePoint.

	^ aSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithDottedCircle [
	"Cairo allows drawing strokes with dotted borders (either with circular dots, or squared dots).
	The trick is setting dash segments of length 0.0, followed by a non-zero segment.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-dash
	"

	| radius lineWidth gapBetweenDots extent aSurface dashByteArray numberOfDots perimeterOfCircle aContext |
	radius := 10.
	lineWidth := 5.
	numberOfDots := 7.
	perimeterOfCircle := Float twoPi * radius.
	gapBetweenDots := perimeterOfCircle / numberOfDots.

	extent := (radius*2 + lineWidth) asPoint.
	
	aSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.

	"set up dotted dashes"
	dashByteArray := AeCairoDoubleArray
		newFrom: { 0.0. gapBetweenDots }.

	aContext := aSurface newContext.
	aContext
		" draw background "
		sourceColorRGB: Color yellow;
		paint;
		" draw circle "
		translateBy: (lineWidth/2.0) asPoint;
		sourceColorRGB: Color black;
		lineWidth: lineWidth;
		lineCap: AeCairoCapStyle round;
		dash: dashByteArray offset: 3;
		circleRadius: radius;
		stroke.

	self assert: aContext dashes equals: dashByteArray.

	^ aSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithEmulatedRadialGradient [

	| aSurface context aPattern |
	aSurface := AeCairoImageSurface extent: 20 @ 20.
	context := aSurface newContext.
	
	context
		pushGroupWithContent: AeCairoContent alphaOnly;
		sourceColorRGBA: (Color black alpha: 0.25).
	(2 to: 10 by: 2) do: [ :radius |
		context
			circleCenterX: 10 y: 10 radius: radius;
			fill ].
	aPattern := context popGroupAsSurfacePattern.
	
	context
		sourceColorRGB: Color white;
		paint;
		sourceColorRGB: Color blue;
		mask: aPattern.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithRoundedRectangle [

	| extent aSurface aContext aRectangle |
	extent := 100 @ 50.
	aRectangle := 10 @ 10 corner: (extent x - 10) @ (extent y - 10).

	aSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.

	aContext := aSurface newContext.
	
	aContext
		sourceColorRGB: Color orange;
		paint.
	
	aContext
		roundedRectangleLeft: aRectangle left
		top: aRectangle top
		right: aRectangle right
		bottom: aRectangle bottom
		tl: aRectangle height / 2
		tr: aRectangle height
		br: 0
		bl: aRectangle height / 2.

	aContext
		lineWidth: 10;
		sourceColorRGBA: (Color blue alpha: 0.5);
		stroke.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithShadowedCircleEmulatedBuffered [
	"Emulate a Gaussian shadow on a circle using a radial gradient, using an intermediate surface."

	| radius shadowSize aShadowSurface aShadowContext aGradient mainSurface  mainContext shadowOffset extent shadowCenter position shadowColor shadowAlpha |
	radius := 15.
	shadowOffset := 2 asPoint.
	shadowSize := 4.
	position := shadowSize asPoint.
	extent := (radius + shadowSize) * 2 asPoint + shadowOffset.
	shadowCenter := position + radius.
	shadowColor := Color black.
	shadowAlpha := 0.5.

	aShadowSurface := AeCairoImageSurface
		extent: (radius + shadowSize) * 2 asPoint
		format: AeCairoSurfaceFormat a8.
	aShadowContext := aShadowSurface newContext.
	aGradient := (AeCairoRadialGradientPattern
		innerCenter: shadowCenter
		innerRadius: radius
		outerCenter: shadowCenter
		outerRadius: radius + shadowSize)
			addStopAt: 0.0 color: Color white;
			addStopAt: 0.2 color: (Color white alpha: 0.5);
			addStopAt: 1.0 color: Color transparent;
			yourself.
	aShadowContext
		source: aGradient;
		paint.
	aShadowSurface status ensureIsSuccess.


	mainSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.
	mainContext := mainSurface newContext.

	"draw background"
	mainContext
		sourceColorRGB: Color yellow;
		paint.

	"draw shadow"
	mainContext
		sourceColorRGBA: (shadowColor alpha: shadowAlpha);
		maskSurface: aShadowSurface
			x: shadowSize - shadowOffset x
			y: shadowSize - shadowOffset y.

	"draw circle"
	mainContext
		translateBy: position;
		sourceColorRGBA: Color green;
		circleRadius: radius;
		fill.

	^ mainSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithShadowedCircleEmulatedDirect [
	"Emulate a Gaussian shadow on a circle using a radial gradient."

	| radius shadowSize aGradient mainSurface  mainContext shadowOffset shadowCenter shadowColor position extent shadowAlpha |
	radius := 15.
	shadowOffset := 2 asPoint.
	shadowSize := 4.
	position := shadowSize asPoint.
	extent := (radius + shadowSize) * 2 asPoint + shadowOffset.
	shadowCenter := position + radius + shadowOffset.
	shadowColor := Color black.
	shadowAlpha := 0.5.
	
	mainSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.
	mainContext := mainSurface newContext.

	"draw background"
	mainContext
		sourceColorRGB: Color yellow;
		paint.

	"draw shadow"
	aGradient := (AeCairoRadialGradientPattern
		innerCenter: shadowCenter
		innerRadius: radius
		outerCenter: shadowCenter
		outerRadius: radius + shadowSize)
			addStopAt: 0.0 color: shadowColor;
			addStopAt: 0.2 color: (shadowColor alpha: 0.5);
			addStopAt: 1.0 color: Color transparent;
			yourself.
	mainContext
		source: aGradient;
		paintWithAlpha: shadowAlpha.

	"draw circle"
	mainContext
		translateBy: position;
		sourceColorRGBA: Color green;
		circleRadius: radius;
		fill.

	^ mainSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithSphere [
	"Emulate a sphere with a radial gradient, using an inner center different than the outer center."

	| radius center extent aSurface aContext aGradient |
	radius := 10.
	center := radius asPoint.
	extent := (radius*2) asPoint.

	aSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"paint background"
	aContext
		sourceColorRGB: Color blue muchDarker;
		paint.

	"draw sphere"
	aGradient := (AeCairoRadialGradientPattern
		innerCenter: radius / 5 @ radius
		innerRadius: radius / 5
		outerCenter: center
		outerRadius: radius * 2)
			addStopAt: 0.0 color: Color yellow;
			addStopAt: 1.0 color: Color red;
			yourself.
	aContext
		source: aGradient;
		circleRadius: radius; 
		fill.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithStraightEdgesCurve [
	"Edges of the curve are straight.
	Reference: https://github.com/memononen/nanovg/issues/650"

	| lineWidth startPoint extent aSurface aContext |
	lineWidth := 32.
	startPoint := ((lineWidth/2) + 10) @ 10.
	extent := 120 @ 100.

	aSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"paint background"
	aContext
		sourceColorRGB: Color black;
		paint.

	aContext
		sourceColorRGB: Color white;
		lineWidth: lineWidth;
		cubicCurveFrom: startPoint
			controlPoint1: startPoint + (0 @ 35.4)
			controlPoint2: startPoint + (39.4 @ 64)
			to: startPoint + (88 @ 64);
		stroke.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithStretchedIcon [

	| aSurface aContext iconForm iconSurface iconPattern horizontalScale verticalScale |
	iconForm := Smalltalk ui icons iconNamed: #classIcon.
	self assert: iconForm extent = (16@16).
	horizontalScale := 0.5.
	verticalScale := 4.0.

	iconSurface := AeCairoImageSurface fromForm: iconForm.
	iconPattern := AeCairoSurfacePattern surface: iconSurface.
	"See Cairo API doc: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-matrix"
	iconPattern matrix: (AeCairoMatrix newScalingByX: 1 / horizontalScale y: 1 / verticalScale).

	"Create a surface"
	aSurface := AeCairoImageSurface
		extent: (iconForm width * horizontalScale) asInteger @ (iconForm height * verticalScale) asInteger
		format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.
	
	"Paint background"
	aContext
		sourceColorRGB: Color orange;
		paint.

	"Draw a the icon"
	aContext
		source: iconPattern;
		paint.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithText [

	| fontSize string surfaceSize aSurface aContext aFTLibrary aFTFace aFontFace aScaledFont |
	fontSize := 12.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 150 @ (fontSize*1.3).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.

	"Draw glyphs"
	aContext
		sourceColorRGB: Color paleGreen;
		paint;
		translateByX: 5 y: fontSize;
		sourceColorRGB: Color blue;
		scaledFont: aScaledFont;
		showGlyphs: (aScaledFont glyphArrayForString: ''); "Draws nothing"
		showGlyphs: (aScaledFont glyphArrayForString: string).

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithTextPixelated [
	"The trick is: 
	- Create special font options with full hinting and without anti-aliasing
	- Draw the text in a group (i.e not directly on the surface)
	- Convert the group to a pattern, to customize its filter and matrix
	- Finally, paint the pattern on the surface"

	| zoom fontSize surfaceSize string aSurface aContext aFTLibrary aFTFace aScaledFont aGlyphArray aFontOptions aFontFace aPattern |
	fontSize := 17.
	zoom := 2.
	string := 'aeiou'.
	surfaceSize := (40 @ (fontSize*1.3)) * zoom.
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up aScaleFont"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	aFontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_NONE;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_FULL;
		yourself.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: aFontOptions.

	"Create text glyphs to draw"	
	aGlyphArray := aScaledFont glyphArrayForString: string.

	"Draw glyphs"
	aPattern := aContext
		pushGroup;
			translateByX: 2 y: fontSize;
			sourceColorRGB: Color blue;
			scaledFont: aScaledFont;
			showGlyphs: aGlyphArray;
		popGroupAsSurfacePattern.
	aPattern
		filter: AeCairoSamplingFilter CAIRO_FILTER_NEAREST;
		matrix: (AeCairoMatrix newScalingBy: (1.0/zoom) asPoint).

	aContext
		sourceColorRGB: Color paleGreen;
		paint;
		source: aPattern;
		paint.

	^ aSurface
]
