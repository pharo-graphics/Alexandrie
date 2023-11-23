"
I'm an array of `FFIFloat64` (double).
"
Class {
	#name : #AeFFIDoubleArray,
	#superclass : #AeFFIExternalArray,
	#category : #'Alexandrie-Base'
}

{ #category : #finalization }
AeFFIDoubleArray class >> externallyFree: aHandle [

	aHandle free
]

{ #category : #'class initialization' }
AeFFIDoubleArray class >> initialize [

	resolvedType := self resolveType: FFIFloat64
]
