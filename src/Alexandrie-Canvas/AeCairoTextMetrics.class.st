"
I am a simple data struture to store font and text measurements fetch from a `AeCairoTextExtents`.
See `BaTextParagraphLeaf>>getMetricsFor:canvas:`.

	advanceX:		<Number>
	advanceY:		<Number>
	ascent:		<Number>
	bearingX:		<Number>
	bearingY:		<Number>
	descent:		<Number>
	height:		<Number>
	width:		<Number>
"
Class {
	#name : #AeCairoTextMetrics,
	#superclass : #Object,
	#instVars : [
		'ascent',
		'descent',
		'bearingX',
		'bearingY',
		'width',
		'height',
		'advanceX',
		'advanceY'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #accessing }
AeCairoTextMetrics >> advance [

	^ self advanceX @ self advanceY
]

{ #category : #accessing }
AeCairoTextMetrics >> advanceX [

	^ advanceX
]

{ #category : #accessing }
AeCairoTextMetrics >> advanceX: aNumber [

	advanceX := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> advanceY [

	^ advanceY
]

{ #category : #accessing }
AeCairoTextMetrics >> advanceY: aNumber [

	advanceY := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> ascent [

	^ ascent
]

{ #category : #accessing }
AeCairoTextMetrics >> ascent: aNumber [

	ascent := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> bearing [

	^ self bearingX @ self bearingY
]

{ #category : #accessing }
AeCairoTextMetrics >> bearingX [

	^ bearingX
]

{ #category : #accessing }
AeCairoTextMetrics >> bearingX: aNumber [

	bearingX := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> bearingY [

	^ bearingY
]

{ #category : #accessing }
AeCairoTextMetrics >> bearingY: aNumber [

	bearingY := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> descent [

	^ descent
]

{ #category : #accessing }
AeCairoTextMetrics >> descent: aNumber [

	descent := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> extent [

	^ self width @ self height
]

{ #category : #accessing }
AeCairoTextMetrics >> height [

	^ height
]

{ #category : #accessing }
AeCairoTextMetrics >> height: aNumber [

	height := aNumber
]

{ #category : #printing }
AeCairoTextMetrics >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.

	#(extent bearing advance) do: [ :each |
		aStream
			nextPutAll: each asMutator;
			space;
			print: (self perform: each) ]
		separatedBy: [ aStream space ].

	aStream nextPut: $)
]

{ #category : #accessing }
AeCairoTextMetrics >> width [

	^ width
]

{ #category : #accessing }
AeCairoTextMetrics >> width: aNumber [

	width := aNumber
]
