"
I am a Cairo FFI binding for `cairo_font_face_t`.
A `cairo_font_face_t` represents a particular font at a particular weight, slant, and other characteristic but not size or transformation.

See: https://www.cairographics.org/manual/cairo-cairo-font-face-t.html
"
Class {
	#name : #AeCairoFontFace,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoFontFace class >> externallyFree: aHandle [
	"Decreases the reference count on a font face by one. If the result is zero, then font_face and all associated resources are freed.
	
	See: https://www.cairographics.org/manual/cairo-cairo-font-face-t.html#cairo-font-face-destroy"

	self ffiCall: #( void cairo_font_face_destroy ( void * aHandle) )
]

{ #category : #'as yet unclassified' }
AeCairoFontFace >> familyName [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
AeCairoFontFace >> newScaledFontWithFontMatrix: aFontMatrix userToDeviceMatrix: aUserToDeviceCairoMatrix options: theFontOptions [

	^ AeCairoScaledFont
		  fontFace: self
		  fontMatrix: aFontMatrix
		  userToDeviceMatrix: aUserToDeviceCairoMatrix
		  options: theFontOptions
]

{ #category : #'private - ffi' }
AeCairoFontFace >> status [

	^ self ffiCall: #( AeCairoStatus cairo_font_face_status ( self ) )
]

{ #category : #'private - ffi' }
AeCairoFontFace >> type [
	"Returns the type of the backend used to create a font face.
	
	See: https://www.cairographics.org/manual/cairo-cairo-font-face-t.html#cairo-font-face-get-type"

	^ self ffiCall: #( AeCairoFontType cairo_font_face_get_type ( self ) )
]
