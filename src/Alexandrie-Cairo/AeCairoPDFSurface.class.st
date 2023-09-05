"
I am a FFI binding to a PDF surface type in the Cairo library (`cairo_surface_t`).

For more information, please read the comment of my superclass.

Reference: https://cairographics.org/manual/cairo-PDF-Surfaces.html

"
Class {
	#name : #AeCairoPDFSurface,
	#superclass : #AeCairoExportSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoPDFSurface class >> unownedNewExportingTo: filename width: widthInPoints height: heightInPoints [
	"Return a newly created PDF surface of the specified size in points to be written to filename.
	
	Parameters:
	- filename: a filename for the PDF output (must be writable), NULL may be used to specify no output. This will generate a PDF surface that may be queried and used as a source, without generating a temporary file.
	- width_in_points: width of the surface, in points (1 point == 1/72.0 inch)
	- height_in_points: height of the surface, in points (1 point == 1/72.0 inch)

	See: https://cairographics.org/manual/cairo-PDF-Surfaces.html#cairo-pdf-surface-create"

	^ self ffiCall: #(
		AeCairoPDFSurface
		cairo_pdf_surface_create (
			const char * filename,
			double widthInPoints,
			double heightInPoints ) )
]
