"
I am a Cairo FFI binding for a `cairo_pattern_t` with a gradient source.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html
"
Class {
	#name : #AeCairoGradientPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-FFI-Patterns'
}

{ #category : #'private - ffi' }
AeCairoGradientPattern >> primAddStop: anOffset r: aRed g: aGreen b: aBlue a: anAlpha [

	self ffiCall: #( void cairo_pattern_add_color_stop_rgba (
			self,
			double anOffset,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha ) )
]

{ #category : #accessing }
AeCairoGradientPattern >> stops: aCollectionOfStops [

	aCollectionOfStops do: [ :aStop |
		| aColor |
		aColor := aStop value.
		self
			primAddStop:  aStop key
			r: aColor red
			g: aColor green
			b: aColor blue
			a: aColor alpha ]
]
