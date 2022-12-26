Class {
	#name : #AeCairoExternalArray,
	#superclass : #FFIExternalArray,
	#traits : 'AeTExternalFree',
	#classTraits : 'AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #'instance creation' }
AeCairoExternalArray class >> fromHandle: aHandle size: aNumber [

	^ self
		  fromHandle: aHandle
		  type: self type
		  size: aNumber
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

	^ (self unboundedNewOf: aSize)
		  autoRelease;
		  yourself
]

{ #category : #accessing }
AeCairoExternalArray class >> type [

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
AeCairoExternalArray class >> unboundedNewOf: aSize [
	"Answer a new instance of the specified size. Sender is responsible of freeing handle."

	^ self externalNewType: self type size: aSize
]

{ #category : #'external resource management' }
AeCairoExternalArray >> autoRelease [
	"Note, subclasses should implement #resourceData
	and #finalizeResourceData: on class side"
	FFIExternalResourceManager addResource: self
]

{ #category : #'external resource management' }
AeCairoExternalArray >> resourceData [

	^ handle
]
