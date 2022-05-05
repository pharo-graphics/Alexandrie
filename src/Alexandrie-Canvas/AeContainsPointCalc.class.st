Class {
	#name : #AeContainsPointCalc,
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
AeContainsPointCalc class >> instance [

	^ instance
		ifNil: [ instance := self new ]
		ifNotNil: [ 
		  instance
			  ensureReady;
			  yourself ]
]

{ #category : #accessing }
AeContainsPointCalc class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #initialization }
AeContainsPointCalc >> ensureReady [

	| cairoSurface |
	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.

	cairoSurface := AeCairoImageSurface extent: 1@1.
	cairoContext := AeCairoContext create: cairoSurface.

]

{ #category : #testing }
AeContainsPointCalc >> is: aPoint inFillOfVertices: vertices [

	vertices readStreamDo: [ :aStream |
		cairoContext moveTo: aStream next.
		[ aStream atEnd ] whileFalse: [ 
			cairoContext lineTo: aStream next	] ].

	^ cairoContext primInFillX: aPoint x y: aPoint y
]
