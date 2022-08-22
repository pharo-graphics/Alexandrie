"
I am a Cairo FFI binding for `cairo_font_face_t` for the FreeType font backend.

See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html
"
Class {
	#name : #AeCairoFreetypeFontFace,
	#superclass : #AeCairoFontFace,
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'instance creation' }
AeCairoFreetypeFontFace class >> newForFace: aFTFace [
	"Create a cairo font face for a given freetype face"

	| aCairoFontFace |
	aCairoFontFace := self primCreate: aFTFace.

	aCairoFontFace status isSuccess ifFalse: [
		self error: aCairoFontFace status asString ].

	^ aCairoFontFace
		autoRelease;
		yourself

]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace class >> primCreate: aFreetypeFontFace [

	^ self ffiCall: #( AeCairoFreetypeFontFace cairo_ft_font_face_create_for_ft_face ( void* aFreetypeFontFace, 0 ) )
]

{ #category : #'instance creation' }
AeCairoFreetypeFontFace >> newScaledFontWithFontMatrix: aFontMatrix userToDeviceMatrix: aUserToDeviceCairoMatrix options: theFontOptions [

	^ AeCairoScaledFont
		  fontFace: self
		  fontMatrix: aFontMatrix
		  userToDeviceMatrix: aUserToDeviceCairoMatrix
		  options: theFontOptions
]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace >> primGetSynthesize [

	^ self ffiCall: #(uint cairo_ft_font_face_get_synthesize ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace >> primSetSynthesize: aNumber [

	self ffiCall: #(void cairo_ft_font_face_set_synthesize ( self, uint aNumber ) )
]
