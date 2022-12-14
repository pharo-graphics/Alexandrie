"
I am a Cairo FFI binding for `cairo_scaled_font_t`.
A `cairo_scaled_font_t` represents a realization of a font face at a particular size and transformation and a certain set of font options.

I have a collaborator: the font extents, which is cached in an instance variable.

See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html
"
Class {
	#name : #AeCairoScaledFont,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#instVars : [
		'extents'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoScaledFont class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_scaled_font_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoScaledFont class >> fontFace: aCairoFontFace fontMatrix: aFontMatrix userToDeviceMatrix: aUserToDeviceCairoMatrix options: theFontOptions [

	^ (self
		   unownedNewFor: aCairoFontFace
		   fontMatrix: aFontMatrix
		   userToDeviceMatrix: aUserToDeviceCairoMatrix
		   options: theFontOptions)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
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
	aCairoMatrix := AeCairoMatrix externalNew autoRelease; yourself.
	self primGetCurrentTransformationMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #API }
AeCairoScaledFont >> extents [

	^ extents ifNil: [
		extents := AeCairoFontExtents new.
		self primExtents: extents.
		extents ]
]

{ #category : #API }
AeCairoScaledFont >> fontMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix externalNew autoRelease; yourself.
	self primGetFontMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayForString: aString [ 
	
	^ self glyphArrayForUtf8Array: aString utf8Encoded
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayForUtf8Array: aUtf8EncodedByteArray [

	| aGlyphsArrayPtr aGlyphsNumPtr aStatus aGlyphsArray aGlyphsNum |
	aGlyphsArrayPtr := ExternalAddress new.
	aGlyphsNumPtr := FFIInt32 newBuffer.

	aStatus := self
		primTextToGlyphs: aUtf8EncodedByteArray
		length: aUtf8EncodedByteArray size
		glyphs: aGlyphsArrayPtr
		num: aGlyphsNumPtr
		x: 0.0
		y: 0.0.
	aStatus isSuccess ifFalse: [ self error: aStatus asString ].
	
	aGlyphsNum := aGlyphsNumPtr signedLongAt: 1.
	aGlyphsArray := aGlyphsNum isZero
		ifTrue: [ AeCairoGlyphArray externalNewEmpty ]
		ifFalse: [ AeCairoGlyphArray fromHandle: aGlyphsArrayPtr size: aGlyphsNum ].
	
	aGlyphsArray autoRelease.
	
	^ aGlyphsArray
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> lock [
	"See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-scaled-font-lock-face"
	
	^ self ffiCall: #(
		AeFTFace * cairo_ft_scaled_font_lock_face (self) )
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primExtents: aFontExtents [

	self ffiCall: #(
		void cairo_scaled_font_extents (
			self,
			AeCairoFontExtents* aFontExtents
		))

]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primExtents: aTextExtents text: utf8 [

	self ffiCall: #(
		void cairo_scaled_font_text_extents (
			self,
			const char *utf8,
			AeCairoTextExtents* aTextExtents
		))

]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primGetCurrentTransformationMatrixInto: aeCairoMatrix [

	^ self ffiCall: #(
		void
		cairo_scaled_font_get_ctm (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primGetFontMatrixInto: aeCairoMatrix [

	^ self ffiCall: #(
		void
		cairo_scaled_font_get_font_matrix (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primGetScaleMatrixInto: aeCairoMatrix [

	^ self ffiCall: #(
		void
		cairo_scaled_font_get_scale_matrix (
			self,
			AeCairoMatrix *aeCairoMatrix ))
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> primTextToGlyphs: aBuffer length: aLength glyphs: theGlyphs num: aGlyphsCount x: aX y: aY [

	^ self ffiCall: #(
		AeCairoStatus
		cairo_scaled_font_text_to_glyphs ( 
			self,
			double aX,
			double aY,
			void * aBuffer,
			int aLength,
			void ** theGlyphs,
			"int" void * aGlyphsCount,
			nil,
			nil,
			nil))
]

{ #category : #API }
AeCairoScaledFont >> scaleMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix externalNew autoRelease; yourself.
	self primGetScaleMatrixInto: aCairoMatrix.
	^ aCairoMatrix
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> status [

	^ self ffiCall: #(AeCairoStatus cairo_scaled_font_status ( self ) )
]

{ #category : #'private - ffi' }
AeCairoScaledFont >> unlock [
	"See: https://www.cairographics.org/manual/cairo-FreeType-Fonts.html#cairo-ft-scaled-font-unlock-face"
	
	self ffiCall: #(
		void cairo_ft_scaled_font_unlock_face (self) )
]
