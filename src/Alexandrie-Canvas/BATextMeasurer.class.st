Class {
	#name : #BATextMeasurer,
	#superclass : #BlHostTextMeasurer,
	#instVars : [
		'spaceRenderer'
	],
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

	| aFontBuilder aFontAndStyleBuilder aFont aTextPainter theAttributes aTextRun aSpartaMetrics |

	"we first collect font properties and text style from the attributes"
	aFontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	
	theAttributes := aBlSpan attributes.
	theAttributes do: [ :eachAttribute | eachAttribute applyOnFontAndStyleBuilder: aFontAndStyleBuilder ].

	"build an abstract font and resolve not yet resolved properties"
	aFont := aFontAndStyleBuilder font.

	aTextPainter := self aeCanvas text.
	aFontBuilder := self aeCanvas font.

	aFont applyOnSpartaFontBuilder: aFontBuilder.
	aFontAndStyleBuilder applyOnSpartaTextPainter: aTextPainter.

	aTextPainter font: aFontBuilder build.
	aTextPainter string: (String streamContents: [ :aStream | aBlSpan do: [ :anItem | anItem textRunOn: aStream ] ]).

	aSpartaMetrics := aTextPainter metrics.

	aTextRun := aTextPainter textRunWithMetrics: aSpartaMetrics.

	^ BlTextParagraphSpan new
		measurer: self;
		applySpartaMetrics: aSpartaMetrics;
		textRun: aTextRun;
		yourself

]
