"
I am a FFI binding for a `cairo_font_face_t` provided by Harfbuzz-Cairo integration.

A `cairo_font_face_t` represents a particular font at a particular weight, slant, and other characteristic but not size or transformation.

See: https://harfbuzz.github.io/integration-cairo.html
See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html
See: https://www.cairographics.org/manual/cairo-cairo-font-face-t.html
"
Class {
	#name : #AeHbCairoFontFace,
	#superclass : #AeCairoFontFace,
	#instVars : [
		'hbFaceOrFont'
	],
	#category : #'Alexandrie-HarfbuzzCairo'
}

{ #category : #accessing }
AeHbCairoFontFace >> hbFaceOrFont: aHarfbuzzFaceOrFont [
	"Associate with either the Harfbuzz face or font that was used to create this object."

	hbFaceOrFont := aHarfbuzzFaceOrFont
]

{ #category : #printing }
AeHbCairoFontFace >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' --> ';
		print: hbFaceOrFont
]

{ #category : #accessing }
AeHbCairoFontFace >> scaleFactor [
	"Answer the scale factor of this font face. Default scale factor is zero.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html#hb-cairo-font-face-get-scale-factor"

	^ self
		ffiCall: #(
			uint
			hb_cairo_font_face_get_scale_factor ( self ) )
		library: AeHarfbuzzCairoLibrary
]

{ #category : #accessing }
AeHbCairoFontFace >> scaleFactor: scaleFactor [
	"Sets the scale factor of this font face. Default scale factor is zero.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html#hb-cairo-font-face-set-scale-factor"

	self
		ffiCall: #(
			void
			hb_cairo_font_face_set_scale_factor (
				self,
				uint scaleFactor) )
		library: AeHarfbuzzCairoLibrary
]
