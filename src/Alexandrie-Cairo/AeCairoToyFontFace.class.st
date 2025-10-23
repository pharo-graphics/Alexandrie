"
I am a Cairo FFI binding for `cairo_font_face_t` for the Toy font backend.

See: https://www.cairographics.org/manual/cairo-text.html
"
Class {
	#name : #AeCairoToyFontFace,
	#superclass : #AeCairoFontFace,
	#category : #'Alexandrie-Cairo'
}

{ #category : #testing }
AeCairoToyFontFace class >> isFontType: fontType font: aCairoFontFace [ 

	^ fontType = AeCairoFontType toy
]

{ #category : #accessing }
AeCairoToyFontFace >> familyName [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-toy-font-face-get-family"

	^ self ffiCall: #( String cairo_toy_font_face_get_family ( self ) )
]

{ #category : #accessing }
AeCairoToyFontFace >> slant [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-toy-font-face-get-slant"

	^ self ffiCall: #( AeCairoFontSlant cairo_toy_font_face_get_slant ( self ) )
]

{ #category : #accessing }
AeCairoToyFontFace >> weight [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-toy-font-face-get-weight"

	^ self ffiCall: #( AeCairoFontWeight cairo_toy_font_face_get_weight ( self ) )
]
