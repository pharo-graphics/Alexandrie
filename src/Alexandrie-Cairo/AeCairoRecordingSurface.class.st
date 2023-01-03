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

{ #category : #'instance creation' }
AeCairoRecordingSurface class >> newContentType: aContentType bounds: aCairoRectangle [

	^ (self unownedNewContentType: aContentType bounds: aCairoRectangle)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoRecordingSurface class >> unownedNewContentType: aContentType bounds: aCairoRectangle [
	"Create a recording-surface which can be used to record all drawing operations at the highest level (that is, the level of paint, mask, stroke, fill and show_text_glyphs). 
	
	The recording surface can then be 'replayed' against any target surface by using it as a source to drawing operations.

	The recording phase of the recording surface is careful to snapshot all necessary objects (paths, patterns, etc.), in order to achieve accurate replay.

	Return a pointer to the newly created surface. The caller owns the surface and should call `cairo_surface_destroy()` when done with it.

	See: https://www.cairographics.org/manual/cairo-Recording-Surfaces.html#cairo-recording-surface-create"

	^ self ffiCall: #(
		AeCairoRecordingSurface
		cairo_recording_surface_create (
			AeCairoContent	aContentType,
			AeCairoRectangle * aCairoRectangle ) )
]

{ #category : #query }
AeCairoRecordingSurface >> getInkBoundsIntoX: x0 y: y0 width: width height: height [
	"Measures the extents of the operations stored within the recording-surface. This is useful to compute the required size of an image surface (or equivalent) into which to replay the full sequence of drawing operations.
	
	See: https://cairographics.org/manual/cairo-Recording-Surfaces.html#cairo-recording-surface-ink-extents"

	^ self ffiCall: #(
		void
		cairo_recording_surface_ink_extents (
			self,
			double *x0,
			double *y0,
			double *width,
			double *height ) )
]

{ #category : #query }
AeCairoRecordingSurface >> inkBounds [

	| xPointer yPointer widthPointer heightPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.
	widthPointer := FFIFloat64 newBuffer.
	heightPointer := FFIFloat64 newBuffer.

	self
		getInkBoundsIntoX: xPointer
		y: yPointer
		width: widthPointer
		height: heightPointer.

	^ (xPointer doubleAt: 1) @ (yPointer doubleAt: 1) extent:
		  (widthPointer doubleAt: 1) @ (heightPointer doubleAt: 1)
]
