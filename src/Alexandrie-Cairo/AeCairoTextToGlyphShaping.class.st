Class {
	#name : #AeCairoTextToGlyphShaping,
	#superclass : #Object,
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

	clusters := nil.
	clusterCount := nil.
	clusterFlags := nil.
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
			AeCairoOpaqueGlyphArray
				fromHandle: glyphs
				size: glyphCount ].

	"In both cases we must to take care of freeing the array."
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
			const cairo_text_cluster_t *clusters,
			int clusterCount,
			cairo_text_cluster_flags_t clusterFlags
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
