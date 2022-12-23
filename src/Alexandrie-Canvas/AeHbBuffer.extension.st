Extension { #name : #AeHbBuffer }

{ #category : #'*Alexandrie-Canvas' }
AeHbBuffer >> cairoGlyphArrayForFace: freetypeFace size: fontSize [
	"Based on: https://github.com/harfbuzz/harfbuzz-tutorial/blob/master/hello-harfbuzz-freetype.c"

	| hbFont length infos positions cairoGlyphsArray currentX currentY |
	
	freetypeFace charHeight: fontSize.
	hbFont := AeHbFont newForFTFaceReferenced: freetypeFace.
	self shapeWithFont: hbFont.

	length := self length.
	length = 0 ifTrue: [ ^ AeCairoGlyphArray newOf: 0 ].

	infos := FFIExternalArray
		  fromHandle: (self getGlyphInfosOn: ExternalAddress null)
		  type: AeHbGlyphInfo
		  size: length.
	positions := FFIExternalArray
		  fromHandle: (self getGlyphPositionsOn: ExternalAddress null)
		  type: AeHbGlyphPosition
		  size: length.

	cairoGlyphsArray := AeCairoGlyphArray newOf: length.
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
