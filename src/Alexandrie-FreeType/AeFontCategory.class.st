"
I represent an abstract category for FreeType font faces. 

A `AeFileManager` uses instances of my subclasses to categorize the scanned font faces.
The users of the manager use me to query for a particular member of a font family.

"
Class {
	#name : #AeFontCategory,
	#superclass : #Object,
	#instVars : [
		'name',
		'value'
	],
	#category : #'Alexandrie-FreeType-Manager'
}

{ #category : #'instance creation' }
AeFontCategory class >> value: aValue name: aName [

	^ self basicNew
		  initializeWithName: aName value: aValue;
		  yourself
]

{ #category : #comparing }
AeFontCategory >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : #comparing }
AeFontCategory >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : #initializing }
AeFontCategory >> initializeWithName: aString value: aNumber [

	self initialize.
	value := aNumber.
	name := aString.
]

{ #category : #accessing }
AeFontCategory >> name [
	<return: #Symbol>

	^ name
]

{ #category : #printing }
AeFontCategory >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' value: ';
		print: value.
	aStream
		nextPutAll: ' name: ';
		print: name
]

{ #category : #accessing }
AeFontCategory >> value [

	^ value
]
