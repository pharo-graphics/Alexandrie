Extension { #name : #AeHbFont }

{ #category : #'*Alexandrie-HarfbuzzCairo' }
AeHbFont >> newCairoFontFace [
	"Answer a new `AeCairoFontFace` for rendering text according to this font.

	Note that the scale of font does not affect the rendering, but the variations and slant that are set on font do."

	^ self unownedNewCairoFontFace
		autoRelease;
		yourself
]

{ #category : #'*Alexandrie-HarfbuzzCairo' }
AeHbFont >> unownedNewCairoFontFace [
	"Answer a new `AeHbCairoFontFace` for rendering text according to this font.

	Note that the scale of font does not affect the rendering, but the variations and slant that are set on font do.
	
	Sender is responsible of destroying the new object.

	See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html#hb-cairo-font-face-create-for-font"

	^ self
		ffiCall: #(
			AeHbCairoFontFace
			hb_cairo_font_face_create_for_font ( self ) )
		library: AeHarfbuzzCairoLibrary
]
