Extension { #name : 'AeHbFace' }

{ #category : '*Alexandrie-HarfbuzzCairo' }
AeHbFace >> newCairoFontFace [
	"Answer a new `AeHbCairoFontFace` for rendering text according to this face."

	^ self unownedNewCairoFontFace
		hbFaceOrFont: self;
		autoRelease;
		yourself
]

{ #category : '*Alexandrie-HarfbuzzCairo' }
AeHbFace >> unownedNewCairoFontFace [
	"Answer a new `AeHbCairoFontFace` for rendering text according to this face.
	
	Sender is responsible of destroying the new object.

	See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html#hb-cairo-font-face-create-for-face"

	^ self
		ffiCall: #(
			AeHbCairoFontFace
			hb_cairo_font_face_create_for_face ( self ) )
		library: AeHarfbuzzCairoLibrary
]
