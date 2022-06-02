Class {
	#name : #BASpaceRenderer,
	#superclass : #BlHostSpaceRenderer,
	#instVars : [
		'aeCanvas',
		'scaleFactor'
	],
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #accessing }
BASpaceRenderer >> aeCanvas [

	^ aeCanvas
]

{ #category : #initialization }
BASpaceRenderer >> initializeScaleFactor: aScaleFactor [

	aScaleFactor = 1.0 ifTrue: [ ^self ].

	aeCanvas privateAeCairoContext scale: aScaleFactor asPoint.
	scaleFactor := aScaleFactor.
]

{ #category : #rendering }
BASpaceRenderer >> renderSpace: aBlSpace [
	"Render a space and return a collection of damaged rectangles"

	aeCanvas fullDraw: aBlSpace root.

	^ #()
]
