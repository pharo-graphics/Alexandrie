Class {
	#name : #BAFormSpaceRenderer,
	#superclass : #BASpaceRenderer,
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BAFormSpaceRenderer >> initializeForSurface: aBlHostRendererFormSurface [ 

	| aeCairoSurface |
	aeCairoSurface := AeCairoImageSurface
		createForData: aBlHostRendererFormSurface pointer
		extent: aBlHostRendererFormSurface extent
		stride: aBlHostRendererFormSurface stride
		format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.

	aeCanvas := 	AeCanvas newFor: aeCairoSurface.

	self initializeScaleFactor: aBlHostRendererFormSurface scaleFactor.

"	physicalSize := aBlHostRendererFormSurface physicalSize.
	scaleFactor := aBlHostRendererFormSurface scaleFactor.
	session := Smalltalk session"
]
