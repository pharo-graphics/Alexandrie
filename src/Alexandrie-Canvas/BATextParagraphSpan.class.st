"
I represent an Alexandrie specific measured span
"
Class {
	#name : #BATextParagraphSpan,
	#superclass : #BlTextParagraphLeaf,
	#instVars : [
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #'instance creation' }
BATextParagraphSpan class >> measurer: aBASpaceTextMeasurer span: aBlSpan [

	^ self new measurer: aBASpaceTextMeasurer; span: aBlSpan; 
		  yourself
]

{ #category : #drawing }
BATextParagraphSpan >> aeDrawOn: aeCanvas [

	self span ifNil: [ ^ self ].
	aeCanvas restoreContextAfter: [ 
		self flag: #todo. "Default color?"
		aeCanvas setSourceColor: (fontAndStyleBuilder hasCustomColor
				 ifTrue: [ fontAndStyleBuilder color ]
				 ifFalse: [ Color black ]).

		self attributes do: [ :anAttribute | 
			anAttribute aeDrawBelowOn: aeCanvas span: self
			"			anAttribute aeApplyTo: aeCanvas " ].

		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont.

		self attributes do: [ :anAttribute | 
			anAttribute aeDrawAboveOn: aeCanvas span: self ] ]
]

{ #category : #building }
BATextParagraphSpan >> getTextMetricsWithBuilder: aBlTextFontAndStyleBuilder [
	"build an abstract font and resolve not yet resolved properties"
	| freeTypeFont buffer fontExtents |
	
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder.
	freeTypeFont := fontAndStyleBuilder font asLogicalFont asFreetypeFont.
	cairoScaledFont := self measurer canvas scaledFontFor: freeTypeFont.
	
	"Get glyphs for the text"
	buffer := self span utf8Encoded.
	cairoGlyphsArray := cairoScaledFont
		glyphArrayFor: buffer
		length: buffer size.

	fontExtents := self measurer canvas fontExtentsOf: cairoScaledFont.
	ascent := fontExtents ascent negated.
	descent := fontExtents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"
	self measurer canvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents |
			advance := aTextExtents advanceX.
			left := aTextExtents bearingX.
			top := aTextExtents bearingY.
			width := aTextExtents width.
			height := aTextExtents height ].

]

{ #category : #measurement }
BATextParagraphSpan >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'todo ?'
]
