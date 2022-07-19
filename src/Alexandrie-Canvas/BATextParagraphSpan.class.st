Class {
	#name : #BATextParagraphSpan,
	#superclass : #BlTextParagraphSegment,
	#instVars : [
		'paragraphBlText',
		'baTextMeasurer',
		'blSpan',
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #'instance creation' }
BATextParagraphSpan class >> textMeasurer: aBASpaceTextMeasurer span: aBlSpan [

	^ self basicNew
		  initializeTextMeasurer: aBASpaceTextMeasurer span: aBlSpan;
		  yourself
]

{ #category : #building }
BATextParagraphSpan >> aeBuild [

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

{ #category : #drawing }
BATextParagraphSpan >> aeDrawOn: aeCanvas [

	aeCanvas restoreContextAfter: [

		self flag: #todo. "Default color?"
		aeCanvas setSourceColor: 
			(fontAndStyleBuilder hasCustomColor
				ifTrue: [ fontAndStyleBuilder color ]
				ifFalse: [ Color black ]).

		blSpan attributes do: [ :anAttribute | 
			anAttribute aeDrawBelowOn: aeCanvas span: self.
"			anAttribute aeApplyTo: aeCanvas "].

		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont.
		
		blSpan attributes do: [ :anAttribute | 
			anAttribute aeDrawAboveOn: aeCanvas span: self ].

		]
]

{ #category : #accessing }
BATextParagraphSpan >> indexAtPosition: aPoint [
	"I return a cursor index at a given position as a Point provided in local coordinates of this span"

	| aWidth |
	self flag: #todo.
	
	aWidth := aPoint x max: 0.

	(aWidth <= 0)
		ifTrue: [ ^ (self from - 1) max: 0 ].
	(aWidth >= self advance)
		ifTrue: [ ^ self to ].

	^ (self spanStart to: self spanEnd)
		findBinary: [ :anIndex |
			| aSubSpan aParagraph |
			
			aSubSpan := BlSpan
				text: (blSpan text from: (1 min: anIndex) to: anIndex)
				attributes: self span attributes.
			
			aParagraph := baTextMeasurer measureTextSpan: aSubSpan.
			
			(aWidth closeTo: aParagraph advance epsilon: 0.1)
				ifTrue: [ 0 ]
				ifFalse: [ (aWidth - aParagraph advance) sign ] ]
		"exact match"
		do: [ :anIndex | self from + anIndex - 1 ]

		"need to measure a bit more"
		ifNone: [ :a :b |
			| leftIndex rightIndex leftWidth leftSpanIndex rightWidth rightSpanIndex spanIndex |
			leftIndex := a ifNil: [ self spanStart - 1 ].
			rightIndex := b ifNil: [ self spanEnd + 1 ].
			
			leftIndex < self spanStart
				ifTrue: [
					leftWidth := 0.
					leftSpanIndex := (self spanStart - 1) max: 0 ]
				ifFalse: [
					| aSubSpan aParagraph |
					aSubSpan := BlSpan
						text: (blSpan text from: (1 min: leftIndex) to: leftIndex)
						attributes: self span attributes.
					aParagraph := baTextMeasurer measureTextSpan: aSubSpan.
					leftWidth := aParagraph advance.
					leftSpanIndex := leftIndex ].

			rightIndex > self spanEnd
				ifTrue: [
					rightWidth := self advance.
					rightSpanIndex := self spanEnd ]
				ifFalse: [
					| aSubSpan aParagraph |
					aSubSpan := BlSpan
						text: (blSpan text from: (1 min: rightIndex) to: rightIndex)
						attributes: self span attributes.
					aParagraph := baTextMeasurer measureTextSpan: aSubSpan.
					rightWidth := aParagraph advance.
					rightSpanIndex := rightIndex ].

			spanIndex := aWidth <= (leftWidth + ((rightWidth - leftWidth) / 2.0))
				ifTrue: [ leftSpanIndex ]
				ifFalse: [ rightSpanIndex ].

			self from + spanIndex - 1 ]
]

{ #category : #initialization }
BATextParagraphSpan >> initializeTextMeasurer: aBATextMeasurer span: aBlSpan [

	self initialize.
	baTextMeasurer := aBATextMeasurer.
	blSpan := aBlSpan.
	self aeBuild.
]

{ #category : #measurement }
BATextParagraphSpan >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'todo ?'
]

{ #category : #accessing }
BATextParagraphSpan >> positionAt: anIndex [

	| aSpanIndex aSubSpan aMeasuredSpan aPositionY aPositionX |

	aPositionY := self baseline y.
	aPositionX := self baseline x.

	(anIndex = (self from - 1))
		ifTrue: [ ^ aPositionX @ aPositionY ].
	(anIndex = self to)
		ifTrue: [ ^ (aPositionX + self advance) @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.

	aSubSpan := BlSpan
		text: (blSpan text from: (1 min: aSpanIndex) to: aSpanIndex)
		attributes: self span attributes.

	aMeasuredSpan := baTextMeasurer measureTextSpan: aSubSpan.
	
	^ (aPositionX + aMeasuredSpan advance) @ aPositionY
]

{ #category : #printing }
BATextParagraphSpan >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: blSpan;
		nextPut: $)

]

{ #category : #accessing }
BATextParagraphSpan >> span [

	^ blSpan
]

{ #category : #accessing }
BATextParagraphSpan >> span: aBlSpan [

	blSpan := aBlSpan
]

{ #category : #'accessing - span' }
BATextParagraphSpan >> spanEnd [

	^ blSpan size
]

{ #category : #'accessing - span' }
BATextParagraphSpan >> spanLength [

	^ (self spanStart isZero and: [ self spanEnd isZero ])
		ifTrue: [ 0 ]
		ifFalse: [ self spanEnd - self spanStart + 1 ]
]

{ #category : #'accessing - span' }
BATextParagraphSpan >> spanStart [

	^ 1 min: blSpan size
]

{ #category : #accessing }
BATextParagraphSpan >> text: aGlobalText from: aGlobalTextStart to: aGlobalTextEnd [
	"Assign the paragraph's text with provided indices so that we could always determine which part of it I measure"

	paragraphBlText := aGlobalText.
	from := aGlobalTextStart.
	to := aGlobalTextEnd
]

{ #category : #accessing }
BATextParagraphSpan >> textMeasurer [

	^ baTextMeasurer
]
