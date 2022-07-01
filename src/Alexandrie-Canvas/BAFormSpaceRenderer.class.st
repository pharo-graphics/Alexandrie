Class {
	#name : #BAFormSpaceRenderer,
	#superclass : #BASpaceRenderer,
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BAFormSpaceRenderer >> initializeForSurface: aBlHostRendererFormSurface [ 

	self
		initializeForSurface: aBlHostRendererFormSurface
		and: (AeCairoImageSurface
					createForData: aBlHostRendererFormSurface pointer
					extent: aBlHostRendererFormSurface extent
					stride: aBlHostRendererFormSurface stride
					format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32)
]
