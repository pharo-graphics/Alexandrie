"
I am a Cairo FFI binding for a `cairo_pattern_t` with a surface source.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html
"
Class {
	#name : #AeCairoSurfacePattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoSurfacePattern class >> surface: aCairoSurface [

	^ (self unownedNewFor: aCairoSurface)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoSurfacePattern class >> unownedNewFor: aCairoSurface [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-for-surface"

	^ self ffiCall: #(
		AeCairoSurfacePattern
		cairo_pattern_create_for_surface (
			AeCairoSurface aCairoSurface ) )
]
