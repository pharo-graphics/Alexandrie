Class {
	#name : #BASpan,
	#superclass : #Object,
	#instVars : [
		'paragraph',
		'left',
		'top',
		'width',
		'height',
		'advance',
		'ascent',
		'descent',
		'paragraphEndIndex',
		'paragraphStartIndex',
		'paragraphBlText',
		'baTextMeasurer',
		'blSpan',
		'baselinePoint',
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #'instance creation' }
BASpan class >> textMeasurer: aBASpaceTextMeasurer span: aBlSpan [

	^ self basicNew
		  initializeTextMeasurer: aBASpaceTextMeasurer span: aBlSpan;
		  yourself
]

{ #category : #accessing }
BASpan >> advance [

	^ advance
]

{ #category : #building }
BASpan >> aeBuild [

	| aFreeTypeFont aBuffer aFontExtents |

	"Collect font properties and text style from the attributes"
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	blSpan attributes do: [ :eachAttribute |
		eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].

	aFreeTypeFont := fontAndStyleBuilder font asLogicalFont asFreetypeFont.
	cairoScaledFont := baTextMeasurer aeCanvas scaledFontFor: aFreeTypeFont.
	
	"Get glyphs for the text"
	aBuffer := blSpan utf8Encoded.
	cairoGlyphsArray := cairoScaledFont
		glyphArrayFor: aBuffer
		length: aBuffer size.

	"Get font metrics (shared for all string with this scaled font)"
	"See SpartaFontMetrics>>#cairoInitializeFrom:"
	aFontExtents := baTextMeasurer aeCanvas fontExtentsOf: cairoScaledFont.
	ascent := aFontExtents ascent negated.
	descent := aFontExtents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"
	baTextMeasurer aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents |
			advance := aTextExtents advanceX.
			left := aTextExtents bearingX.
			top := aTextExtents bearingY.
			width := aTextExtents width.
			height := aTextExtents height ].

]

{ #category : #'as yet unclassified' }
BASpan >> aeDrawOn: aeCanvas [

	aeCanvas restoreAfter: [
		fontAndStyleBuilder hasCustomColor
			ifTrue: [
				aeCanvas setSourceColor: fontAndStyleBuilder color ]
			ifFalse: [
				self flag: #todo. "White is default?"
				aeCanvas setSourceColor: Color black
				].

		aeCanvas
			pathTranslate: baselinePoint;
			drawText: cairoGlyphsArray font: cairoScaledFont ]
]

{ #category : #accessing }
BASpan >> ascent [

	^ ascent
]

{ #category : #accessing }
BASpan >> baseline [

	^ baselinePoint
]

{ #category : #accessing }
BASpan >> baseline: aPoint [

	baselinePoint := aPoint
]

{ #category : #accessing }
BASpan >> descent [

	^ descent
]

{ #category : #accessing }
BASpan >> from [

	^ paragraphStartIndex
]

{ #category : #accessing }
BASpan >> height [

	^ height
]

{ #category : #initialization }
BASpan >> initializeTextMeasurer: aBATextMeasurer span: aBlSpan [

	self initialize.
	baTextMeasurer := aBATextMeasurer.
	blSpan := aBlSpan.
	self aeBuild.
]

{ #category : #accessing }
BASpan >> left [

	^ left
]

{ #category : #accessing }
BASpan >> paragraph [

	^ paragraph
]

{ #category : #accessing }
BASpan >> paragraph: aBlTextParagraph [

	paragraph := aBlTextParagraph
]

{ #category : #printing }
BASpan >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: blSpan;
		nextPut: $)

]

{ #category : #accessing }
BASpan >> span [

	^ blSpan
]

{ #category : #accessing }
BASpan >> span: aBlSpan [

	blSpan := aBlSpan
]

{ #category : #'accessing - span' }
BASpan >> spanEnd [

	^ blSpan size
]

{ #category : #'accessing - span' }
BASpan >> spanLength [

	^ (self spanStart isZero and: [ self spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self spanEnd - self spanStart + 1 ]
]

{ #category : #'accessing - span' }
BASpan >> spanStart [

	^ 1 min: blSpan size
]

{ #category : #accessing }
BASpan >> text: aGlobalText from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	paragraphBlText := aGlobalText.
	paragraphStartIndex := aGlobalTextStart.
	paragraphEndIndex := aGlobalTextEnd
]

{ #category : #accessing }
BASpan >> textMeasurer [

	^ baTextMeasurer
]

{ #category : #accessing }
BASpan >> to [

	^ paragraphEndIndex
]

{ #category : #accessing }
BASpan >> top [

	^ top
]

{ #category : #accessing }
BASpan >> width [

	^ width
]
