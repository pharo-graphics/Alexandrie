"
I am a Cairo FFI binding for `cairo_path_t`.

Paths are the most basic drawing tools and are primarily used to implicitly generate simple masks.

See: https://www.cairographics.org/manual/cairo-Paths.html
"
Class {
	#name : #AeCairoPath,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #finalization }
AeCairoPath class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_path_destroy ( void * aHandle ) )
]
