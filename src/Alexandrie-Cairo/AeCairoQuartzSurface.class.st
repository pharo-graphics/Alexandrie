"
I am a Cairo FFI binding for a `cairo_surface_t` for Quartz.

The Quartz surface is used to render cairo graphics targeting the Apple OS X Quartz rendering system.

It is not currently supported by our bindings.

See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html
"
Class {
	#name : #AeCairoQuartzSurface,
	#superclass : #AeCairoImageSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoQuartzSurface class >> unownedNewWithFormat: aFormat width: aWidth height: aHeight [
	"See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html#cairo-quartz-surface-create"

	^ self ffiCall: #(
		AeCairoQuartzSurface
		cairo_quartz_surface_create (
			AeCairoSurfaceFormat aFormat,
			int aWidth,
			int aHeight ) )
]
