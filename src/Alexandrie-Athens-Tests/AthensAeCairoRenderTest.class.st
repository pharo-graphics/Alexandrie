Class {
	#name : #AthensAeCairoRenderTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Athens-Tests'
}

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

{ #category : #tests }
AthensAeCairoRenderTest >> surfaceWith01Rectangle [

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
AthensAeCairoRenderTest >> surfaceWith02RectanglePath [

	| surface path |
	surface := AthensAeCairoSurface extent: 40 asPoint. 

	path :=  surface createRectanglePath: (0@ 0 corner: 20@ 20).
	
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
AthensAeCairoRenderTest >> surfaceWith03Lines [

	| surface |
	surface := AthensAeCairoSurface extent: 110 asPoint. 

	surface drawDuring: [ :canvas |
		canvas setPaint: Color blue.

		canvas drawShape:
			(canvas createPath: [ :path |
				path
					absolute;
					lineTo: 50@0;
					lineTo: 50@50;
					lineTo: 0@100 ]) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surfaceWith04HollowRectangle [
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
					moveTo: 10@10;
					lineTo: 10@40;
					lineTo: 40@40;
					lineTo: 40@10
			]) ].

	^ surface
]

{ #category : #tests }
AthensAeCairoRenderTest >> surfaceWith05RepeatCurvedPath [

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
