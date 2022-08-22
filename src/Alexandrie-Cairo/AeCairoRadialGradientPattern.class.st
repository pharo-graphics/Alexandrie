"
I am a Cairo FFI binding for a `cairo_pattern_t` with a radial gradient source.

See my instance creation protocol.
"
Class {
	#name : #AeCairoRadialGradientPattern,
	#superclass : #AeCairoGradientPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoRadialGradientPattern class >> innerCenter: anInnerCenter innerRadius: anInnerRadius outerCenter: anOuterCenter outerRadius: anOuterRadius [

	^ (self
		   primCreateInnerX: anInnerCenter x
		   innerY: anInnerCenter y
		   innerRadius: anInnerRadius
		   outerX: anOuterCenter x
		   outerY: anOuterCenter y
		   outerRadius: anOuterRadius)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoRadialGradientPattern class >> primCreateInnerX: anInnerX innerY: anInnerY innerRadius: anInnerRadius outerX: anOuterX outerY: anOuterY outerRadius: anOuterRadius [

	self ffiCall: #(AeCairoRadialGradientPattern cairo_pattern_create_radial (
			double anInnerX,
			double anInnerY,
			double anInnerRadius,
			double anOuterX,
			double anOuterY,
			double anOuterRadius))
]
