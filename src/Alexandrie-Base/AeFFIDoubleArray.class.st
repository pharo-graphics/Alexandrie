"
I'm an array of `FFIFloat64` (double).
"
Class {
	#name : 'AeFFIDoubleArray',
	#superclass : 'AeFFIExternalArray',
	#category : 'Alexandrie-Base',
	#package : 'Alexandrie-Base'
}

{ #category : 'class initialization' }
AeFFIDoubleArray class >> initialize [

	resolvedType := self resolveType: FFIFloat64
]
