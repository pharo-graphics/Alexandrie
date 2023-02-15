Class {
	#name : #AeCairoRecordingSurfaceRenderTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #convenience }
AeCairoRecordingSurfaceRenderTest class >> exportAll [
	<script: 'super exportAll' >

]

{ #category : #convenience }
AeCairoRecordingSurfaceRenderTest class >> inspectAll [
	<script: 'super inspectAll' >

]

{ #category : #convenience }
AeCairoRecordingSurfaceRenderTest class >> inspectMismatches [
	<script: 'super inspectMismatches' >

]

{ #category : #tests }
AeCairoRecordingSurfaceRenderTest >> surfaceWithBounds [

	| aRectangle aRecordingSurface targetSurface |
	aRectangle := 5 @ 10 extent: 15 @ 20.

	"Create a recording surface with:
	- transparent background (the default on its content type)
	- a rectangle with a slightly-translucent cyan stroke
	- IMPORTANT: half of the rectangle stroke is clipped as it's
	outside of the bounds of the recorded surface"
	aRecordingSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorAndAlpha
			bounds: (AeCairoRectangle origin: aRectangle origin extent: aRectangle extent).
	aRecordingSurface newContext
		sourceColorRGBA: (Color cyan alpha: 0.8);
		rectangle: aRectangle;
		lineWidth: 10; 
		stroke.

	"Replay the recorded surface on a target surface"
	targetSurface := AeCairoImageSurface
		extent: 50 asPoint
		format: AeCairoSurfaceFormat argb32.

	targetSurface newContext
		sourceColorRGB: Color blue;
		paint;

		"Draw a rectangle with the recorded surface"
		sourceSurface: aRecordingSurface
			x: 0
			y: 0;
		rectangle: aRectangle;
		fill;

		"Paint the recorded surface with offset and alpha"
		sourceSurface: aRecordingSurface
			x: aRectangle width / 2
			y: aRectangle height / 2;
		paintWithAlpha: 0.5.

	^ targetSurface
]

{ #category : #tests }
AeCairoRecordingSurfaceRenderTest >> surfaceWithNoBounds [

	| aRectangle aRecordingSurface targetSurface |
	aRectangle := 5 @ 10 extent: 15 @ 20.

	"Create a recording surface with:
	- transparent background (the default on its content type)
	- a rectangle with a slightly-translucent cyan stroke"
	aRecordingSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorAndAlpha
			bounds: AeCairoRectangle null.
	aRecordingSurface newContext
		sourceColorRGBA: (Color cyan alpha: 0.8);
		rectangle: aRectangle;
		lineWidth: 10; 
		stroke.

	"Replay the recorded surface on a target surface"
	targetSurface := AeCairoImageSurface
		extent: 50 asPoint
		format: AeCairoSurfaceFormat argb32.

	targetSurface newContext
		sourceColorRGB: Color blue;
		paint;

		"Draw a rectangle with the recorded surface.
		The fill operation clips the source by the path."
		sourceSurface: aRecordingSurface
			x: 0
			y: 0;
		rectangle: aRectangle;
		fill;

		"Paint the recorded surface with offset and alpha.
		The paint operation doesn't clip the source."
		sourceSurface: aRecordingSurface
			x: aRectangle width / 2
			y: aRectangle height / 2;
		paintWithAlpha: 0.5.

	^ targetSurface
]
