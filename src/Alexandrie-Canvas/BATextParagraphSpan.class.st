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

{ #category : #building }
BATextParagraphSpan >> aeBuild [

	| aFreeTypeFont aBuffer aFontExtents |

	"Collect font properties and text style from the attributes"
	fontAndStyleBuilder := BlTextFontAndStyleBuilder new.
	self attributes do: [ :eachAttribute |
		eachAttribute applyOnFontAndStyleBuilder: fontAndStyleBuilder ].

	aFreeTypeFont := fontAndStyleBuilder font asLogicalFont asFreetypeFont.
	cairoScaledFont := self measurer aeCanvas scaledFontFor: aFreeTypeFont.
	
	"Get glyphs for the text"
	aBuffer := self span utf8Encoded.
	cairoGlyphsArray := cairoScaledFont
		glyphArrayFor: aBuffer
		length: aBuffer size.

	"Get font metrics (shared for all string with this scaled font)"
	"See SpartaFontMetrics>>#cairoInitializeFrom:"
	aFontExtents := self measurer aeCanvas fontExtentsOf: cairoScaledFont.
	ascent := aFontExtents ascent negated.
	descent := aFontExtents descent.

	"Get text metrics"
	"See SpartaTextMetrics>>#cairoInitializeFrom:"
	self measurer aeCanvas
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

{ #category : #measurement }
BATextParagraphSpan >> normalize: aScale [
	"Normalize this segment to have rounded measurements"
	self flag: 'todo ?'
]

{ #category : #accessing }
BATextParagraphSpan >> span: aBlSpan [
	super span: aBlSpan.
	self aeBuild.
]
