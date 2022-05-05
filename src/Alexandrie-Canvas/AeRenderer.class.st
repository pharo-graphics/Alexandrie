Class {
	#name : #AeRenderer,
	#superclass : #BlHostRenderer,
	#instVars : [
		'hostSpace',
		'aeCanvas'
	],
	#category : #'Alexandrie-Canvas'
}

{ #category : #initialization }
AeRenderer >> createFormSpaceRenderer [

	^ AeFormSpaceRenderer new
]

{ #category : #initialization }
AeRenderer >> initializeForHostSpace: aBlHostSpace [
	"Initialize this renderer for a given host space.
	Please note, that it I be called multiple times"
	
	session := Smalltalk session.
	
	"we should mark it as a current one before initializing a canvas as it may rely on opengl context"
	aBlHostSpace makeCurrent.
	
	surface := self.
	surfaceRenderer := self.
	spaceRenderer := self.

	hostSpace := aBlHostSpace.
	aeCanvas := AeCanvas extent: aBlHostSpace physicalSize asPoint.

	textMeasurer := BlMockedTextMeasurer new
]

{ #category : #'api - updates' }
AeRenderer >> performUpdates [


]

{ #category : #accessing }
AeRenderer >> physicalSize [

	^ aeCanvas extent asPhysicalSize
]

{ #category : #rendering }
AeRenderer >> renderSpace: aBlSpace [

	^ aeCanvas fullDraw: aBlSpace root
]

{ #category : #rendering }
AeRenderer >> renderSurface: aRenderer damaged: aCollection [ 

	hostSpace morphicWindow form: aeCanvas asForm
]

{ #category : #accessing }
AeRenderer >> scaleFactor [

	^ 1.0
]

{ #category : #testing }
AeRenderer >> shouldUpdateEveryFrame [

	^ true
]
