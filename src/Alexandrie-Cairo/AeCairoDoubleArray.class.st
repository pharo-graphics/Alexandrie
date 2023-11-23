"
I'm an array of `FFIFloat64` (double).
"
Class {
	#name : #AeCairoDoubleArray,
	#superclass : #AeCairoExternalArray,
	#category : #'Alexandrie-Cairo-Structures'
}

{ #category : #finalization }
AeCairoDoubleArray class >> externallyFree: aHandle [

	aHandle free
]

{ #category : #accessing }
AeCairoDoubleArray class >> initialize [

	resolvedType := self resolveType: FFIFloat64
]
