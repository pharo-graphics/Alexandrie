Extension { #name : #AeFTFace }

{ #category : #'*Alexandrie-CairoFreetype' }
AeFTFace >> newCairoFontFace [
	"Answer a new `AeCairoFreetypeFontFace` for rendering text according to this face."

	^ AeCairoFreetypeFontFace newForFace: self
]
