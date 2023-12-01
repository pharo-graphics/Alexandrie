"
I'm an array of `AeHbFeature`.
"
Class {
	#name : 'AeHbFeatureArray',
	#superclass : 'AeFFIExternalArray',
	#category : 'Alexandrie-Harfbuzz-Structures',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Structures'
}

{ #category : 'class initialization' }
AeHbFeatureArray class >> initialize [

	resolvedType := self resolveType: AeHbFeature
]
