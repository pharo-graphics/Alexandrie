"
I'm an array of `AeHbGlyphInfo`.
"
Class {
	#name : 'AeHbGlyphInfoArray',
	#superclass : 'AeFFIExternalArray',
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'class initialization' }
AeHbGlyphInfoArray class >> initialize [

	resolvedType := self resolveType: AeHbGlyphInfo
]
