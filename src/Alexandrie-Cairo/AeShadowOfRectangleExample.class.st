Class {
	#name : #AeShadowOfRectangleExample,
	#superclass : #Object,
	#instVars : [
		'surfaceExtent',
		'shadowColor',
		'blurRadius',
		'gap',
		'shadowOffset',
		'aRectangle',
		'rectangleSolidColor'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #examples }
AeShadowOfRectangleExample class >> example1 [

	| anExample boxBlurSurface gradientsSurface |
	anExample := self new.
	[ boxBlurSurface := anExample surfaceWithBoxBlurShadow ] timeToRun asMilliSeconds traceCr.
	[ gradientsSurface := anExample surfaceWithGradientsShadow ] timeToRun asMilliSeconds traceCr.
	
	boxBlurSurface inspectWithLabel: 'Box blur'.
	gradientsSurface inspectWithLabel: 'Gradient emulation'.

]

{ #category : #initialization }
AeShadowOfRectangleExample >> initialize [

	super initialize.
	
	shadowColor := Color blue alpha: 0.75.
	shadowOffset := 15 asPoint.
	blurRadius := 70.

	surfaceExtent := 1000 @ 500.
	gap := (blurRadius * 2) asPoint.
	aRectangle := gap extent: surfaceExtent - (gap * 2).
	rectangleSolidColor := Color green.

]

{ #category : #building }
AeShadowOfRectangleExample >> surfaceWithBoxBlurShadow [

	| shadowSurface shadowGap mainSurface |
	shadowSurface := AeCairoImageSurface
		extent: surfaceExtent
		format: AeCairoSurfaceFormat a8.

	shadowGap := blurRadius * 3/2.
	shadowSurface newContext
		sourceColor: Color black;
		translateBy: shadowGap asPoint;
		rectangleTo: aRectangle extent;
		fill.
	shadowSurface flush.

	AeCairoA8FastGaussianBlurFilter new
		surface: shadowSurface;
		applyRadius: blurRadius.

	mainSurface := AeCairoImageSurface
		  extent: surfaceExtent
		  format: AeCairoSurfaceFormat argb32.

	mainSurface newContext
		sourceColor: Color white;
		paint;
		translateBy: aRectangle origin;

		sourceColor: shadowColor;
		maskSurface: shadowSurface
			x: shadowOffset x - shadowGap
			y: shadowOffset y - shadowGap;
			
		sourceColor: rectangleSolidColor;
		rectangleTo: aRectangle extent;
		fill.
	
	^ mainSurface
]

{ #category : #building }
AeShadowOfRectangleExample >> surfaceWithGradientsShadow [

	| aSurface aContext shadowRect |
	aSurface := AeCairoImageSurface
		extent: surfaceExtent
		format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	aContext
			sourceColor: Color white;
			paint;
			translateBy: shadowOffset.

	self flag: #todo. "review coefficient"
	shadowRect := aRectangle insetBy: blurRadius/1.5.
	AeCairoGradientShadowFilter new
		paintFor: shadowRect
		blurRadius: blurRadius * 1.5
		color: shadowColor
		on: aContext.

	aContext
		rectangle: shadowRect;
		sourceColor: shadowColor;
		fill.

	aContext
		translateBy: shadowOffset negated;
		rectangle: aRectangle;
		sourceColor: rectangleSolidColor;
		fill.

	^ aSurface
]
