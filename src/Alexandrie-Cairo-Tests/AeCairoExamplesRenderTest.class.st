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
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
AeCairoExamplesRenderTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithAllOperators [
	"Catalog of cairo's compositing operators.

	See: https://www.cairographics.org/operators/"

	| operators fontSize rectangleExtent rectangleOffset margin rowHeight aSurface aContext aFTLibrary aFTFace aFontFace |
	operators := AeCairoOperator allValues.
	margin := 3.
	fontSize := 8.
	rectangleExtent := 50 @ fontSize.
	rectangleOffset := (rectangleExtent x // 4) @ margin.
	rowHeight := rectangleExtent y + rectangleOffset y + margin.

	aSurface := AeCairoImageSurface
		extent: 200 @ (rowHeight * operators size)
		format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up text"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aContext
		fontFace: aFontFace;
		fontSize: fontSize.

	operators do: [ :eachOperator |

		"Draw a row at current position"
		aContext paintGroupWith: [

			"First rectangle"
			aContext
				rectangle: (0@0 extent: rectangleExtent);
				sourceColor: (Color red alpha: 0.6);
				fill.

			"Second"
			aContext
				rectangle: (rectangleOffset extent: rectangleExtent);
				sourceColor: (Color blue alpha: 0.6);
				operator: eachOperator;
				fill.

			"Label"
			aContext
				translateByX: rectangleOffset x + rectangleExtent x + margin
					y: fontSize;
				sourceColor: Color black;
				setOperatorOver;
				showText: eachOperator item asString ].

		"Prepare for next row"
		aContext translateByX: 0 y: rowHeight ].

	^ aSurface
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
	            sourceColor: eachColor;
	            maskSurface: inputSurface x: 0 y: 0 ]
	    separatedBy: [
	        outputContext
	            translateByX: inputSurface width
	            y: 0 ].

	^ outputSurface
]

{ #category : #'tests - mesh gradient' }
AeCairoExamplesRenderTest >> surfaceWithCoonsPatch [
	"See: https://blogs.igalia.com/dpino/2020/06/11/renderization-of-conic-gradients/"

	| aSurface aContext aMeshPattern |
	aSurface := AeCairoImageSurface extent: 150 @ 110.
	aContext := aSurface newContext.

	aMeshPattern := AeCairoMeshPattern new.
	aMeshPattern
		beginPatch;
		moveTo: 45 @ 12;
		curveVia: 69 @ 24 via: 173 @ -15 to: 115 @ 50;
		curveVia: 127 @ 66 via: 174 @ 47 to: 148 @ 104;
		curveVia: 65 @ 58 via: 70 @ 69 to: 18 @ 103;
		curveVia: 42 @ 43 via: 63 @ 45 to: 45 @ 12;
		cornerColors: {
			Color red.
			Color green.
			Color blue.
			Color red alpha: 0.5 };
		endPatch.

	aContext
		sourceColor: Color yellow;
		paint;
		translateByX: -15 y: 0;
		source: aMeshPattern;
		paint.

	^ aSurface
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
		sourceColor: Color yellow;
		paint;

		" mark 0@0 "
		sourceColor: Color black;
		rectangleTo: 1 asPoint;
		fill;

		" draw a square "
		sourceColor: Color blue;
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
		sourceColor: Color yellow;
		paint;

		" mark 0@0 "
		sourceColor: Color black;
		rectangleTo: 1 asPoint;
		fill;

		" draw square (that won't look as a square due
		to device scale)"
		sourceColor: Color blue;
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

	| radius lineWidth gapBetweenDots aSurface dashByteArray numberOfDots perimeterOfCircle aContext |
	radius := 11.
	lineWidth := 9.
	numberOfDots := 5.
	perimeterOfCircle := Float twoPi * radius.
	gapBetweenDots := perimeterOfCircle / numberOfDots.
	
	aSurface := AeCairoImageSurface
		extent: 2 * (radius + lineWidth) asPoint
		format: AeCairoSurfaceFormat argb32.

	"set up dotted dashes"
	dashByteArray := AeFFIDoubleArray
		newFrom: { 0.0. gapBetweenDots }.

	aContext := aSurface newContext.

	"paint background"
	aContext
		sourceColor: Color yellow;
		paint.

	"set a circle as path"
	aContext
		translateBy: lineWidth asPoint;
		circleRadius: radius;
		dash: dashByteArray offset: perimeterOfCircle / 4.
	self assert: aContext hasCurrentPoint.

	"stroke with black squared dots"
	aContext
		sourceColor: Color black;
		lineCap: AeCairoCapStyle square;
		lineWidth: lineWidth;
		strokePreserve.
	self assert: aContext dashes equals: dashByteArray.
	self assert: aContext hasCurrentPoint.

	"stroke with green circle dots"
	aContext
		sourceColor: Color green;
		lineWidth: lineWidth/1.5;
		lineCap: AeCairoCapStyle round;
		strokePreserve.
	self assert: aContext dashes equals: dashByteArray.

	"stroke red without dashes"
	aContext
		sourceColor: Color red;
		lineWidth: 1;
		dashDisable;
		stroke.
	self assert: aContext dashes equals: #().
	self deny: aContext hasCurrentPoint.

	^ aSurface

]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithEmulatedRadialGradient [

	| aSurface context aPattern |
	aSurface := AeCairoImageSurface extent: 20 @ 20.
	context := aSurface newContext.
	
	context
		pushGroupWithContent: AeCairoContent alphaOnly;
		sourceColor: (Color black alpha: 0.25).
	(2 to: 10 by: 2) do: [ :radius |
		context
			circleCenterX: 10 y: 10 radius: radius;
			fill ].
	aPattern := context popGroupAsSurfacePattern.
	
	context
		sourceColor: Color white;
		paint;
		sourceColor: Color blue;
		mask: aPattern.

	^ aSurface
]

{ #category : #'tests - mesh gradient' }
AeCairoExamplesRenderTest >> surfaceWithGouraudBasedTriangle [

	| aSurface aContext aMeshPattern |
	aSurface := AeCairoImageSurface extent: 100 @ 100.
	aContext := aSurface newContext.

	aMeshPattern := AeCairoMeshPattern new.
	aMeshPattern
		beginPatch;
		moveTo: 50 @ 0;
		lineTo: 100 @ 100;
		lineTo: 0 @ 100;
		cornerColors: {
			Color red alpha: 0.5.
			Color green.
			Color blue };
		endPatch.

	aContext
		sourceColor: Color yellow;
		paint;
		source: aMeshPattern;
		paint.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithPixelatedIcon [

	| iconForm iconSurface iconPattern scale aSurface aContext |
	iconForm := Smalltalk ui icons iconNamed: #removeIcon.
	iconSurface := AeCairoImageSurface fromForm: iconForm.
	iconPattern := AeCairoSurfacePattern surface: iconSurface.
	scale := 5.0.

	"Create a surface with yellow background"
	aSurface := AeCairoImageSurface
		            extent: (iconForm width * scale) asInteger * 2
							@ (iconForm height * scale) asInteger
		            format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.
	aContext
		sourceColor: Color yellow;
		paint.

	"Draw a pixelated icon"
	iconPattern filter: AeCairoSamplingFilter nearest.
	aContext
		scaleByX: scale y: scale;
		source: iconPattern;
		rectangleTo: iconForm extent * scale;
		fill.

	"Draw a blurred icon"
	iconPattern
		filter: AeCairoSamplingFilter bilinear;
		matrix: (AeCairoMatrix newTranslationByX: iconForm width negated y: 0).
	aContext
		translateByX: iconForm width y: 0;
		rectangleTo: iconForm extent;
		fill.

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
		sourceColor: Color orange;
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
		sourceColor: (Color blue alpha: 0.5);
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
		format: AeCairoSurfaceFormat argb32.
	mainContext := mainSurface newContext.

	"draw background"
	mainContext
		sourceColor: Color yellow;
		paint.

	"draw shadow"
	mainContext
		sourceColor: (shadowColor alpha: shadowAlpha);
		maskSurface: aShadowSurface
			x: shadowSize - shadowOffset x
			y: shadowSize - shadowOffset y.

	"draw circle"
	mainContext
		translateBy: position;
		sourceColor: Color green;
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
		sourceColor: Color yellow;
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
		sourceColor: Color green;
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
		sourceColor: Color blue muchDarker;
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
		sourceColor: Color black;
		paint.

	aContext
		sourceColor: Color white;
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
		sourceColor: Color orange;
		paint.

	"Draw a the icon"
	aContext
		source: iconPattern;
		paint.

	^ aSurface
]

{ #category : #'tests - text' }
AeCairoExamplesRenderTest >> surfaceWithText [

	| fontSize string surfaceSize aSurface aContext aFTLibrary aFTFace aScaledFont |
	fontSize := 12.
	"Get Lorem Ipsum without last cr character"
	string := (String loremIpsum: 28) allButLast.
	surfaceSize := 150 @ (fontSize*1.3).
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Paint background"
	aContext
		sourceColor: Color paleGreen;
		paint.
	
	"Set up scaled font in the context"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	aContext
		fontFace: (AeCairoFreetypeFontFace newForFace: aFTFace);
		fontSize: fontSize.
	aScaledFont := aContext scaledFont.

	"Draw text"
	aContext
		translateByX: 5 y: fontSize;
		sourceColor: Color blue;
		scaledFont: aScaledFont;
		showGlyphs: (aScaledFont glyphArrayForString: ''); "Draws nothing"
		showGlyphs: (aScaledFont glyphArrayForString: string).

	^ aSurface
]

{ #category : #'tests - text' }
AeCairoExamplesRenderTest >> surfaceWithTextAsPath [

	| fontSize string surfaceSize aSurface aContext aFTLibrary aFTFace aFontFace glyphArray debugScaledFont |

	fontSize := 25.
	string := 'Hola'.
	surfaceSize := 60 @ 30.
	aSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	"Set up"
	aFTLibrary := AeFTLibrary newInitialized.
	50 milliSeconds wait.
	aFTFace := AeSourceSansPro_Bold firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aContext
		sourceColor: Color paleGreen;
		paint;
		translateByX: 4 y: fontSize;
		fontFace: aFontFace;
		fontSize: fontSize.

	"Add glyphs to path"
	glyphArray := aContext scaledFont glyphArrayForString: string.
	aContext appendGlyphsPath: glyphArray.

	"Draw dashed stroke using the path"
	aContext
		sourceColor: Color blue;
		dash: (AeFFIDoubleArray newFrom: { 7. 1 }) offset: 3;
		lineWidth: 1.5;
		stroke.



	"Debugging a random failure..."
	Stdio stdout
		<< #surfaceWithTextAsPath; lf;
		<< (aContext glyphExtentsOf: glyphArray) asString; lf.
	debugScaledFont := aFontFace 
		newScaledFontWithFontMatrix: (AeCairoMatrix newScalingBy: fontSize asPoint)
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.
	Stdio stdout << (debugScaledFont glyphExtentsOf: glyphArray) asString; lf.
	glyphArray := debugScaledFont glyphArrayForString: string.
	Stdio stdout << (debugScaledFont glyphExtentsOf: glyphArray) asString; lf.
	
	
	
	
	^ aSurface
]

{ #category : #'tests - text' }
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
		antialias: AeCairoAntialias none;
		hintStyle: AeCairoHintStyle full;
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
			sourceColor: Color blue;
			scaledFont: aScaledFont;
			showGlyphs: aGlyphArray;
		popGroupAsSurfacePattern.
	aPattern
		filter: AeCairoSamplingFilter nearest;
		matrix: (AeCairoMatrix newScalingBy: (1.0/zoom) asPoint).

	aContext
		sourceColor: Color paleGreen;
		paint;
		source: aPattern;
		paint.

	^ aSurface
]

{ #category : #'tests - text' }
AeCairoExamplesRenderTest >> surfaceWithToyAPISelectFontSlantWeight [
	"Use `AeCairoContext>>selectFont:slant:weight:`, which cairo documentation considers 'toy API'."

	| string fontSize aSurface aContext |
	string := 'Ae'.
	fontSize := 25.
	aSurface := AeCairoImageSurface
		  extent: 34 @ 30
		  format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.

	"Draw outlined text with toy font selection"
	aContext
		selectFont: '@cairo:' "internal font for tests"
			slant: AeCairoFontSlant normal
			weight: AeCairoFontWeight bold;
		fontSize: fontSize;
		translateByX: 2 y: fontSize;
		appendTextPath: string;
		lineWidth: 3;
		sourceColor: Color white;
		useLineJoinRound; 
		strokePreserve;
		sourceColor: Color purple;
		fill.

	^ aSurface
]

{ #category : #'tests - text' }
AeCairoExamplesRenderTest >> surfaceWithToyAPIShowText [
	"Use `AeCairoContext>>#showText:`, which cairo documentation considers 'toy API'."

	| string fontSize aSurface aContext aFTLibrary aFTFace aFontFace |
	string := 'Hï'.
	fontSize := 25.
	aSurface := AeCairoImageSurface
		  extent: 30 @ 30
		  format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.

	"Set up a font"
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Bold firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.

	aContext
		fontFace: aFontFace;
		fontSize: fontSize;
		sourceColor: Color white;
		translateByX: 2 y: fontSize;
		showText: string.

	^ aSurface
]
