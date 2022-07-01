Class {
	#name : #BABufferSpaceRenderer,
	#superclass : #BASpaceRenderer,
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BABufferSpaceRenderer >> initializeForSurface: aBlHostRendererBufferSurface [ 

	self
		initializeForSurface: aBlHostRendererBufferSurface
		and: (AeCairoImageSurface
					createForData: aBlHostRendererBufferSurface buffer
					extent: aBlHostRendererBufferSurface extent
					stride: aBlHostRendererBufferSurface stride
					format: AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32)

]
