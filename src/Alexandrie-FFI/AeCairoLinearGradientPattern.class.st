"
I am a Cairo FFI binding for a `cairo_pattern_t` with a linear gradient source.

See my instance creation protocol.
"
Class {
	#name : #AeCairoLinearGradientPattern,
	#superclass : #AeCairoGradientPattern,
	#category : #'Alexandrie-FFI-Patterns'
}

{ #category : #'instance creation' }
AeCairoLinearGradientPattern class >> from: aFromPoint to: aToPoint [

	^ (self
		   primCreateFromX: aFromPoint x
		   fromY: aFromPoint y
		   toX: aToPoint x
		   toY: aToPoint y)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoLinearGradientPattern class >> primCreateFromX: fromX fromY: fromY toX: toX toY: toY [

	^ self ffiCall: #( AeCairoLinearGradientPattern cairo_pattern_create_linear (
			double fromX,
			double fromY,
			double toX,
			double toY ) )
]
