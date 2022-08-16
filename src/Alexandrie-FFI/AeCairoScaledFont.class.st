"
I am a Cairo FFI binding for `cairo_scaled_font_t`.
A `cairo_scaled_font_t` represents a realization of a font face at a particular size and transformation and a certain set of font options.

I have a collaborator: the font extents, which is cached in an instance variable.

See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html
"
Class {
	#name : #AeCairoScaledFont,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTCairoDestroy',
	#classTraits : 'AeTCairoLibrary classTrait + AeTCairoDestroy classTrait',
	#instVars : [
		'extents'
	],
	#category : #'Alexandrie-FFI-Text'
}

{ #category : #'instance creation' }
AeCairoScaledFont class >> fontFace: aCairoFontFace fontMatrix: aFontMatrix userToDeviceMatrix: aUserToDeviceCairoMatrix options: theFontOptions [

	^ (self
		   primCreate: aCairoFontFace
		   fontMatrix: aFontMatrix
		   userToDeviceMatrix: aUserToDeviceCairoMatrix
		   options: theFontOptions)
		  autoRelease;
		  yourself
]

{ #category : #'private - ffi' }
AeCairoScaledFont class >> primCreate: aCairoFontFace fontMatrix: aFontMatrix userToDeviceMatrix: aCTM options: theFontOptions [

	^ self ffiCall: #(
		AeCairoScaledFont cairo_scaled_font_create (
			AeCairoFontFace aCairoFontFace,
			AeCairoMatrix * aFontMatrix,
			AeCairoMatrix * aCTM,
			AeCairoFontOptions theFontOptions ) )
]

{ #category : #finalization }
AeCairoScaledFont class >> primDestroy: aHandle [
	
	self ffiCall: #(void cairo_scaled_font_destroy ( void* aHandle ) )
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
AeCairoScaledFont >> glyphArrayFor: aString [

	| aBuffer |
	aBuffer := aString utf8Encoded.

	^ self glyphArrayFor: aBuffer length: aBuffer size
]

{ #category : #API }
AeCairoScaledFont >> glyphArrayFor: aBuffer length: aBufferLength [

	| aGlyphsArrayPtr aGlyphsNumPtr aStatus aGlyphsArray aGlyphsNum |
	aGlyphsArrayPtr := ExternalAddress new.
	aGlyphsNumPtr := FFIInt32 newBuffer.

	aStatus := self
		primTextToGlyphs: aBuffer
		length: aBufferLength
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

{ #category : #API }
AeCairoScaledFont >> glyphArrayForString: aString [ 
	
	| utf8Encoded |
	utf8Encoded := aString utf8Encoded.
	^ self glyphArrayFor: utf8Encoded length: utf8Encoded size
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
AeCairoScaledFont >> primStatus [

	^ self ffiCall: #(AeCairoStatus cairo_scaled_font_status ( self ) )
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

{ #category : #API }
AeCairoScaledFont >> status [

	^ self primStatus
]
