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
	#traits : 'AeTHarfbuzzLibrary + AeHbTDestroy',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeHbTDestroy classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFont class >> primDestroy: aHandle [

	self ffiCall: #(
		void
		hb_font_destroy (void *aHandle)
		)
]

{ #category : #'instance creation' }
AeHbFont class >> primFontCreateFor: face [
	"Constructs a new font object from the specified face.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-create"

	^ self ffiCall: #(
		hb_font_t 
		hb_font_create (hb_face_t face)
		)
]
