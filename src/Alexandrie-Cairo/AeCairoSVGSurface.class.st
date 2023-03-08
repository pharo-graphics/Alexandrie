"
I am a FFI binding to a SVG surface type in the Cairo library (`cairo_surface_t`).

For more information, please read the comment of my superclass.

Reference: https://cairographics.org/manual/cairo-SVG-Surfaces.html

"
Class {
	#name : #AeCairoSVGSurface,
	#superclass : #AeCairoExportSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoSVGSurface class >> unownedNewExportingTo: filename width: width height: height [
	"Return a newly created SVG surface of the specified size in points to be written to filename.

	Parameters:
	- filename: a filename for the SVG output (must be writable), NULL may be used to specify no output. This will generate a SVG surface that may be queried and used as a source, without generating a temporary file.
	- width_in_points: width of the surface, in points (1 point == 1/72.0 inch)
	- height_in_points: height of the surface, in points (1 point == 1/72.0 inch)
	
	See: https://cairographics.org/manual/cairo-SVG-Surfaces.html#cairo-svg-surface-create"

	^ self ffiCall: #(
		AeCairoSVGSurface
		cairo_svg_surface_create (
			String filename,
			double width, 
			double height ) )
]
