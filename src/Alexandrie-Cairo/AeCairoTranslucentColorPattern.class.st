"
I am a Cairo FFI binding for a `cairo_pattern_t` with an translucent color source.
"
Class {
	#name : #AeCairoTranslucentColorPattern,
	#superclass : #AeCairoColorPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoTranslucentColorPattern class >> r: red g: green b: blue alpha: alpha [

	^ (self
		   unownedNewR: red
		   g: green
		   b: blue
		   alpha: alpha)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoTranslucentColorPattern class >> unownedNewR: red g: green b: blue alpha: alpha [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-rgba"

	^ self ffiCall: #(
		#AeCairoTranslucentColorPattern
		cairo_pattern_create_rgba (
			double red,
			double green,
			double blue,
			double alpha ) )
]
