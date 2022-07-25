Class {
	#name : #AeOffscreen,
	#superclass : #Object,
	#instVars : [
		'session',
		'aeCanvas',
		'cairoContext',
		'textMeasurer'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #accessing }
AeOffscreen class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
AeOffscreen class >> resetInstance [
	<script>

	instance := nil
]

{ #category : #initialization }
AeOffscreen >> ensureReady [

	session == Smalltalk session ifTrue: [ ^ self ].
	session := Smalltalk session.

	aeCanvas := AeCanvas extent: 1 asPoint.
	cairoContext := aeCanvas privateAeCairoContext.

	textMeasurer := BACanvasTextMeasurer new
							canvas: aeCanvas;
							yourself
]

{ #category : #api }
AeOffscreen >> is: aPoint inFillOfVertices: vertices [

	self ensureReady.

	vertices readStreamDo: [ :aStream |
		cairoContext moveTo: aStream next.
		[ aStream atEnd ] whileFalse: [ 
			cairoContext lineTo: aStream next	] ].

	^ cairoContext primInFillX: aPoint x y: aPoint y
]

{ #category : #api }
AeOffscreen >> measureTextParagraph: aBlTextParagraph [

	self ensureReady.
	textMeasurer measureTextParagraph: aBlTextParagraph
]
