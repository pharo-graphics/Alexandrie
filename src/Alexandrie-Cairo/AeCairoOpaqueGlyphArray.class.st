"
I'm a binding to an array of `AeCairoGlyph` represented an opaque external object.

This is has better performance than for passing as parameters to other FFI functions.

To easy debugging, conversion API allows to obtain an array with inspectable glyphs.
"
Class {
	#name : #AeCairoOpaqueGlyphArray,
	#superclass : #FFIOpaqueObject,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#instVars : [
		'length'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoOpaqueGlyphArray class >> externallyFree: aHandle [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-glyph-free"

	self ffiCall: #( void cairo_glyph_free ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoOpaqueGlyphArray class >> fromHandle: aCollection size: anInteger [ 
	
	^ (self fromHandle: aCollection)
		length: anInteger;
		yourself
]

{ #category : #converting }
AeCairoOpaqueGlyphArray >> asExternalStructure [

	^ AeCairoGlyphArray fromHandle: handle size: length
]

{ #category : #accessing }
AeCairoOpaqueGlyphArray >> length [

	^ length
]

{ #category : #accessing }
AeCairoOpaqueGlyphArray >> length: anObject [

	length := anObject
]

{ #category : #printing }
AeCairoOpaqueGlyphArray >> printOn: aStream [

	super printOn: aStream.
	
	self asExternalStructure printGlyphsOn: aStream
]

{ #category : #accessing }
AeCairoOpaqueGlyphArray >> size [

	^ length
]
