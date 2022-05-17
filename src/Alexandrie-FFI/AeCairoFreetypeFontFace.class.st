"
I am a Cairo FFI binding for `cairo_font_face_t` for the FreeType font backend.

See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html
"
Class {
	#name : #AeCairoFreetypeFontFace,
	#superclass : #AeCairoFontFace,
	#category : #'Alexandrie-FFI-Text'
}

{ #category : #'instance creation' }
AeCairoFreetypeFontFace class >> newFor: aFreeTypeFont [
	"Create a cairo font face for a given freetype face"

	| aCairoFontFace |
	aCairoFontFace := self primCreate: aFreeTypeFont face.

	aCairoFontFace status isSuccess ifFalse: [
		self error: aCairoFontFace status asString ].

	self
		synthesizeFlagFor: aFreeTypeFont
		ifPresent: [ :flag | aCairoFontFace synthesize: flag ].

	^ aCairoFontFace
		autoRelease;
		yourself

]

{ #category : #'private - ffi' }
AeCairoFreetypeFontFace class >> primCreate: aFreetypeFontFace [

	^ self ffiCall: #( AeCairoFreetypeFontFace cairo_ft_font_face_create_for_ft_face ( void* aFreetypeFontFace, 0 ) )
]

{ #category : #'instance creation' }
AeCairoFreetypeFontFace class >> synthesizeFlagFor: aFreeTypeFont ifPresent: aUnaryBlock [
	"Evaluate a block with the simulated emphasis, if it's non-zero."

	| flag |
	flag := 0.

	aFreeTypeFont isSimulatedBold ifTrue: [
		flag :=
			AeCairoFreetypeSynthesize CAIRO_FT_SYNTHESIZE_BOLD value ].
	aFreeTypeFont isSimulatedItalic ifTrue: [
		flag := flag |
			AeCairoFreetypeSynthesize CAIRO_FT_SYNTHESIZE_OBLIQUE value ].

	flag isZero ifFalse: [ aUnaryBlock value: flag ].

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

{ #category : #accessing }
AeCairoFreetypeFontFace >> synthesize [

	^ self primGetSynthesize
]

{ #category : #accessing }
AeCairoFreetypeFontFace >> synthesize: aNumber [

	self primSetSynthesize: aNumber
]
