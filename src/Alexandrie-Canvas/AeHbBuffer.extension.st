Extension { #name : #AeHbBuffer }

{ #category : #'*Alexandrie-Canvas' }
AeHbBuffer >> cairoGlyphArrayForFace: freetypeFace size: fontSize [
	"Based on: https://github.com/harfbuzz/harfbuzz-tutorial/blob/master/hello-harfbuzz-freetype.c"

	| font len infos positions cairoGlyphsArray currentX currentY multiplier |
	self flag: #todo.
	"Why this multiplier? didn't see on documentation"
	multiplier := 64.
	
	freetypeFace
		charSizeWidth: fontSize * multiplier
		height: fontSize * multiplier.
	font := AeHbFont primFontCreateForFreetypeReferenced: freetypeFace.
	self shapeWithFont: font.

	len := self primGetLength.
	infos := self glyphInfos.
	positions := self glyphPositions.

	cairoGlyphsArray := AeCairoGlyphArray externalNew: len.
	currentX := 0.
	currentY := 0.
	cairoGlyphsArray doWithIndex: [ :each :index | 
		| position |
		position := positions at: index.
		each
			index: (infos at: index) codepoint;
			x: currentX + (position x_offset / multiplier);
			y: (currentY + (position y_offset / multiplier)) negated.
		currentX := currentX + (position x_advance / multiplier).
		currentY := currentY + (position y_advance / multiplier) ].

	^ cairoGlyphsArray
]
