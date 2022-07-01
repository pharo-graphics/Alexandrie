Class {
	#name : #BASpaceRenderer,
	#superclass : #BlHostSpaceRenderer,
	#instVars : [
		'aeCanvas'
	],
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #accessing }
BASpaceRenderer >> aeCanvas [

	^ aeCanvas
]

{ #category : #initialization }
BASpaceRenderer >> initializeForSurface: aBlHostRendererSurface and: aeCairoSurface [

	aeCairoSurface setDeviceScale: aBlHostRendererSurface scaleFactor asPoint.

	aeCanvas := 	AeCanvas newFor: aeCairoSurface.


]

{ #category : #rendering }
BASpaceRenderer >> renderSpace: aBlSpace [
	"Render a space and return a collection of damaged rectangles"

	aeCanvas fullDraw: aBlSpace root.

	^ #()
]
