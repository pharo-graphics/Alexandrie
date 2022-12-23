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

{ #category : #finalization }
AeCairoGlyphArray class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_glyph_free ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> fromHandle: aHandle size: aNumber [

	^ self
		  fromHandle: aHandle
		  type: AeCairoGlyph
		  size: aNumber
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> newOf: aSize [
	"Answer a new instance of the specified size, with autoRelease."

	^ (self unboundedNewOf: aSize)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeCairoGlyphArray class >> unboundedNewOf: aSize [
	"Answer a new instance of the specified size. Sender is responsible of freeing handle."

	^ self externalNewType: AeCairoGlyph size: aSize
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
