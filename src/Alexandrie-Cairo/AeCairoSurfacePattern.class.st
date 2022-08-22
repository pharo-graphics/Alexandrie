"
I am a Cairo FFI binding for a `cairo_pattern_t` with a surface source.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html
"
Class {
	#name : #AeCairoSurfacePattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'private - ffi' }
AeCairoSurfacePattern class >> primCreateSurface: aCairoSurface [

	^ self ffiCall: #(AeCairoSurfacePattern cairo_pattern_create_for_surface (
		AeCairoSurface aCairoSurface ) )
]

{ #category : #'instance creation' }
AeCairoSurfacePattern class >> surface: aCairoSurface [

	^ (self primCreateSurface: aCairoSurface)
		  autoRelease;
		  yourself
]
