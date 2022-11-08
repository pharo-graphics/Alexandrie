"
I am a Cairo FFI binding for a `cairo_pattern_t` with an translucent color source.
"
Class {
	#name : #AeCairoTranslucentColorPattern,
	#superclass : #AeCairoColorPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'private - ffi' }
AeCairoTranslucentColorPattern class >> primCreateR: red g: green b: blue alpha: alpha [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-rgba"

	^ self ffiCall: #(
		#AeCairoTranslucentColorPattern
		cairo_pattern_create_rgba (
			double red,
			double green,
			double blue,
			double alpha ) )
]

{ #category : #'instance creation' }
AeCairoTranslucentColorPattern class >> r: red g: green b: blue alpha: alpha [

	^ (self
		   primCreateR: red
		   g: green
		   b: blue
		   alpha: alpha)
		  autoRelease;
		  yourself
]
