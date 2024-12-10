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
AeCairoRadialGradientPattern class >> center: aCenter innerRadius: anInnerRadius outerRadius: anOuterRadius [

	^ self
		innerCenter: aCenter
		innerRadius: anInnerRadius
		outerCenter: aCenter
		outerRadius: anOuterRadius
]

{ #category : #'instance creation' }
AeCairoRadialGradientPattern class >> innerCenter: anInnerCenter innerRadius: anInnerRadius outerCenter: anOuterCenter outerRadius: anOuterRadius [

	^ self
		innerX: anInnerCenter x
		innerY: anInnerCenter y
		innerRadius: anInnerRadius
		outerX: anOuterCenter x
		outerY: anOuterCenter y
		outerRadius: anOuterRadius
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
AeCairoRadialGradientPattern class >> innerX: innerX innerY: innerY innerRadius: innerRadius outerX: outerX outerY: outerY outerRadius: outerRadius [

	^ (self
			unownedNewWithInnerX: innerX
			innerY: innerY
			innerRadius: innerRadius
			outerX: outerX
			outerY: outerY
			outerRadius: outerRadius)
				autoRelease;
				yourself
]

{ #category : #'instance creation' }
AeCairoRadialGradientPattern class >> unownedNewWithInnerX: innerX innerY: innerY innerRadius: innerRadius outerX: outerX outerY: outerY outerRadius: outerRadius [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-radial"
	
	^ self ffiCall: #(
		AeCairoRadialGradientPattern
		cairo_pattern_create_radial (
			double innerX,
			double innerY,
			double innerRadius,
			double outerX,
			double outerY,
			double outerRadius ) )
]
