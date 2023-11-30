"
I'm an array of `AeHbGlyphPosition`.
"
Class {
	#name : 'AeHbGlyphPositionArray',
	#superclass : 'AeFFIExternalArray',
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'class initialization' }
AeHbGlyphPositionArray class >> initialize [

	resolvedType := self resolveType: AeHbGlyphPosition
]
