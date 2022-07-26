Class {
	#name : #BATextParagraphLeaf,
	#superclass : #BlTextParagraphLeaf,
	#instVars : [
		'cairoScaledFont',
		'cairoGlyphsArray',
		'fontAndStyleBuilder'
	],
	#category : #'Alexandrie-Canvas-Text'
}

{ #category : #drawing }
BATextParagraphLeaf >> aeDrawOn: aeCanvas [
]

{ #category : #building }
BATextParagraphLeaf >> getTextMetricsFor: utf8EncodedString withBuilder: aBlTextFontAndStyleBuilder canvas: aeCanvas [

	"returns a font metrics dictionary from an abstract font"

	| freeTypeFont buffer fontExtents metrics |
	fontAndStyleBuilder := aBlTextFontAndStyleBuilder.
	freeTypeFont := fontAndStyleBuilder font asLogicalFont asFreetypeFont.
	cairoScaledFont := aeCanvas scaledFontFor: freeTypeFont.

	"Get glyphs for the text"
	buffer := utf8EncodedString.
	cairoGlyphsArray := cairoScaledFont glyphArrayFor: buffer length: buffer size.

	fontExtents := aeCanvas fontExtentsOf: cairoScaledFont.

	metrics := IdentityDictionary new.
	metrics at: #ascent put: fontExtents ascent negated.
	metrics at: #descent put: fontExtents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"
	aeCanvas textExtentsFor: cairoGlyphsArray scaledFont: cairoScaledFont do: [ :aTextExtents | 
		metrics at: #advance put: aTextExtents advanceX.
		metrics at: #left put: aTextExtents bearingX.
		metrics at: #top put: aTextExtents bearingY.
		metrics at: #width put: aTextExtents width.
		metrics at: #height put: aTextExtents height.
		metrics at: #bounds put: (aTextExtents bearingX @ aTextExtents bearingY extent: aTextExtents width @ aTextExtents height)].
	^ metrics
]

{ #category : #measurement }
BATextParagraphLeaf >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'Do we need this ?'.

]
