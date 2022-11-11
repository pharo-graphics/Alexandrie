"
I'm an array of `AeCairoGlyph`.
"
Class {
	#name : #AeCairoGlyphArray,
	#superclass : #FFIExternalArray,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'instance creation' }
AeCairoGlyphArray class >> externalNew: aSize [

	^ self externalNewType: AeCairoGlyph size: aSize
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> externalNewEmpty [

	^ self externalNewType: AeCairoGlyph size: 0
]

{ #category : #finalization }
AeCairoGlyphArray class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_glyph_free ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> fromHandle: aGlyphsArrayPtr size: aGlyphsNum [

	^ self
		  fromHandle: aGlyphsArrayPtr
		  type: AeCairoGlyph
		  size: aGlyphsNum
]

{ #category : #'external resource management' }
AeCairoGlyphArray >> autoRelease [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"
	FFIExternalResourceManager addResource: self
]

{ #category : #'external resource management' }
AeCairoGlyphArray >> resourceData [

	^ handle
]
