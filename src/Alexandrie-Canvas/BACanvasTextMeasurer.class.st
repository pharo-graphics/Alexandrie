Class {
	#name : #BACanvasTextMeasurer,
	#superclass : #BATextMeasurer,
	#instVars : [
		'aeCanvas'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #accessing }
BACanvasTextMeasurer >> aeCanvas [

	^ aeCanvas
]

{ #category : #accessing }
BACanvasTextMeasurer >> aeCanvas: anAeCanvas [

	aeCanvas := anAeCanvas
]
