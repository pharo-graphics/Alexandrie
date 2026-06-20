Class {
	#name : #AthensAeCairoRenderTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #hooks }
AthensAeCairoRenderTest class >> allFormSelectors [

	^ self selectors select: [ :each | each beginsWith: 'surface' ]
]

{ #category : #convenience }
AthensAeCairoRenderTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AthensAeCairoRenderTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
AthensAeCairoRenderTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #hooks }
AthensAeCairoRenderTest >> expectedFormsDirectory [

	^ AeFilesystemResources testsDirectory / 'athens' / 'basic'
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface01Rectangle [

	| surface |
	surface := AthensAeCairoSurface extent: 100 asPoint. 

	surface drawDuring: [ :canvas |
		surface clear.
		canvas pathTransform
			translateX: 30 Y: 30;
			rotateByDegrees: 35.
		canvas
			setPaint: Color red;
			setShape: (-20 @ -20 corner: 20 @ 20);
			draw.
		canvas
			setStrokePaint: Color black;
			setShape: (-20 @ -20 corner: 20 @ 20);
			draw ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface02RectanglePath [

	| surface path |
	surface := AthensAeCairoSurface extent: 40 asPoint. 

	path := surface createRectanglePath: (0@ 0 corner: 20@ 20).
	
	surface drawDuring: [ :canvas |
		surface clear: Color white.
		
		canvas pathTransform translateX: 5 Y: 5.
		canvas
			setPaint: Color red;
			drawShape: path.

		canvas pathTransform translateX: 5 Y: 5.
		canvas
			setPaint: Color blue;
			drawShape: path ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface03StrightLines [

	| surface |
	surface := AthensAeCairoSurface extent: 55 @ 110. 

	surface drawDuring: [ :canvas |
		surface clear: Color orange.
		canvas setPaint: Color blue.

		canvas drawShape:
			(canvas createPath: [ :path |
				path
					absolute;
					moveTo: 5@5;
					hLineTo: 50;
					vLineTo: 50;
					relative;
					lineTo: -45 @ 50 ]) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface04HollowRectangle [
	"Draw a hollow rectangle (frame) using lineTo/moveTo commands,
 	 with path, consisting of two contours: outer and inner one.

	 Note how #moveTo: command implicitly starts new contour
	 when inssued in the middle of command chain."

	| surface |
	surface := AthensAeCairoSurface extent: 100 asPoint. 

	surface drawDuring: [:canvas |
		surface clear: Color paleOrange.

		canvas setPaint: Color blue.

		canvas drawShape: (
			canvas createPath: [:path |
				path
					absolute;
					lineTo: 50@0;
					lineTo: 50@50;
					lineTo: 0@50;
					moveTo: 5@10;
					lineTo: 5@40;
					lineTo: 40@40;
					lineTo: 40@10
			]) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface05RepeatCurvedPath [

	| steps extent surface colorWheel path |
	steps := 1000.
	extent := 400 asPoint.
	surface := AthensAeCairoSurface extent: extent. 
	colorWheel := Color wheel: 10.

	surface drawDuring: [ :canvas |
		canvas pathTransform
			translateBy: extent / 2;
			scaleBy: 5.5.

		path := canvas createPath: [ :pathBuilder |
			pathBuilder
				absolute;
				moveTo: -25 @ -25;
				curveVia: 25@ -25 to: 25@25;
				curveVia: -25@25 to: -25@ -25 ].

		1 to: steps do: [:i |
			canvas pathTransform restoreAfter: [

				canvas pathTransform
					rotateByDegrees: i * 5;
					scaleBy: (1 - (i / steps)).
	
				canvas
					setPaint: (colorWheel at: 1 + (i \\ colorWheel size));
					drawShape: path.
				
				(canvas setStrokePaint: Color black) width: 0.2.
				canvas drawShape: path ] ]
		].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface06LinearGradient [

	| surface gradientPaint stroke |
	surface := AthensAeCairoSurface extent: 100 @ 150.

	gradientPaint := surface
		createLinearGradient: { 0->Color red. 1->Color green }
		start: 0@0
		stop: 50@50.

	surface drawDuring: [ :canvas |
		canvas setPaint: gradientPaint.
		canvas drawShape: (0@0 corner: 50@50).

		canvas pathTransform
			translateX: 50 Y: 50;
			rotateByDegrees: 45.
		stroke := canvas setStrokePaint: gradientPaint.
		stroke width: 20.
		canvas drawShape: (0@0 corner: 30@30) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface07RadialGradient [

	| surface gradientPaint stroke |
	surface := AthensAeCairoSurface extent: 100 @ 100.

	gradientPaint := surface
		createRadialGradient: { 0->Color red. 1->Color green }
		center: 50@50
		radius: 100.

	surface drawDuring: [ :canvas |
		canvas setPaint: gradientPaint.
		canvas drawShape: (0@0 corner: 50@50).

		canvas pathTransform
			translateX: 50 Y: 50;
			rotateByDegrees: 45.
		stroke := canvas setStrokePaint: gradientPaint.
		stroke width: 20.
		canvas drawShape: (0@0 corner: 30@30) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface08FormPaint [

	| surface stroke form formPaint |
	surface := AthensAeCairoSurface extent: 100 @ 100.

	form := Form extent: 8@6 depth: 32.
	form getCanvas fillRectangle: (0@0 corner: 4@3) color: Color red.
	form getCanvas fillRectangle: (4@3 corner: 8@6) color: Color green.
	formPaint := surface createFormPaint: form.
	formPaint repeat.
	
	surface drawDuring: [ :canvas |
		canvas setPaint: formPaint.
		canvas drawShape: (0@0 corner: 50@50).

		canvas pathTransform
			translateX: 50 Y: 50;
			rotateByDegrees: 45.
		stroke := canvas setStrokePaint: formPaint.
		stroke width: 20.
		canvas drawShape: (0@0 corner: 30@30) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface09Clip [

	| surface |
	surface := AthensAeCairoSurface extent: 80 @ 80.

	surface drawDuring: [ :canvas |
		surface clear.
		canvas pathTransform loadIdentity.
		canvas setPaint: Color blue.
		canvas drawShape: (0@0 corner: 100@ 100).

		canvas pathTransform translateX: -10 Y: -10.
		canvas clipBy: (20@20 corner: 80@80) during: [
			canvas pathTransform
				translateX: 20 Y: 20;
				rotateByDegrees: -20.
			canvas setPaint: Color red.
			canvas drawShape: (0@0 corner: 100@100).
		
			canvas clipBy: (20@20 corner: 80@80) during: [
				canvas pathTransform translateX: 20 Y: 20.
				canvas setPaint: Color green.
				canvas drawShape: (0@0 corner: 100@ 100) ] ]
		].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface10Text [

	| aString font surface |
	aString := 'Hello Athens!'.

	font := LogicalFont
		familyName: 'Source Code Pro'
		pointSize: 30.

	"We assume Source Code Pro family is embedded"
	AeFontManager reset.
	AeFontManager current scanEmbeddedFonts.
	
	surface := AthensAeCairoSurface
		extent: (font widthOfString: aString) @ (font ascent + font descent).

	surface drawDuring: [ :canvas |
		surface clear: Color white.

		canvas
			setFont: font;
			setPaint: Color blue.

		"Translate by font's ascent, otherwise
		we will see only things below baseline."
		canvas pathTransform
			translateX: 0
			Y: font getPreciseAscent.

		canvas drawString: aString ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface11Tiger [

	| surface |
	surface := AthensAeCairoSurface extent: 300 asPoint.

	(AthensTiger on: surface) draw.

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surface12FillRule [

	| surface |
	surface := AthensAeCairoSurface extent: 120 @ 60.

	surface drawDuring: [ :canvas |
		| path |
		canvas pathTransform translateBy: 30 asPoint.

		canvas fillRuleEvenOdd.
		path := canvas createPath: [ :builder |
			builder
				absolute;
				moveTo: 30@0;
				arcCenterX: 0
					centerY: 0
					radius: 30
					startAngle: 0
					endAngle: Float twoPi;
				moveTo: 20@0;
				arcCenterX: 0
					centerY: 0
					radius: 20
					startAngle: 0
					endAngle: Float twoPi;
				close ].
		canvas setPaint: Color blue.
		canvas drawShape: path.
		canvas setStrokePaint: Color red.
		canvas drawShape: path.

		canvas pathTransform translateBy: 60 @ 0.
		canvas fillRuleWinding.
		canvas setPaint: Color blue.
		canvas drawShape: path.
		canvas setStrokePaint: Color red.
		canvas drawShape: path ].

	^ surface
]
