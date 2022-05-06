Class {
	#name : #BARenderer,
	#superclass : #BlHostRenderer,
	#instVars : [
		'hostSpace',
		'aeCanvas'
	],
	#category : #'Alexandrie-Canvas-Renderer'
}

{ #category : #initialization }
BARenderer >> createFormSpaceRenderer [

	^ BAFormSpaceRenderer new
]

{ #category : #initialization }
BARenderer >> initializeForHostSpace: aBlHostSpace [
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
BARenderer >> performUpdates [


]

{ #category : #accessing }
BARenderer >> physicalSize [

	^ aeCanvas extent asPhysicalSize
]

{ #category : #rendering }
BARenderer >> renderSpace: aBlSpace [

	^ aeCanvas fullDraw: aBlSpace root
]

{ #category : #rendering }
BARenderer >> renderSurface: aRenderer damaged: aCollection [ 

	hostSpace morphicWindow form: aeCanvas asForm
]

{ #category : #accessing }
BARenderer >> scaleFactor [

	^ 1.0
]

{ #category : #testing }
BARenderer >> shouldUpdateEveryFrame [

	^ true
]
