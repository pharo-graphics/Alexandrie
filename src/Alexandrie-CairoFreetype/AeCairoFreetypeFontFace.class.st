"
I am a Cairo FFI binding for `cairo_font_face_t` for the FreeType font backend.

See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html
"
Class {
	#name : #AeCairoFreetypeFontFace,
	#superclass : #AeCairoFontFace,
	#instVars : [
		'freetypeFace'
	],
	#category : #'Alexandrie-CairoFreetype'
}

{ #category : #testing }
AeCairoFreetypeFontFace class >> isFontType: fontType font: aCairoFontFace [

	^ fontType = AeCairoFontType freetype
]

{ #category : #'instance creation' }
AeCairoFreetypeFontFace class >> newForFace: aFTFace [
	"Create a cairo font face for a given freetype face"

	| aCairoFontFace |
	aCairoFontFace := self unownedNewFor: aFTFace.
	aCairoFontFace status ensureIsSuccess.

	^ aCairoFontFace
		freetypeFace: aFTFace;
		autoRelease;
		yourself

]

{ #category : #'instance creation' }
AeCairoFreetypeFontFace class >> unownedNewFor: aFreetypeFontFace [
	"See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-font-face-create-for-ft-face"

	^ self
		ffiCall: #(
			AeCairoFreetypeFontFace
			cairo_ft_font_face_create_for_ft_face (
				AeFTFace * aFreetypeFontFace,
				int 0 ) )
]

{ #category : #accessing }
AeCairoFreetypeFontFace >> familyName [

	^ freetypeFace familyName
]

{ #category : #accessing }
AeCairoFreetypeFontFace >> freetypeFace [
	"Answer the `AeFTFace` associated with this font face"

	^ freetypeFace
]

{ #category : #accessing }
AeCairoFreetypeFontFace >> freetypeFace: aFTFace [
	"Set the `AeFTFace` instance associated with this font face. This should avoid it to be garbage collection before me."

	freetypeFace := aFTFace
]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace >> synthesize [

	^ self ffiCall: #( uint cairo_ft_font_face_get_synthesize ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace >> synthesize: aNumber [

	self ffiCall: #(
		void
		cairo_ft_font_face_set_synthesize (
			self,
			uint aNumber ) )
]
