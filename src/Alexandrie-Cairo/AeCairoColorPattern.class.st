"
I am a Cairo FFI binding for a `cairo_pattern_t` with a color source.
"
Class {
	#name : #AeCairoColorPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoColorPattern class >> newFrom: aColor [

	^ aColor isTranslucent
		  ifTrue: [
			  self
				  r: aColor red
				  g: aColor green
				  b: aColor blue
				  alpha: aColor alpha ]
		  ifFalse: [
			  self
				  r: aColor red
				  g: aColor green
				  b: aColor blue ]
]

{ #category : #'instance creation' }
AeCairoColorPattern class >> r: red g: green b: blue [

	^ (self unownedNewR: red g: green b: blue)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoColorPattern class >> r: red g: green b: blue alpha: alpha [

	^ (self
		   unownedNewR: red
		   g: green
		   b: blue
		   alpha: alpha)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoColorPattern class >> unownedNewR: red g: green b: blue [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-rgb"

	^ self ffiCall: #(
		AeCairoColorPattern
		cairo_pattern_create_rgb (
			double red,
			double green,
			double blue ) )
]

{ #category : #'instance creation' }
AeCairoColorPattern class >> unownedNewR: red g: green b: blue alpha: alpha [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-rgba"

	^ self ffiCall: #(
		AeCairoColorPattern
		cairo_pattern_create_rgba (
			double red,
			double green,
			double blue,
			double alpha ) )
]
