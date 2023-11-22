"
I'm an external array specialized for Cairo FFI bindings.
"
Class {
	#name : #AeCairoExternalArray,
	#superclass : #FFIExternalArray,
	#traits : 'AeTExternalFree',
	#classTraits : 'AeTExternalFree classTrait',
	#classInstVars : [
		'resolvedType'
	],
	#category : #'Alexandrie-Cairo-Structures'
}

{ #category : #'instance creation' }
AeCairoExternalArray class >> fromHandle: aHandle size: aNumber [

	^ self
		  fromHandle: aHandle
		  type: self type
		  size: aNumber
]

{ #category : #'class initialization' }
AeCairoExternalArray class >> initialize [

	resolvedType := self resolveType: self type
]

{ #category : #'instance creation' }
AeCairoExternalArray class >> newFrom: anArrayedCollection [

	| newInstance |
	newInstance := self newOf: anArrayedCollection size.

	anArrayedCollection withIndexDo: [ :each :index |
		newInstance at: index put: each ].
	
	^ newInstance
]

{ #category : #'instance creation' }
AeCairoExternalArray class >> newOf: aSize [
	"Answer a new instance of the specified size, with autoRelease."

	^ (self unownedNewOf: aSize)
		  autoRelease;
		  yourself
]

{ #category : #accessing }
AeCairoExternalArray class >> type [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
AeCairoExternalArray class >> unownedNewOf: aSize [
	"Answer a new instance of the specified size. Sender is responsible of freeing handle."

	^ self basicNew
		initializeExternalType: resolvedType size: aSize;
		yourself
]
