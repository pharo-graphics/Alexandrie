"
I am a Cairo FFI binding for a `cairo_pattern_t` with an opaque color source.
"
Class {
	#name : #AeCairoOpaqueColorPattern,
	#superclass : #AeCairoColorPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'private - ffi' }
AeCairoOpaqueColorPattern class >> primCreateR: red g: green b: blue [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-rgb"

	^ self ffiCall: #(
		#AeCairoOpaqueColorPattern
		cairo_pattern_create_rgb (
			double red,
			double green,
			double blue ) )
]

{ #category : #'instance creation' }
AeCairoOpaqueColorPattern class >> r: red g: green b: blue [

	^ (self primCreateR: red g: green b: blue)
		  autoRelease;
		  yourself
]
