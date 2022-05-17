"
I am a Cairo FFI binding for `cairo_pattern_t`.
A `cairo_pattern_t` represents a source when drawing onto a surface.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html
"
Class {
	#name : #AeCairoPattern,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTCairoDestroy',
	#classTraits : 'AeTCairoLibrary classTrait + AeTCairoDestroy classTrait',
	#category : #'Alexandrie-FFI-Patterns'
}

{ #category : #'private - ffi' }
AeCairoPattern class >> primDestroy: aHandle [
	
	self ffiCall: #( void cairo_pattern_destroy ( void * aHandle ) )
]
