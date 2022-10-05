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
	#category : #'Alexandrie-Cairo-Text'
}

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
AeCairoTextMetrics >> height [

	^ height
]

{ #category : #accessing }
AeCairoTextMetrics >> height: aNumber [

	height := aNumber
]

{ #category : #accessing }
AeCairoTextMetrics >> width [

	^ width
]

{ #category : #accessing }
AeCairoTextMetrics >> width: aNumber [

	width := aNumber
]
