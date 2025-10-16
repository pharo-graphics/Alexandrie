Class {
	#name : #AeCairoTextToGlyphShaping,
	#superclass : #Object,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#instVars : [
		'scaledFont',
		'x',
		'y',
		'utf8Bytes',
		'utf8ByteCount',
		'glyphs',
		'glyphCount',
		'clusters',
		'clusterCount',
		'clusterFlags',
		'stringToUtf8Converter'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #private }
AeCairoTextToGlyphShaping >> convertTextToGlyphs [
	"Convert UTF-8 text to an array of glyphs. Return `CAIRO_STATUS_SUCCESS` upon success, or an error status if the input values are wrong or if conversion failed.
	
	The user is responsible for freeing the allocated glyph array.
	
	See: https://www.cairographics.org/manual/cairo-cairo-scaled-font-t.html#cairo-scaled-font-text-to-glyphs"

	^ self ffiCall: #(
		AeCairoStatus
		cairo_scaled_font_text_to_glyphs ( 
			AeCairoScaledFont scaledFont,
			double x,
			double y,
			void * utf8Bytes,
			int utf8ByteCount,
			void ** glyphs,
			int * glyphCount,
			void ** clusters,
			int * clusterCount,
			void * clusterFlags ) )
]

{ #category : #initialization }
AeCairoTextToGlyphShaping >> initialize [

	super initialize.
	
	stringToUtf8Converter := AeUTF8Converter new.

	x := y := 0.0.

	glyphs := ExternalAddress new.
	glyphCount := FFIInt32 newBuffer.

	clusters := ExternalAddress new.
	clusterCount := FFIInt32 newBuffer.
	clusterFlags := FFIInt32 newBuffer.
]

{ #category : #API }
AeCairoTextToGlyphShaping >> newClusterArray [
	"Precondition: convertTextToGlyphs"

	| clusterArray |
	clusterCount := clusterCount signedLongAt: 1.
	clusterArray := clusterCount isZero
		ifTrue: [
			AeCairoTextClusterArray unownedNewOf: 0 ]
		ifFalse: [
			AeCairoTextClusterArray
				fromHandle: clusters
				size: clusterCount ].

	"In both cases we must take care of freeing the array."
	clusterArray autoRelease.
	
	^ clusterArray
]

{ #category : #API }
AeCairoTextToGlyphShaping >> newGlyphArray [
	"Precondition: convertTextToGlyphs"

	| glyphArray |
	"Cairo returns NULL pointer when no glyphs, so needs special treatment."
	glyphCount := glyphCount signedLongAt: 1.
	glyphArray := glyphCount isZero
		ifTrue: [
			AeCairoGlyphArray unownedNewOf: 0 ]
		ifFalse: [
			AeCairoGlyphArray
				fromHandle: glyphs
				size: glyphCount ].

	"In both cases we must take care of freeing the array."
	glyphArray autoRelease.
	
	^ glyphArray
]

{ #category : #API }
AeCairoTextToGlyphShaping >> newGlyphArrayByConvertingText [

	| aStatus glyphArray |
	aStatus := self convertTextToGlyphs.
	aStatus ensureIsSuccess.
	
	"Cairo returns NULL pointer when no glyphs, so needs special treatment."
	glyphCount := glyphCount signedLongAt: 1.
	glyphArray := glyphCount isZero
		ifTrue: [
			AeCairoGlyphArray unownedNewOf: 0 ]
		ifFalse: [
			AeCairoGlyphArray
				fromHandle: glyphs
				size: glyphCount ].

	"In both cases we must take care of freeing the array."
	glyphArray autoRelease.
	
	^ glyphArray
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> scaledFont [

	^ scaledFont
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> scaledFont: anObject [

	scaledFont := anObject
]

{ #category : #API }
AeCairoTextToGlyphShaping >> showTextGlyphsOn: cairoContext [

	self ffiCall: #(
		void
		cairo_show_text_glyphs (
			AeCairoContext cairoContext,
			const char *utf8Bytes,
			int utf8ByteCount,
			void *glyphs,
			int glyphCount,
			void *clusters,
			int clusterCount,
			int clusterFlags
			) )
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> string: aString [

	stringToUtf8Converter convert: aString.
	utf8Bytes := stringToUtf8Converter buffer.
	utf8ByteCount := stringToUtf8Converter bufferLength
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> utf8ByteCount: anObject [

	utf8ByteCount := anObject
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> utf8Bytes: anObject [

	utf8Bytes := anObject
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> x: anObject [

	x := anObject
]

{ #category : #accessing }
AeCairoTextToGlyphShaping >> y: anObject [

	y := anObject
]
