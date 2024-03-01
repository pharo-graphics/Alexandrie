"
I am a Cairo FFI binding for `cairo_scaled_font_t`.
A `cairo_scaled_font_t` represents a realization of a font face at a particular size and transformation and a certain set of font options.

A scaled font is created with:
- fontFace: a `AeCairoFontFace` which represents a particular font at a particular weight, slant.
- fontMatrix: font space to user space transformation matrix for the font. In the simplest case of a N point font, this matrix is just a scale by N, but it can also be used to shear the font or stretch it unequally along the two axes.
- userToDeviceMatrix: a transformation matrix with which the font will be used.
- options: a `AeCairoFontOptions` to use when getting metrics for the font and rendering with it.

I have a collaborator: the font extents, which is cached in an instance variable.

See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html
"
Class {
	#name : #AeCairoScaledFont,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#instVars : [
		'extents',
		'fontFace'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoScaledFont class >> externallyFree: aHandle [
	"See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-destroy"

	self ffiCall: #( void cairo_scaled_font_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoScaledFont class >> fontFace: aCairoFontFace fontMatrix: aFontMatrix userToDeviceMatrix: aUserToDeviceCairoMatrix options: theFontOptions [

	^ (self
		   unownedNewFor: aCairoFontFace
		   fontMatrix: aFontMatrix
		   userToDeviceMatrix: aUserToDeviceCairoMatrix
		   options: theFontOptions)
		  fontFace: aCairoFontFace;
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoScaledFont class >> unownedNewFor: aCairoFontFace fontMatrix: aFontMatrix userToDeviceMatrix: aCTM options: theFontOptions [
	"Creates a ´cairo_scaled_font_t´ object from a font face and matrices that describe the size of the font and the environment in which it will be used.
	
	Parameters:
	- font_face: a ´cairo_font_face_t´
	- font_matrix: font space to user space transformation matrix for the font. In the simplest case of a N point font, this matrix is just a scale by N, but it can also be used to shear the font or stretch it unequally along the two axes. See ´cairo_set_font_matrix()´.
	- ctm: user to device transformation matrix with which the font will be used.
	- options: options to use when getting metrics for the font and rendering with it.
	
	Return a newly created ´cairo_scaled_font_t´. Destroy with ´cairo_scaled_font_destroy()´.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-create"
	
	^ self ffiCall: #(
		AeCairoScaledFont cairo_scaled_font_create (
			AeCairoFontFace aCairoFontFace,
			AeCairoMatrix * aFontMatrix,
			AeCairoMatrix * aCTM,
			AeCairoFontOptions theFontOptions ) )
]

{ #category : #API }
AeCairoScaledFont >> currentTransformationMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix new.
	self getCurrentTransformationMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #API }
AeCairoScaledFont >> extents [

	self
		deprecated: 'Renamed to a more explicit selector'
		transformWith: '`@receiver extents' -> '`@receiver fontExtents'.

	^ self fontExtents
]

{ #category : #API }
AeCairoScaledFont >> fontExtents [

	^ extents ifNil: [
		extents := AeCairoFontExtents new.
		self getFontExtentsInto: extents.
		extents ]
]

{ #category : #accessing }
AeCairoScaledFont >> fontFace [

	^ fontFace ifNil: [
		fontFace := self genericFontFace ]
]

{ #category : #accessing }
AeCairoScaledFont >> fontFace: aCairoFontFace [
	"Set the fonce face associated with myself."

	fontFace := aCairoFontFace
]

{ #category : #API }
AeCairoScaledFont >> fontMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix new.
	self getFontMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #API }
AeCairoScaledFont >> genericFontFace [
	"Gets the font face that this scaled font uses. This might be the font face passed on creation, but this does not hold true for all possible cases.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-get-font-face"

	^ self ffiCall: #(
		AeCairoFontFace
		cairo_scaled_font_get_font_face (
			self ))
]

{ #category : #API }
AeCairoScaledFont >> getCurrentTransformationMatrixInto: aeCairoMatrix [

	self ffiCall: #(
		void
		cairo_scaled_font_get_ctm (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #API }
AeCairoScaledFont >> getExtentsInto: aFontExtents [

	self
		deprecated: 'Renamed to a more explicit selector'
		transformWith: '`@receiver getExtentsInto: `@arg' -> '`@receiver getFontExtentsInto: `@arg'.

	^ self getFontExtentsInto: aFontExtents
]

{ #category : #API }
AeCairoScaledFont >> getFontExtentsInto: aFontExtents [

	self ffiCall: #(
		void
		cairo_scaled_font_extents (
			self,
			AeCairoFontExtents* aFontExtents
		))

]

{ #category : #API }
AeCairoScaledFont >> getFontMatrixInto: aeCairoMatrix [

	self ffiCall: #(
		void
		cairo_scaled_font_get_font_matrix (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #API }
AeCairoScaledFont >> getGlyphExtentsOf: aGlyphArray into: aTextExtents [
	"Gets the extents for an array of glyphs. 

	The extents describe a user-space rectangle that encloses the ""inked"" portion of the glyphs, (as they would be drawn by `cairo_show_glyphs()` if the cairo graphics state were set to the same font_face, font_matrix, ctm, and font_options as scaled_font)."

	self
		getGlyphExtentsOf: aGlyphArray
		size: aGlyphArray size
		into: aTextExtents
]

{ #category : #API }
AeCairoScaledFont >> getGlyphExtentsOf: aGlyphArray size: num into: aTextExtents [
	"Gets the extents for an array of glyphs. 

	The extents describe a user-space rectangle that encloses the ""inked"" portion of the glyphs, (as they would be drawn by `cairo_show_glyphs()` if the cairo graphics state were set to the same font_face, font_matrix, ctm, and font_options as scaled_font).
	Additionally, the x_advance and y_advance values indicate the amount by which the current point would be advanced by `cairo_show_glyphs()`.

	Note that whitespace glyphs do not contribute to the size of the rectangle.

	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-glyph-extents"

	self ffiCall: #(
		void
		cairo_scaled_font_glyph_extents (
			self,
			void *aGlyphArray,
			int num,
			AeCairoTextExtents *aTextExtents
		))
]

{ #category : #API }
AeCairoScaledFont >> getScaleMatrixInto: aeCairoMatrix [
	"The scale matrix is product of the font matrix and the ctm associated with the scaled font, and hence is the matrix mapping from font space to device space.

	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-get-scale-matrix"

	self ffiCall: #(
		void
		cairo_scaled_font_get_scale_matrix (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #API }
AeCairoScaledFont >> getTextExtentsOf: utf8 into: aTextExtents [
	"Gets the extents for a string of text.
	
	utf8 is a NULL-terminated string of text, encoded in UTF-8.

	The extents describe a user-space rectangle that encloses the ""inked"" portion of the text drawn at the origin (0,0) (as it would be drawn by `cairo_show_text()` if the cairo graphics state were set to the same font_face, font_matrix, ctm, and font_options as scaled_font).
	Additionally, the x_advance and y_advance values indicate the amount by which the current point would be advanced by `cairo_show_text()`.

	Note that whitespace characters do not directly contribute to the size of the rectangle.
	They do contribute indirectly by changing the position of non-whitespace characters.
	In particular, trailing whitespace characters are likely to not affect the size of the rectangle, though they will affect the x_advance and y_advance values.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-text-extents"

	self ffiCall: #(
		void
		cairo_scaled_font_text_extents (
			self,
			const char *utf8,
			AeCairoTextExtents* aTextExtents
		))

]

{ #category : #API }
AeCairoScaledFont >> getUserToDeviceMatrixInto: aeCairoMatrix [
	"See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-get-ctm"

	self ffiCall: #(
		void
		cairo_scaled_font_get_ctm (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayForString: aString [ 
	
	^ self glyphArrayForUtf8Array: aString utf8Encoded
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayForUtf8Array: aUtf8EncodedByteArray [

	^ self
		  glyphArrayForUtf8Array: aUtf8EncodedByteArray
		  size: aUtf8EncodedByteArray size
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayForUtf8Array: aUtf8EncodedByteArray size: size [

	| glyphsAddress glyphCountAddress aStatus glyphCount glyphs |
	glyphsAddress := ExternalAddress new.
	glyphCountAddress := FFIInt32 newBuffer.

	aStatus := self
		glyphsFrom: aUtf8EncodedByteArray
		size: size
		intoGlyphs: glyphsAddress
		size: glyphCountAddress.
	aStatus ensureIsSuccess.
	
	"Cairo returns NULL pointer when no glyphs, so needs special treatment."
	glyphCount := glyphCountAddress signedLongAt: 1.
	glyphs := glyphCount isZero
		ifTrue: [ AeCairoGlyphArray unownedNewOf: 0 ]
		ifFalse: [
			AeCairoOpaqueGlyphArray
				fromHandle: glyphsAddress
				size: glyphCount ].

	"In both cases we must to take care of freeing the array."
	glyphs autoRelease.
	
	^ glyphs
]

{ #category : #API }
AeCairoScaledFont >> glyphExtentsOf: aGlyphArray [
	"Gets the extents for an array of glyphs. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs."

	| textExtents |
	textExtents := AeCairoTextExtents new.
	self
		getGlyphExtentsOf: aGlyphArray
		size: aGlyphArray size
		into: textExtents.
	^ textExtents
]

{ #category : #API }
AeCairoScaledFont >> glyphsFrom: bytes size: byteCount intoGlyphs: glyphs size: glyphCount [
	"Convert UTF-8 text to an array of glyphs. Return `CAIRO_STATUS_SUCCESS` upon success, or an error status if the input values are wrong or if conversion failed.
	
	The user is responsible for freeing the allocated glyph array.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-text-to-glyphs"

	^ self ffiCall: #(
		AeCairoStatus
		cairo_scaled_font_text_to_glyphs ( 
			self,
			double 0.0,
			double 0.0,
			void * bytes,
			int byteCount,
			void ** glyphs,
			int * glyphCount,
			nil,
			nil,
			nil ) )
		options: #( - optStrict )
]

{ #category : #API }
AeCairoScaledFont >> lock [
	"See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-scaled-font-lock-face"
	
	^ self ffiCall: #(
		AeFTFace * cairo_ft_scaled_font_lock_face (self) )
]

{ #category : #API }
AeCairoScaledFont >> scaleMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix new.
	self getScaleMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #API }
AeCairoScaledFont >> status [
	"Answer the rror status for myself.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-status"

	^ self ffiCall: #(AeCairoStatus cairo_scaled_font_status ( self ) )
]

{ #category : #API }
AeCairoScaledFont >> textExtentsOf: aString [
	"Gets the extents for a String. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs."

	| textExtents |
	textExtents := AeCairoTextExtents new.
	self
		getTextExtentsOf: aString utf8Encoded
		into: textExtents.
	^ textExtents
]

{ #category : #API }
AeCairoScaledFont >> unlock [
	"See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-scaled-font-unlock-face"
	
	self ffiCall: #(
		void cairo_ft_scaled_font_unlock_face (self) )
]

{ #category : #API }
AeCairoScaledFont >> userToDeviceMatrix [
	"Answer the CTM with which I was created. 
	Note that the translation offsets are ignored."

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix new.
	self getUserToDeviceMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]
