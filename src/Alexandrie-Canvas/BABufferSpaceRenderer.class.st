Class {
	#name : #BABufferSpaceRenderer,
	#superclass : #BASpaceRenderer,
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BABufferSpaceRenderer >> initializeForSurface: aBlHostRendererBufferSurface [ 

	| aeCairoSurface |
	aeCairoSurface := AeCairoImageSurface
		createForData: aBlHostRendererBufferSurface buffer
		extent: aBlHostRendererBufferSurface extent
		stride: aBlHostRendererBufferSurface stride
		format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32.

	aeCanvas := 	AeCanvas newFor: aeCairoSurface.
		
	self initializeScaleFactor: aBlHostRendererBufferSurface scaleFactor.

]
