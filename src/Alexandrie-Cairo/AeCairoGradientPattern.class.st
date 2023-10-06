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
	"Adds a color stop at an offset to this gradient pattern.
	
	If two (or more) stops are specified with identical offset values, they will be sorted according to the order in which the stops are added, (stops added earlier will compare less than stops added later). This can be useful for reliably making sharp color transitions instead of the typical blend."

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
	"Add an opaque color stop to this gradient pattern. The offset specifies the location along the gradient's control vector. For example, a linear gradient's control vector is from (x0@y0) to (x1@y1) while a radial gradient's control vector is from any point on the start circle to the corresponding point on the end circle.
	
	If two (or more) stops are specified with identical offset values, they will be sorted according to the order in which the stops are added, (stops added earlier will compare less than stops added later). This can be useful for reliably making sharp color transitions instead of the typical blend.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-add-color-stop-rgb"

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
	"Add a translucent color stop to this gradient pattern. The offset specifies the location along the gradient's control vector. For example, a linear gradient's control vector is from (x0@y0) to (x1@y1) while a radial gradient's control vector is from any point on the start circle to the corresponding point on the end circle.
	
	If two (or more) stops are specified with identical offset values, they will be sorted according to the order in which the stops are added, (stops added earlier will compare less than stops added later). This can be useful for reliably making sharp color transitions instead of the typical blend.

	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-add-color-stop-rgba"
	
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
