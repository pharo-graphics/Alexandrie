"
I'm an array of `FFIUInt8` (unsigned char).
"
Class {
	#name : 'AeFFIUInt8Array',
	#superclass : 'AeFFIExternalArray',
	#category : 'Alexandrie-Base',
	#package : 'Alexandrie-Base'
}

{ #category : 'class initialization' }
AeFFIUInt8Array class >> initialize [

	resolvedType := self resolveType: FFIUInt8
]
