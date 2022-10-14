Extension { #name : #AeHbBuffer }

{ #category : #'*Alexandrie-Canvas' }
AeHbBuffer >> cairoGlyphArrayForFace: freetypeFace size: fontSize [
	"Based on: https://github.com/harfbuzz/harfbuzz-tutorial/blob/master/hello-harfbuzz-freetype.c"

	| font length infos positions cairoGlyphsArray currentX currentY |
	
	freetypeFace charSizeWidth: fontSize height: fontSize.
	font := AeHbFont primFontCreateForFreetypeReferenced: freetypeFace.
	self shapeWithFont: font.

	length := self primGetLength.
	length = 0 ifTrue: [ ^ AeCairoGlyphArray externalNewEmpty ].

	infos := FFIExternalArray
		  fromHandle: (self primGetGlyphInfos: ExternalAddress null)
		  type: AeHbGlyphInfo
		  size: length.
	positions := FFIExternalArray
		  fromHandle: (self primGetGlyphPositions: ExternalAddress null)
		  type: AeHbGlyphPosition
		  size: length.

	cairoGlyphsArray := AeCairoGlyphArray externalNew: length.
	currentX := 0.
	currentY := 0.
	cairoGlyphsArray doWithIndex: [ :each :index | 
		| position |
		position := positions at: index.
		each
			index: (infos at: index) codepoint;
			x: currentX + position xOffsetFrom26Dot6;
			y: (currentY + position yOffsetFrom26Dot6) negated.
		currentX := currentX + position xAdvanceFrom26Dot6.
		currentY := currentY + position yAdvanceFrom26Dot6 ].

	^ cairoGlyphsArray
]
