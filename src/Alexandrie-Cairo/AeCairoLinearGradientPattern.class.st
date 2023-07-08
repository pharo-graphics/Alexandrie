"
I am a Cairo FFI binding for a `cairo_pattern_t` with a linear gradient source.

See my instance creation protocol.
"
Class {
	#name : #AeCairoLinearGradientPattern,
	#superclass : #AeCairoGradientPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoLinearGradientPattern class >> from: aFromPoint to: aToPoint [

	^ (self
		   unownedNewFromX: aFromPoint x
		   fromY: aFromPoint y
		   toX: aToPoint x
		   toY: aToPoint y)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoLinearGradientPattern class >> from: aFromPoint to: aToPoint addStopsFrom: offsetColorAssociations [

	^ (self from: aFromPoint to: aToPoint)
		  addStopsFrom: offsetColorAssociations;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoLinearGradientPattern class >> unownedNewFromX: fromX fromY: fromY toX: toX toY: toY [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-linear"

	^ self ffiCall: #(
		AeCairoLinearGradientPattern
		cairo_pattern_create_linear (
			double fromX,
			double fromY,
			double toX,
			double toY ) )
]
