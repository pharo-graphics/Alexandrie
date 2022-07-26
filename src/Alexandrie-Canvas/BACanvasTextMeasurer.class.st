Class {
	#name : #BACanvasTextMeasurer,
	#superclass : #BATextMeasurer,
	#instVars : [
		'aeCanvas'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #accessing }
BACanvasTextMeasurer >> canvas [
	"return the Alexandrie canvas"
	^ aeCanvas
]

{ #category : #accessing }
BACanvasTextMeasurer >> canvas: anAeCanvas [

	aeCanvas := anAeCanvas
]
