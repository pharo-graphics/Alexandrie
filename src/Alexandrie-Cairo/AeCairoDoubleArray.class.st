Class {
	#name : #AeCairoDoubleArray,
	#superclass : #AeCairoExternalArray,
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #finalization }
AeCairoDoubleArray class >> externallyFree: aHandle [

	aHandle free
]

{ #category : #accessing }
AeCairoDoubleArray class >> type [

	^ FFIFloat64
]
