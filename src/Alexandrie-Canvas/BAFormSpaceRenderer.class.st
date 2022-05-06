Class {
	#name : #BAFormSpaceRenderer,
	#superclass : #BASpaceRenderer,
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BAFormSpaceRenderer >> initializeForSurface: aBlHostRendererFormSurface [ 


"
	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface pointer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SpartaCairoSurfaceFormat) CAIRO_FORMAT_ARGB32	"
]

{ #category : #rendering }
BAFormSpaceRenderer >> renderSpace: aBlSpace [
	"Render a space and return a collection of damaged rectangles"
	
	^ #()
]
