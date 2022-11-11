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
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'private - ffi' }
AeCairoPattern class >> destroyHandle: aHandle [
	
	self ffiCall: #( void cairo_pattern_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoPattern class >> new [
	"Instance are created via FFI, with specialized class side methods of each subclass."

	^ self shouldNotImplement
]

{ #category : #API }
AeCairoPattern >> extend: anExtendMode [
	"Sets the mode to be used for drawing outside the area of a pattern. See cairo_extend_t for details on the semantics of each extend strategy.

The default extend mode is CAIRO_EXTEND_NONE for surface patterns and CAIRO_EXTEND_PAD for gradient patterns.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-extend"

	self ffiCall: #(
		void cairo_pattern_set_extend (
			self,
			AeCairoExtendMode anExtendMode ) )
]

{ #category : #API }
AeCairoPattern >> filter: filter [
	"Sets the filter to be used for resizing when using this pattern.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-filter"

	self ffiCall: #(
		void
		cairo_pattern_set_filter (
			self,
			AeCairoSamplingFilter filter ) )
]
