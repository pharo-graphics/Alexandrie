"
I'm an array of `FFIUInt32` (unsigned int).
"
Class {
	#name : #AeFFIUInt32Array,
	#superclass : #AeFFIExternalArray,
	#category : #'Alexandrie-Base'
}

{ #category : #'class initialization' }
AeFFIUInt32Array class >> initialize [

	resolvedType := self resolveType: FFIUInt32
]
