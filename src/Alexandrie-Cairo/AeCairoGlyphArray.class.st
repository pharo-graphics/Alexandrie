"
I'm an array of `AeCairoGlyph`.
"
Class {
	#name : #AeCairoGlyphArray,
	#superclass : #AeCairoExternalArray,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoGlyphArray class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_glyph_free ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> type [

	^ AeCairoGlyph
]
