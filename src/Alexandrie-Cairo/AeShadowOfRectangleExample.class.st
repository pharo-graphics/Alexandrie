Class {
	#name : #AeShadowOfRectangleExample,
	#superclass : #Object,
	#instVars : [
		'surfaceExtent',
		'shadowColor',
		'gap',
		'shadowOffset',
		'shadowSigma',
		'rectangle',
		'rectangleColor',
		'shadowWidth'
	],
	#category : #'Alexandrie-Cairo-Extra'
}

{ #category : #initialization }
AeShadowOfRectangleExample >> initialize [

	super initialize.
	
	shadowColor := Color blue.
	shadowOffset := 20 asPoint.
	shadowSigma := 12.

	"See AeCairoA8FastGaussianBlurFilter>>#applyRadius:n:"
	shadowWidth := shadowSigma * 2.82.

	surfaceExtent := 400 @ 300.
	gap := (shadowSigma * 5) asPoint.
	rectangle := gap asIntegerPoint  extent: (surfaceExtent - (gap * 2) - shadowOffset) asIntegerPoint.
	rectangleColor := Color green alpha: 0.5.

]

{ #category : #building }
AeShadowOfRectangleExample >> inspectSurfacesToBeCompared [
	<script: 'self new inspectSurfacesToBeCompared'>

	| boxBlurSurface gradientsSurface |
	[ boxBlurSurface := self surfaceWithBoxBlurShadow ] timeToRun asMilliSeconds traceCr.
	[ gradientsSurface := self surfaceWithGradientsShadow ] timeToRun asMilliSeconds traceCr.
	
	{ boxBlurSurface. gradientsSurface } inspectWithLabel: '1 -> Box blur. 2 -> Gradient emulation'
]

{ #category : #building }
AeShadowOfRectangleExample >> surfaceWithBoxBlurShadow [
	<sampleInstance>

	| shadowSurface mainSurface |
	shadowSurface :=
		AeCairoImageSurface
			extent: surfaceExtent
			format: AeCairoSurfaceFormat a8.

	shadowSurface newContext
		sourceColor: Color black;
		translateBy: shadowWidth asPoint;
		rectangleTo: rectangle extent;
		fill.

	AeCairoA8FastGaussianBlurFilter new
		surface: shadowSurface;
		applySigma: shadowSigma.

	mainSurface := AeCairoImageSurface
		  extent: surfaceExtent
		  format: AeCairoSurfaceFormat argb32.

	mainSurface newContext
		sourceColor: Color white; paint;
		translateBy: rectangle origin;

		sourceColor: shadowColor;
		maskSurface: shadowSurface
			x: shadowOffset x - shadowWidth
			y: shadowOffset y - shadowWidth;
		
		sourceColor: rectangleColor;
		rectangleTo: rectangle extent;
		fill.
	
	^ mainSurface
]

{ #category : #building }
AeShadowOfRectangleExample >> surfaceWithGradientsShadow [
	<sampleInstance>

	| aSurface aContext shadowRect |
	aSurface := AeCairoImageSurface
		extent: surfaceExtent
		format: AeCairoSurfaceFormat argb32.
	aContext := aSurface newContext.

	aContext
		sourceColor: Color white; paint;
		translateBy: shadowOffset.

	shadowRect := rectangle insetBy: shadowWidth / 1.5.
	AeCairoGradientShadowFilter new
		paintFor: shadowRect
		blurRadius: shadowWidth * 1.5
		color: shadowColor
		on: aContext.

	aContext
		translateBy: shadowOffset negated;
		rectangle: rectangle;
		sourceColor: rectangleColor;
		fill.

	^ aSurface
]
