Class {
	#name : #AeBlurTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Blur-Tests'
}

{ #category : #hooks }
AeBlurTest class >> allFormSelectors [

	^ self selectors select: [ :each |
		  each isUnary and: [ each beginsWith: 'blurred' ] ]
]

{ #category : #convenience }
AeBlurTest class >> exportAll [
	<script: 'super exportAll' >

	super exportAll
]

{ #category : #convenience }
AeBlurTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
AeBlurTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #examples }
AeBlurTest >> blurDottedCircle [
	"Blur a circle with dotted (dashed) stroke."
	<sampleInstance>

	| circleRadius blurSigma margin aSurface strokeSize |
	circleRadius := 30.
	blurSigma := 2.5.
	margin := blurSigma.
	strokeSize := 12.

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

	AeCairoA8GaussianBlurFilter new
		surface: aSurface;
		applySigma: blurSigma.

	^ aSurface
]

{ #category : #examples }
AeBlurTest >> blurEmulation [
	<sampleInstance>

	| blurSigma offset shadowColor a input circleCenter circleRadius mainContext polygonVertices rectangle roundedRectangle roundedRectangleRadii zoom mainSurface |
	blurSigma := 10.
	offset := -20.
	shadowColor := Color black alpha: 0.5.
	a := 80.

	input := {
		[	circleCenter := a @ a.
			circleRadius := a / 2.
			AeCircleGradientBlurFilter new
				center: circleCenter
				radius: circleRadius;
				blurSigma: blurSigma
				color: shadowColor;
				drawOn: mainContext ] -> [
				mainContext
					circleCenter: circleCenter
					radius: circleRadius ].

		[	polygonVertices := { 
				0   @ 0.
				a   @ a.
				a*2 @ 0.
				a*2 @ (a*2).
				0   @ (a*2) }.
			AePolygonGradientBlurFilter new
				blurSigma: blurSigma
				color: shadowColor;
				vertices: polygonVertices;
				drawOn: mainContext ] -> [
					polygonVertices do: [ :each | mainContext lineTo: each ].
					mainContext closePath ].

		[	rectangle := 0@0 extent: (a * 2 @ a).
			AeRectangleGradientBlurFilter new
				blurSigma: blurSigma
				color: shadowColor;
				rectangle: rectangle;
				drawOn: mainContext ] -> [
					mainContext rectangle: rectangle ].

		[	roundedRectangle := 0@0 extent: (a*2 @ a).
			roundedRectangleRadii := {a/3 * 0.25. a/3 * 0.75. a/3. 0 }.
			AeRoundedRectangleGradientBlurFilter new
				blurSigma: blurSigma
				color: shadowColor;
				rectangle: roundedRectangle
				radii: roundedRectangleRadii;
				drawOn: mainContext ] -> [ 
					mainContext
						roundedRectangleLeft: roundedRectangle left
						top: roundedRectangle top 
						right: roundedRectangle right
						bottom: roundedRectangle bottom
						tl: roundedRectangleRadii first
						tr: roundedRectangleRadii second
						br: roundedRectangleRadii third
						bl: roundedRectangleRadii fourth ]
		}.

	zoom := 0.25.
	mainSurface := AeCairoImageSurface
		extent: ((input size * a * 2.5) @ 300) * zoom
		format: AeCairoSurfaceFormat rgb24.
	mainSurface deviceScaleX: zoom y: zoom.
	mainContext := mainSurface newContext.
	mainContext sourceColor: Color paleOrange; paint.
	mainContext rotateByRadians: 15 degreesToRadians.

	input do: [ :each |
		each key value. "draw shadow"
		mainContext restoreStateAfter: [
			mainContext translateByX: offset y: offset.
			each value value. "apply shape path".
			mainContext
				sourceColor: Color green translucent;
				fill ]

	 ] separatedBy: [ mainContext translateByX: a*2.5 y: 0.0 ].

	^ mainSurface
]

{ #category : #examples }
AeBlurTest >> blurTextShadow [
	"Render a text that drops a shadow."
	<sampleInstance>

	| fontSize string surfaceSize shadowSurface aFTFace mainSurface blurSigma shadowOffset |
	string := 'Hello'.
	blurSigma := 3.
	shadowOffset := 3@5.

	fontSize := 32.
	surfaceSize := 85 @ 45.
	shadowSurface := AeCairoImageSurface
		  extent: surfaceSize
		  format: AeCairoSurfaceFormat a8.
	
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: AeFTLibrary newInitialized.
	shadowSurface newContext
		translateByX: 5 y: fontSize;
		sourceColor: Color black;
		fontFace: aFTFace newCairoFontFace;
		fontSize: fontSize;
		showText: string.
	AeCairoA8GaussianBlurFilter new
		surface: shadowSurface;
		applySigma: blurSigma.

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
		fontFace: aFTFace newCairoFontFace;
		fontSize: fontSize;
		showText: string.

"	mainSurface finish. <-- Use it with PDF surface "
	^ mainSurface
]

{ #category : #hooks }
AeBlurTest >> expectedFormsDirectory [

	^ AeFilesystemResources blurDirectory
]
