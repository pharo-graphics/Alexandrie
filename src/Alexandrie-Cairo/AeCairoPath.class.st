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
	#category : #'Alexandrie-Cairo-Structures'
}

{ #category : #finalization }
AeCairoPath class >> externallyFree: aHandle [
	"Immediately releases all memory associated with path . After a call to cairo_path_destroy() the path pointer is no longer valid and should not be used further.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-path-destroy"

	self ffiCall: #( void cairo_path_destroy ( void * aHandle ) )
]
