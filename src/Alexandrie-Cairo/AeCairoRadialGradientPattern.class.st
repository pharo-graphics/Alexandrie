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
		   unownedNewWithInnerX: anInnerCenter x
		   innerY: anInnerCenter y
		   innerRadius: anInnerRadius
		   outerX: anOuterCenter x
		   outerY: anOuterCenter y
		   outerRadius: anOuterRadius)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoRadialGradientPattern class >> innerCenter: anInnerCenter innerRadius: anInnerRadius outerCenter: anOuterCenter outerRadius: anOuterRadius addStopsFrom: offsetColorAssociations [

	^ (self
		   innerCenter: anInnerCenter
		   innerRadius: anInnerRadius
		   outerCenter: anOuterCenter
		   outerRadius: anOuterRadius)
		  addStopsFrom: offsetColorAssociations;
		  yourself
]

{ #category : #'instance creation' }
AeCairoRadialGradientPattern class >> unownedNewWithInnerX: anInnerX innerY: anInnerY innerRadius: anInnerRadius outerX: anOuterX outerY: anOuterY outerRadius: anOuterRadius [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-radial"
	
	^ self ffiCall: #(
		AeCairoRadialGradientPattern
		cairo_pattern_create_radial (
			double anInnerX,
			double anInnerY,
			double anInnerRadius,
			double anOuterX,
			double anOuterY,
			double anOuterRadius ) )
]
