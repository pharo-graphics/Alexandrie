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

{ #category : #accessing }
AeCairoExamplesRenderTest >> resources [

	^ { AeFTLibraryResource }
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithAllOperators [
	"Catalog of cairo's compositing operators.

	See: https://www.cairographics.org/operators/"

	| operators fontSize rectangleExtent rectangleOffset margin rowHeight aSurface aContext aFTFace aFontFace |
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
	aFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	aFontFace := aFTFace newCairoFontFace.
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
AeCairoExamplesRenderTest >> surfaceWithClearColorThatKeepsState [

	| extent aSurface aRectangle |
	extent := 40 @ 20.
	aRectangle := 5 @ 5 corner: (extent x - 5) @ (extent y - 5).

	aSurface := AeCairoImageSurface
		extent: extent
		format: AeCairoSurfaceFormat argb32.

	"Note that blue is restored after clear"
	aSurface newContextDo: [ :aContext |
		aContext rectangle: aRectangle.
		aContext sourceColor: Color blue.
		aContext clearColor: Color orange.
		aContext fill ].

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithColoredIcons [

	| inputSurface outputColors outputSurface outputContext |
	inputSurface := AeCairoImageSurface newFromPngFileAt: AeFilesystemResources removeIconPNG.

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
	            maskSurface: inputSurface ]
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
		sourcePattern: aMeshPattern;
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

	| radius strokeSize gapBetweenDots aSurface dashByteArray numberOfDots perimeterOfCircle aContext |
	radius := 11.
	strokeSize := 9.
	numberOfDots := 5.
	perimeterOfCircle := Float twoPi * radius.
	gapBetweenDots := perimeterOfCircle / numberOfDots.

	aSurface := AeCairoImageSurface
		            extent: 2 * (radius + strokeSize) asPoint
		            format: AeCairoSurfaceFormat argb32.

	"set up dotted dashes"
	dashByteArray := AeFFIDoubleArray newFrom: {
			                 0.0.
			                 gapBetweenDots }.

	aContext := aSurface newContext.

	"paint background"
	aContext
		sourceColor: Color yellow;
		paint.

	"set a circle as path"
	aContext
		translateBy: strokeSize asPoint;
		circleRadius: radius;
		strokeDashPattern: dashByteArray offset: perimeterOfCircle / 4.
	self assert: aContext hasCurrentPoint.

	"stroke with black squared dots"
	aContext
		sourceColor: Color black;
		useStrokeCapSquare;
		strokeSize: strokeSize;
		strokePreservingPath.
	self assert: aContext hasStrokeDashPattern.
	self assert: aContext strokeDashPattern equals: dashByteArray.
	self assert: aContext hasCurrentPoint.

	"stroke with green circle dots"
	aContext
		sourceColor: Color green;
		strokeSize: strokeSize / 1.5;
		useStrokeCapRound;
		strokePreservingPath.
	self assert: aContext hasStrokeDashPattern.
	self assert: aContext strokeDashPattern equals: dashByteArray.

	"stroke red without dashes"
	aContext
		sourceColor: Color red;
		strokeSize: 1;
		resetStrokeDashPattern;
		stroke.
	self deny: aContext hasStrokeDashPattern.
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
			circleCenter: 10@10 radius: radius;
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

	| aSurface aMeshPattern |
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

	aSurface := AeCairoImageSurface extent: 100 @ 100.
	aSurface newContextDo: [ :aContext |
		aContext
			sourceColor: Color yellow;
			paint;
			sourcePattern: aMeshPattern;
			paint ].

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithPixelatedIcon [

	| iconSurface iconPattern scale aSurface aContext |
	iconSurface := AeCairoImageSurface newFromPngFileAt: AeFilesystemResources removeIconPNG.
	iconPattern := AeCairoSurfacePattern surface: iconSurface.
	scale := 5.0.

	"Create a surface with yellow background"
	aSurface := AeCairoImageSurface
		            extent: (iconSurface width * scale) asInteger * 2
							@ (iconSurface height * scale) asInteger
		            format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.
	aContext
		sourceColor: Color yellow;
		paint.

	"Draw a pixelated icon"
	iconPattern filter: AeCairoSamplingFilter nearest.
	aContext
		scaleByX: scale y: scale;
		sourcePattern: iconPattern;
		rectangleTo: iconSurface extent * scale;
		fill.

	"Draw a blurred icon"
	iconPattern
		filter: AeCairoSamplingFilter bilinear;
		matrix: (AeCairoMatrix newTranslationByX: iconSurface width negated y: 0).
	aContext
		translateByX: iconSurface width y: 0;
		rectangleTo: iconSurface extent;
		fill.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithRotationAboutCenter [
	"Draw an asterisk with multiple lines rotated and scaled about the surface center."

	| extent pivot mainSurface mainContext aMatrix numberOfLines |
	extent := 40 @ 30.
	pivot := extent / 2.
	numberOfLines := 5.

	mainSurface :=
		AeCairoImageSurface
			extent: extent
			format: AeCairoSurfaceFormat argb32.
	mainContext := mainSurface newContext.

	aMatrix := AeCairoMatrix newIdentity.
	(Color wheel: numberOfLines) do: [ :eachColor |
		"Each iteration, rotate and scale a bit more"
		aMatrix
			rotateByRadians: Float twoPi / numberOfLines
			center: pivot.
		aMatrix
			scaleBy: 1.2 @ 1.2
			center: pivot.

		mainContext
			matrix: aMatrix;
			sourceColor: (eachColor alpha: 0.75);
			moveTo: pivot - 5;
			lineTo: pivot + 5;
			stroke ].

	^ mainSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithRotationByQuadrantsOnContext [

	| extent mainSurface mainContext m |
	extent := 10 asPoint.

	mainSurface :=
		AeCairoImageSurface
			extent: extent * 2
			format: AeCairoSurfaceFormat rgb24.
	mainContext := mainSurface newContext.

	m := AeCairoMatrix newIdentity.
	m beRotationByQuadrants: 1 around: extent.
	mainContext
		matrix: m;	
		sourceColor: Color red;
		rectangleTo: extent;
		fill.

	m beRotationByQuadrants: 2 around: extent.
	mainContext
		matrix: m;
		sourceColor: Color green;
		rectangleTo: extent;
		fill.

	m beRotationByQuadrants: 3 around: extent.
	mainContext
		matrix: m;
		sourceColor: Color blue;
		rectangleTo: extent;
		fill.

	m beRotationByQuadrants: 4 around: extent.
	mainContext
		matrix: m;
		sourceColor: Color yellow;
		rectangleTo: extent;
		fill.

	^ mainSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithRotationByQuadrantsOnSource [

	| aSurface pivot mainSurface mainContext m |
	aSurface := AeCairoImageSurface newFromPngFileAt: AeFilesystemResources removeIconPNG.
	pivot := aSurface extent*1.1.

	"Paint the text surface 4 times"
	mainSurface :=
		AeCairoImageSurface
			extent: pivot * 2
			format: AeCairoSurfaceFormat argb32.
	mainContext := mainSurface newContext.
	mainContext sourceColor: Color paleYellow; paint.

	"Shared by all quadrants"
	mainContext sourceSurface: aSurface x: 0.0 y: 0.0.
	m := AeCairoMatrix newIdentity.

	m beRotationByQuadrants: 0 around: pivot.
	mainContext source matrix: m.
	mainContext paint.

	m beRotationByQuadrants: 1 around: pivot.
	mainContext source matrix: m.
	mainContext paintWithAlpha: 0.8.

	m beRotationByQuadrants: 2 around: pivot.
	mainContext source matrix: m.
	mainContext paintWithAlpha: 0.6.

	m beRotationByQuadrants: 3 around: pivot.
	mainContext source matrix: m.
	mainContext paintWithAlpha: 0.4.

	^ mainSurface
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
		strokeSize: 10;
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
		center: shadowCenter
		innerRadius: radius
		outerRadius: radius + shadowSize)
			addStopAt: 0.0 color: Color white;
			addStopAt: 0.2 color: (Color white alpha: 0.5);
			addStopAt: 1.0 color: Color transparent;
			yourself.
	aShadowContext
		sourcePattern: aGradient;
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
			at: position - shadowOffset.

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
		center: shadowCenter
		innerRadius: radius
		outerRadius: radius + shadowSize)
			addStopAt: 0.0 color: shadowColor;
			addStopAt: 0.2 color: (shadowColor alpha: 0.5);
			addStopAt: 1.0 color: Color transparent;
			yourself.
	mainContext
		sourcePattern: aGradient;
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
		sourcePattern: aGradient;
		circleRadius: radius; 
		fill.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithStraightEdgesCurve [
	"Edges of the curve are straight.
	Reference: https://github.com/memononen/nanovg/issues/650"

	| strokeSize startPoint extent aSurface aContext |
	strokeSize := 32.
	startPoint := ((strokeSize/2) + 10) @ 10.
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
		strokeSize: strokeSize;
		cubicCurveFrom: startPoint
			controlPoint1: startPoint + (0 @ 35.4)
			controlPoint2: startPoint + (39.4 @ 64)
			to: startPoint + (88 @ 64);
		stroke.

	^ aSurface
]

{ #category : #tests }
AeCairoExamplesRenderTest >> surfaceWithStretchedIcon [

	| aSurface aContext iconSurface iconPattern horizontalScale verticalScale |
	horizontalScale := 0.5.
	verticalScale := 2.0.

	iconSurface := AeCairoImageSurface newFromPngFileAt: AeFilesystemResources removeIconPNG.
	iconPattern := AeCairoSurfacePattern surface: iconSurface.
	"See Cairo API doc: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-matrix"
	iconPattern matrix: (AeCairoMatrix newScalingByX: 1 / horizontalScale y: 1 / verticalScale).

	"Create a surface"
	aSurface := AeCairoImageSurface
		extent: (iconSurface width * horizontalScale) asInteger @ (iconSurface height * verticalScale) asInteger
		format: AeCairoSurfaceFormat rgb24.
	aContext := aSurface newContext.
	
	"Paint background"
	aContext
		sourceColor: Color orange;
		paint.

	"Draw a the icon"
	aContext
		sourcePattern: iconPattern;
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
		strokeSize: 3;
		sourceColor: Color white;
		useStrokeJoinRound; 
		strokePreservingPath;
		sourceColor: Color purple;
		fill.

	^ aSurface
]
