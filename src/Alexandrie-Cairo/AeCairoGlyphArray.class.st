"
I'm an array of `AeCairoGlyph`.
"
Class {
	#name : #AeCairoGlyphArray,
	#superclass : #AeFFIExternalArray,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #finalization }
AeCairoGlyphArray class >> externallyFree: aHandle [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-glyph-free"

	self ffiCall: #( void cairo_glyph_free ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> initialize [

	resolvedType := self resolveType: AeCairoGlyph
]

{ #category : #printing }
AeCairoGlyphArray >> printGlyphsOn: aStream [

	aStream nextPut: $(.
	self
		do: [ :each | each printShortOn: aStream ]
		separatedBy: [ aStream space ].
	aStream nextPut: $)
]
