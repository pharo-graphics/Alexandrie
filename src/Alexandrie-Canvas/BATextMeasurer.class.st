Class {
	#name : #BATextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #accessing }
BATextMeasurer >> aeCanvas [

	^ self subclassResponsibility
]

{ #category : #dispatch }
BATextMeasurer >> measureTextParagraph: aBlTextParagraph [

	aBlTextParagraph measureOn: self
]

{ #category : #dispatch }
BATextMeasurer >> measureTextSpan: aBlSpan [
	"Measure a given text span and return paragraph span with computed metrics"

	^ BASpan textMeasurer: self span: aBlSpan

]
