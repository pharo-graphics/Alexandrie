"
I'm an external array specialized for Alexandrie's FFI bindings.
"
Class {
	#name : #AeFFIExternalArray,
	#superclass : #FFIExternalArray,
	#traits : 'AeTExternalFree',
	#classTraits : 'AeTExternalFree classTrait',
	#classInstVars : [
		'resolvedType'
	],
	#category : #'Alexandrie-Base'
}

{ #category : #'instance creation' }
AeFFIExternalArray class >> fromHandle: aHandle size: aNumber [

	^ self basicNew
		initializeHandle: aHandle type: resolvedType size: aNumber;
		yourself
]

{ #category : #testing }
AeFFIExternalArray class >> isAbstract [

	^ self == AeFFIExternalArray
]

{ #category : #'instance creation' }
AeFFIExternalArray class >> newFrom: anArrayedCollection [

	| newInstance |
	newInstance := self newOf: anArrayedCollection size.

	anArrayedCollection withIndexDo: [ :each :index |
		newInstance at: index put: each ].
	
	^ newInstance
]

{ #category : #'instance creation' }
AeFFIExternalArray class >> newOf: aSize [
	"Answer a new instance of the specified size, with autoRelease."

	^ (self unownedNewOf: aSize)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeFFIExternalArray class >> unownedNewOf: aSize [
	"Answer a new instance of the specified size. Sender is responsible of freeing handle."

	^ self basicNew
		initializeExternalType: resolvedType size: aSize;
		yourself
]
