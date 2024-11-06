"
I am a Cairo FFI binding for an Image `cairo_surface_t`.

See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html
"
Class {
	#name : #AeCairoImageSurface,
	#superclass : #AeCairoSurface,
	#category : #'Alexandrie-Cairo-Surfaces'
}

{ #category : #'instance creation' }
AeCairoImageSurface class >> extent: aPoint [

	^ self
		  extent: aPoint
		  format: AeCairoSurfaceFormat argb32
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> extent: anExtent format: aSurfaceFormat [

	^ (self
		   unownedNewWithFormat: aSurfaceFormat
		   width: anExtent x
		   height: anExtent y)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> fromForm: aForm [
	"Answer a new surface with ARGB32 format, by converting the received `Form` to premultiplied alpha.
	Translucent pixels may loose information (the conversion is not looseless).

	Quote CAIRO_FORMAT_ARGB32 description: each pixel is a 32-bit quantity, with alpha in the upper 8 bits, then red, then green, then blue. The 32-bit quantities are stored native-endian. Pre-multiplied alpha is used. (That is, 50% transparent red is 0x80800000, not 0x80ff0000.)
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-format-t"

	| form aSurface dataHandle |
	aSurface := self
		extent: aForm extent
		format: AeCairoSurfaceFormat argb32.
	dataHandle := aSurface data.

	"Received form may be hibernated"
	aForm unhibernate.

	"Ensure we are working on 32-bits (Note: it may answer same instance)"
	form := aForm asFormOfDepth: 32.

	"Convert Form bits to premultiplied alpha"
	form bits withIndexDo: [ :pixel :oneBasedPixelIndex |
		| alpha zeroBasedSurfaceIndex a r g b |
		alpha := (pixel >> 24) / 255.0.
		a := pixel bitAnd: 16rFF000000.
		r := ((pixel >> 16 bitAnd: 255) * alpha) asInteger << 16.
		g := ((pixel >> 8  bitAnd: 255) * alpha) asInteger << 8.
		b := ((pixel       bitAnd: 255) * alpha) asInteger.
		zeroBasedSurfaceIndex := (oneBasedPixelIndex - 1) << 2.
		dataHandle
			uint32AtOffset: zeroBasedSurfaceIndex
			put: a + r + g + b ].

	^ aSurface
		markDirty;
		yourself
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> newForData: aData extent: aPoint stride: stride format: aSurfaceFormat [

	^ (self
		   unownedNewForData: aData
		   width: aPoint x
		   height: aPoint y
		   stride: stride
		   format: aSurfaceFormat)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> newFromPngFileAt: aFileReference [

	| encodedPath newInstance |
	encodedPath := aFileReference pathString nullTerminatedEncodeWith: #utf8.
	newInstance := self unownedNewFromPngFileAt: encodedPath.
	newInstance status ensureIsSuccess.
	newInstance autoRelease.
	^ newInstance
]

{ #category : #query }
AeCairoImageSurface class >> strideForWidth: aWidth format: aSurfaceFormat [
	"This function provides a stride value that will respect all alignment requirements of the accelerated image-rendering code within cairo.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-format-stride-for-width"

	^ self ffiCall: #(
		int
		cairo_format_stride_for_width (
			AeCairoSurfaceFormat	aSurfaceFormat,
			int aWidth ) )
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> unownedNewForData: aData width: width height: height stride: stride format: aSurfaceFormat [
	"Creates an image surface for the provided pixel data. The output buffer must be kept around until the cairo_surface_t is destroyed or cairo_surface_finish() is called on the surface. The initial contents of data will be used as the initial image contents; you must explicitly clear the buffer, using, for example, cairo_rectangle() and cairo_fill() if you want it cleared.

	The stride is the number of bytes between the start of rows in the buffer as allocated. This value should always be computed by cairo_format_stride_for_width() before allocating the data buffer.
	
	Note that the stride may be larger than width*bytes_per_pixel to provide proper alignment for each pixel and row. This alignment is required to allow high-performance rendering within cairo. The correct way to obtain a legal stride value is to call cairo_format_stride_for_width() with the desired format and maximum image width value, and then use the resulting stride value to allocate the data and to create the image surface.

	Return a pointer to the newly created surface. The caller owns the surface and should call cairo_surface_destroy() when done with it.

	This function always returns a valid pointer, but it will return a pointer to a ""nil"" surface in the case of an error such as out of memory or an invalid stride value. In case of invalid stride value the error status of the returned surface will be CAIRO_STATUS_INVALID_STRIDE. You can use cairo_surface_status() to check for this.

	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-create-for-data"

	^ self ffiCall: #(
		AeCairoImageSurface
		cairo_image_surface_create_for_data (
			void* aData,
			AeCairoSurfaceFormat aSurfaceFormat,
			int width,
			int height,
			int stride ) )
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> unownedNewFromPngFileAt: pathUTF8Encoded [
	"Return a new instance initialized with the contents of the PNG file, or a nil surface if any error occurred. A nil surface can be checked for with `cairo_surface_status()`.

	See: https://www.cairographics.org/manual/cairo-PNG-Support.html#cairo-image-surface-create-from-png"

	^ self ffiCall: #(
		AeCairoImageSurface
		cairo_image_surface_create_from_png (
			const char * pathUTF8Encoded ) )
]

{ #category : #'instance creation' }
AeCairoImageSurface class >> unownedNewWithFormat: aSurfaceFormat width: aWidth height: aHeight [
	"Answer a new image surface of the specified format and dimensions.
	
	Initially the surface contents are set to 0. (Specifically, within each pixel, each color or alpha channel belonging to format will be 0. The contents of bits within a pixel, but not belonging to the given format are undefined).
	
	The caller owns the surface and should call `cairo_surface_destroy()` when done with it.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-create"

	^ self ffiCall: #(
		AeCairoImageSurface
		cairo_image_surface_create (
			AeCairoSurfaceFormat	aSurfaceFormat,
			int aWidth,
			int aHeight ) )
]

{ #category : #converting }
AeCairoImageSurface >> asARGB32ImageSurface [

	| aSurface |
	aSurface := self
		newSimilarImageFormat: AeCairoSurfaceFormat argb32
		width: self width 
		height: self height.
	aSurface status ensureIsSuccess.
	aSurface deviceScale: self deviceScale.

	aSurface newContext
		sourceSurface: self;
		paint.

	^ aSurface
]

{ #category : #converting }
AeCairoImageSurface >> asAlphaChannelGrayscaleImage [
	"Answer new image surface with my pixels converted to grayscale."

	| aSurface aContext |
	aSurface := self
		newSimilarImageFormat: AeCairoSurfaceFormat argb32
		width: self width
		height: self height.
	aSurface status ensureIsSuccess.
	aSurface deviceScale: self deviceScale.

	aContext := aSurface newContext.
	aContext
		sourceColorR: 1.0 g: 1.0 b: 1.0;
		paint;
		sourceColorR: 0.0 g: 0.0 b: 0.0;
	 	maskSurface: self x: 0.0 y: 0.0.

	^ aSurface

]

{ #category : #converting }
AeCairoImageSurface >> asForm [
	"Answer a Form representation of myself."

	"No way to convert to Form if handle is NULL.
	It would provoke a segmentation fault if sent from an
	inspector, for example."
	self getHandle isNull ifTrue: [
		^ Form extent: 0@0 depth: 32 ].
	
	self format = AeCairoSurfaceFormat argb32
		ifTrue: [ ^ self asFormARGB32 ].
	self format = AeCairoSurfaceFormat rgb24
		ifTrue: [ ^ self asARGB32ImageSurface asForm ].
	self format = AeCairoSurfaceFormat a8
		ifTrue: [ ^ self asFormA8 ].

	self notYetImplemented
]

{ #category : #converting }
AeCairoImageSurface >> asFormA8 [
	"Answer a 32-bits Form where each of my A8 pixels is converted to grayscale ARGB8.
	Not the most efficient implementation, but should be enough for debugging purposes.

	Assumes:
		self format = AeCairoSurfaceFormat CAIRO_FORMAT_A8
	"

	^ self asAlphaChannelGrayscaleImage asForm

]

{ #category : #converting }
AeCairoImageSurface >> asFormARGB32 [
	"Answer myself converted as a 32-bits Form.
	This means converting pixels from premultiplied-alpha to straight-alpha.

	Assumes:
		self format = AeCairoSurfaceFormat CAIRO_FORMAT_ARGB32 "

	| aSizeInWords bits |
	aSizeInWords := self byteSize >> 2.
	aSizeInWords = 0 ifTrue: [ 
		^ Form extent: self extent depth: 32 ].
	
	bits := Bitmap
		new: aSizeInWords
		streamContents: [ :stream |
			| words |
			self flush.
			words := AeFFIUInt32Array
				fromHandle: self data
				size: aSizeInWords.
			words do: [ :pixel |
				| alpha |
				alpha := pixel >> 24.
				stream nextPut: (alpha = 0
					ifTrue: [ 16r00FFFFFF ]
					ifFalse: [
						| alphaFix a r g b |
						alphaFix := 255.0 / alpha.
						a := pixel bitAnd: 16rFF000000.
						r := (((pixel >> 16 bitAnd: 255) * alphaFix) asInteger) << 16.
						g := (((pixel >> 8  bitAnd: 255) * alphaFix) asInteger) << 8.
						b := (((pixel       bitAnd: 255) * alphaFix) asInteger).
						a + r + g + b ]) ] ].

	^ Form extent: self extent depth: 32 bits: bits
]

{ #category : #API }
AeCairoImageSurface >> byteSize [

	^ self height * self stride
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> data [
	"Get a pointer to the data of the image surface, for direct inspection or modification.

A call to `cairo_surface_flush()` is required before accessing the pixel data to ensure that all pending drawing operations are finished. A call to `cairo_surface_mark_dirty()` is required after the data is modified.

	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-get-data"

	^ self ffiCall: #( uchar* cairo_image_surface_get_data ( self ) )
]

{ #category : #API }
AeCairoImageSurface >> extent [

	^ self width @ self height
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> format [
	"Answer the format of this surface.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-get-format"

	^ self ffiCall: #( AeCairoSurfaceFormat cairo_image_surface_get_format (self) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> height [
	"Answer the pixel height of this image surface.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-get-height"

	^ self ffiCall: #( int cairo_image_surface_get_height ( self ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> newSimilarImageFormat: aFormat width: aWidth height: aHeight [

	^ (self
		   unownedSimilarImageFormat: aFormat
		   width: aWidth
		   height: aHeight)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> stride [
	"Answer the stride of the image surface in bytes.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-get-stride"

	^ self ffiCall: #( int cairo_image_surface_get_stride ( self ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> unownedSimilarImageFormat: aFormat width: aWidth height: aHeight [
	"Create a new image surface that is as compatible as possible for uploading to and the use in conjunction with an existing surface. However, this surface can still be used like any normal image surface. Unlike `cairo_surface_create_similar()` the new image surface won't inherit the device scale from other.

	Initially the surface contents are all 0 (transparent if contents have transparency, black otherwise.)

	Answer a pointer to the newly allocated image surface. The caller owns the surface and should call `cairo_surface_destroy()` when done with it.
	
	See: https://www.cairographics.org/manual/cairo-cairo-surface-t.html#cairo-surface-create-similar-image"

	^ self ffiCall: #(
		AeCairoImageSurface
		cairo_surface_create_similar_image (
			self,
			AeCairoSurfaceFormat aFormat,
			int aWidth,
			int aHeight ) )
]

{ #category : #'private - ffi' }
AeCairoImageSurface >> width [
	"Answer the pixel width of this image surface.
	
	See: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-image-surface-get-width"

	^ self ffiCall: #( int cairo_image_surface_get_width ( self ) )
]

{ #category : #API }
AeCairoImageSurface >> writePngTo: aFileReference [

	| utf8EncodedPath status |
	utf8EncodedPath := aFileReference pathString nullTerminatedEncodeWith: #utf8.
	status := self writePngToPathString: utf8EncodedPath.
	status ensureIsSuccess.
	^ status
]

{ #category : #API }
AeCairoImageSurface >> writePngToPathString: path [
	"Write the contents of surface to a new file filename as a PNG image.
	Returns CAIRO_STATUS_SUCCESS if the PNG file was written successfully.

	See: https://www.cairographics.org/manual/cairo-PNG-Support.html#cairo-surface-write-to-png"

	^ self ffiCall: #(
		AeCairoStatus
		cairo_surface_write_to_png (
			self,
			const char *path ) )
]
