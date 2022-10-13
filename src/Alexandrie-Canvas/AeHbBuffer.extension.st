Extension { #name : #AeHbBuffer }

{ #category : #'*Alexandrie-Canvas' }
AeHbBuffer >> cairoGlyphArrayForFace: freetypeFace size: fontSize [
	"Based on: https://github.com/harfbuzz/harfbuzz-tutorial/blob/master/hello-harfbuzz-freetype.c"

	| font len infos positions cairoGlyphsArray currentX currentY |
	
	freetypeFace
		charSizeWidth: fontSize as26Dot6FractionalPoint
		height: fontSize as26Dot6FractionalPoint.
	font := AeHbFont primFontCreateForFreetypeReferenced: freetypeFace.
	self shapeWithFont: font.

	len := self primGetLength.
	len = 0 ifTrue: [ ^ AeCairoGlyphArray externalNewEmpty ].
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
			x: currentX + (position x_offset from26Dot6FractionalPoint);
			y: (currentY + (position y_offset from26Dot6FractionalPoint)) negated.
		currentX := currentX + (position x_advance from26Dot6FractionalPoint).
		currentY := currentY + (position y_advance from26Dot6FractionalPoint) ].

	^ cairoGlyphsArray
]
