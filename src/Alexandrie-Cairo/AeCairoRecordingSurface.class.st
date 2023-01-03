"
I am a Cairo FFI binding for a Recording `cairo_surface_t`.

A recording surface is a surface that records all drawing operations at the highest level of the surface backend interface, (that is, the level of paint, mask, stroke, fill, and show glyphs). The recording surface can then be ""replayed"" against any target surface by using it as a source surface.

If you want to replay a surface so that the results in target will be identical to the results that would have been obtained if the original operations applied to the recording surface had instead been applied to the target surface, you can set this surface as source and paint with it.

See: https://www.cairographics.org/manual/cairo-Recording-Surfaces.html
"
Class {
	#name : #AeCairoRecordingSurface,
	#superclass : #AeCairoSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'private - ffi' }
AeCairoRecordingSurface class >> newContentType: aContentType bounds: aCairoRectangle [

	^ (self unownedNewContentType: aContentType bounds: aCairoRectangle)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoRecordingSurface class >> unownedNewContentType: aContentType bounds: aCairoRectangle [
	"Create a recording-surface which can be used to record all drawing operations at the highest level (that is, the level of paint, mask, stroke, fill and show_text_glyphs). 
	
	The recording surface can then be 'replayed' against any target surface by using it as a source to drawing operations.

	The recording phase of the recording surface is careful to snapshot all necessary objects (paths, patterns, etc.), in order to achieve accurate replay.

	Return a pointer to the newly created surface. The caller owns the surface and should call `cairo_surface_destroy()` when done with it.

	See: https://www.cairographics.org/manual/cairo-Recording-Surfaces.html#cairo-recording-surface-create"

	^ self ffiCall: #(
		AeCairoImageSurface
		cairo_recording_surface_create (
			AeCairoContent	aContentType,
			AeCairoRectangle * aCairoRectangle ) )
]
