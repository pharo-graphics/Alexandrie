"
I'm an array of `AeHbFeature`.
"
Class {
	#name : #AeHbFeatureArray,
	#superclass : #AeFFIExternalArray,
	#category : #'Alexandrie-Harfbuzz-Structures'
}

{ #category : #'class initialization' }
AeHbFeatureArray class >> initialize [

	resolvedType := self resolveType: AeHbFeature
]
