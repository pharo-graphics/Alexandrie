Class {
	#name : #AeFormSpaceRenderer,
	#superclass : #Object,
	#category : #'Alexandrie-Canvas'
}

{ #category : #initialization }
AeFormSpaceRenderer >> initializeForSurface: aBlHostRendererFormSurface [ 


"
	^ (self class environment at: #SpartaCairoCanvas)
		createForData: aRendererSurface pointer
		extent: aRendererSurface extent
		stride: aRendererSurface stride
		format: (self class environment at: #SpartaCairoSurfaceFormat) CAIRO_FORMAT_ARGB32	"
]

{ #category : #rendering }
AeFormSpaceRenderer >> renderSpace: aBlSpace [
	"Render a space and return a collection of damaged rectangles"
	
	^ #()
]
