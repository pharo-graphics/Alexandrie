"
I am a Cairo FFI binding for a `cairo_surface_t` for Quartz.

The Quartz surface is used to render cairo graphics targeting the Apple OS X Quartz rendering system.

See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html
"
Class {
	#name : #AeCairoQuartzSurface,
	#superclass : #AeCairoImageSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoQuartzSurface class >> newWrapping: aCairoImageSurface [
	"Return a newly created Quartz surface backed by a CGBitmapContext that references the received surface. 
	The resulting surface can be rendered quickly when used as a source when rendering to a cairo_quartz_surface.

	See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html#cairo-quartz-image-surface-create"

	^ (self unownedNewWrapping: aCairoImageSurface)
		  autoRelease;
		  yourself
]

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

{ #category : #'instance creation' }
AeCairoQuartzSurface class >> unownedNewWrapping: aCairoImageSurface [
	"Return a newly created Quartz surface backed by a CGBitmapContext that references the received surface. 
	The resulting surface can be rendered quickly when used as a source when rendering to a cairo_quartz_surface.

	See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html#cairo-quartz-image-surface-create"

	^ self ffiCall: #(
		AeCairoImageSurface cairo_quartz_image_surface_create ( aCairoImageSurface ) )
]

{ #category : #accessing }
AeCairoQuartzSurface >> image [
	"Returns a cairo_surface_t (owned by the quartz cairo_surface_t), or NULL if the quartz surface is not an image surface.

	See: https://www.cairographics.org/manual/cairo-Quartz-Surfaces.html#cairo-quartz-image-surface-get-image"

	^ self ffiCall: #(
		AeCairoImageSurface cairo_quartz_image_surface_get_image ( self ) )
]
