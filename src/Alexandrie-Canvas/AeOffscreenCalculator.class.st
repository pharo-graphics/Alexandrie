Class {
	#name : #AeOffscreenCalculator,
	#superclass : #Object,
	#instVars : [
		'session',
		'cairoContext'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #accessing }
AeOffscreenCalculator class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
AeOffscreenCalculator class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #initialization }
AeOffscreenCalculator >> ensureReady [

	| cairoSurface |
	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.

	cairoSurface := AeCairoImageSurface extent: 1@1.
	cairoContext := AeCairoContext create: cairoSurface.

]

{ #category : #testing }
AeOffscreenCalculator >> is: aPoint inFillOfVertices: vertices [

	self ensureReady.

	vertices readStreamDo: [ :aStream |
		cairoContext moveTo: aStream next.
		[ aStream atEnd ] whileFalse: [ 
			cairoContext lineTo: aStream next	] ].

	^ cairoContext primInFillX: aPoint x y: aPoint y
]
