Class {
	#name : #AeFontNameValuePool,
	#superclass : #SharedPool,
	#instVars : [
		'name',
		'value'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #'instance creation' }
AeFontNameValuePool class >> value: aValue name: aName [

	^ self basicNew
		  initializeWithName: aName value: aValue;
		  yourself
]

{ #category : #comparing }
AeFontNameValuePool >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ value = anObject value
]

{ #category : #comparing }
AeFontNameValuePool >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ value hash
]

{ #category : #initializing }
AeFontNameValuePool >> initializeWithName: aString value: aNumber [

	self initialize.
	value := aNumber.
	name := aString.
]

{ #category : #accessing }
AeFontNameValuePool >> name [
	<return: #Symbol>

	^ name
]

{ #category : #printing }
AeFontNameValuePool >> printOn: aStream [
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
AeFontNameValuePool >> value [

	^ value
]
