"
I represent FFI bindings to `hb_font_t`: Font objects.

A font object represents a font face at a specific size and with certain other parameters (pixels-per-em, points-per-em, variation settings) specified. Font objects are created from font face objects, and are used as input to `hb_shape()`, among other things.

Client programs can optionally pass in their own functions that implement the basic, lower-level queries of font objects. This set of font functions is defined by the virtual methods in `hb_font_funcs_t`.

HarfBuzz provides a built-in set of lightweight default functions for each method in `hb_font_funcs_t`.

See: https://harfbuzz.github.io/harfbuzz-hb-font.html
"
Class {
	#name : #AeHbFont,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFont class >> externallyFree: aHandle [

	self ffiCall: #( void hb_font_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbFont class >> newForFTFaceReferenced: ft_face [

	^ (self unownedNewFTFaceReferenced: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFont class >> newForHbFace: anHbFace [
	"Answer a new font from the specified `AeHbFace` instance."

	^ (self unownedNewForHbFace: anHbFace)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFont class >> unownedNewFTFaceReferenced: aFTFace [
	"Answer a new instance from a `AeFTFace`.

	Precondition: The received face must already have the size set.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-create-referenced"

	^ self ffiCall: #(
		hb_font_t
		hb_ft_font_create_referenced (AeFTFace * aFTFace)
	)
]

{ #category : #'instance creation' }
AeHbFont class >> unownedNewForHbFace: anHbFace [
	"Answer a new font from the specified `AeHbFace` instance.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-create"

	^ self ffiCall: #(
		hb_font_t 
		hb_font_create (hb_face_t anHbFace)
		)
]

{ #category : #concurrency }
AeHbFont >> lock [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-lock-face"
	
	^ self ffiCall: #(
		AeFTFace *
		hb_ft_font_lock_face ( self ) )
]

{ #category : #refreshing }
AeHbFont >> refreshOnFTFontChanged [
	"Refreshes the state of font when the underlying `FT_Face` has changed. This function should be called after changing the size or variation-axis settings on the `FT_Face`.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-changed"

	self ffiCall: #(
		void
		hb_ft_font_changed ( self ) )
]

{ #category : #refreshing }
AeHbFont >> refreshOnHbFontChanged [
	"Refreshes the state of the underlying `FT_Face` of font when the `hb_font_t` font has changed. 

	Answer true if changed, false otherwise.
	
	This function should be called after changing the size or variation-axis settings on the font. 
	This call is fast if nothing has changed on font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-hb-font-changed"

	^ self ffiCall: #(
		hb_bool_t
		hb_ft_hb_font_changed ( self ) )
]

{ #category : #concurrency }
AeHbFont >> unlock [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-unlock-face"
	
	self ffiCall: #(
		void
		hb_ft_font_unlock_face ( self ) )
]
