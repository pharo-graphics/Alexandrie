"
I am a Cairo FFI binding for a `cairo_pattern_t` with a gradient source.
"
Class {
	#name : #AeCairoGradientPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset color: aColor [

	aColor isTranslucent
		ifTrue: [ self addStopAt: offset colorRGBA: aColor ]
		ifFalse: [ self addStopAt: offset colorRGB: aColor ]
]

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset colorRGB: aColor [

	self
		addStopAt: offset
		r: aColor red
		g: aColor green
		b: aColor blue

]

{ #category : #accessing }
AeCairoGradientPattern >> addStopAt: offset colorRGBA: aColor [

	self
		addStopAt: offset
		r: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #'private - ffi' }
AeCairoGradientPattern >> addStopAt: anOffset r: aRed g: aGreen b: aBlue [

	self ffiCall: #(
		void
		cairo_pattern_add_color_stop_rgb (
			self,
			double anOffset,
			double aRed,
			double aGreen,
			double aBlue ) )
]

{ #category : #'private - ffi' }
AeCairoGradientPattern >> addStopAt: anOffset r: aRed g: aGreen b: aBlue a: anAlpha [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-add-color-stop-rgba"
	
	self ffiCall: #(
		void
		cairo_pattern_add_color_stop_rgba (
			self,
			double anOffset,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha ) )
]

{ #category : #accessing }
AeCairoGradientPattern >> addStopsFrom: offsetColorAssociations [

	offsetColorAssociations do: [ :each | 
		self addStopAt: each key color: each value ]
]
