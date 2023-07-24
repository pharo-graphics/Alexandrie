Class {
	#name : #AeCairoConvertTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoConvertTest >> surfaceWithDeviceScaleAsARGB32ImageSurface [

	| radius center extent scale aSurface aContext |
	radius := 5.
	center := radius asPoint.
	extent := (radius*2) asPoint.
	scale := 2.0@1.2.

	aSurface := AeCairoImageSurface
		extent: extent * scale
		format: AeCairoSurfaceFormat rgb24.
	aSurface deviceScale: scale.
	aContext := aSurface newContext.

	aContext
		sourceColorRGB: Color blue;
		paint;
		sourceColorRGB: Color orange;
		circleRadius: radius; 
		fill.

	^ aSurface asARGB32ImageSurface
]

{ #category : #tests }
AeCairoConvertTest >> surfaceWithDeviceScaleAsAlphaChannelGrayscaleImage [

	| radius center extent scale aSurface aContext |
	radius := 5.
	center := radius asPoint.
	extent := (radius*2) asPoint.
	scale := 2.0@1.2.

	aSurface := AeCairoImageSurface
		extent: extent * scale
		format: AeCairoSurfaceFormat argb32.
	aSurface deviceScale: scale.
	aContext := aSurface newContext.

	aContext
		sourceColorRGB: Color green;
		circleRadius: radius; 
		fill.

	^ aSurface asAlphaChannelGrayscaleImage
]
