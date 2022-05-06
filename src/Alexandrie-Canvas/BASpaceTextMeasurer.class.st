Class {
	#name : #BASpaceTextMeasurer,
	#superclass : #BATextMeasurer,
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #accessing }
BASpaceTextMeasurer >> aeCanvas [

	^ spaceRenderer aeCanvas
]

{ #category : #accessing }
BASpaceTextMeasurer >> spaceRenderer [

	^ spaceRenderer
]

{ #category : #accessing }
BASpaceTextMeasurer >> spaceRenderer: aBlAeSpaceRenderer [

	spaceRenderer := aBlAeSpaceRenderer
]
