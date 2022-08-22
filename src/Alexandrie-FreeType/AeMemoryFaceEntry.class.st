"
I represent a FreeType font face whose bytes were loaded as a `ByteArray`.
"
Class {
	#name : #AeMemoryFaceEntry,
	#superclass : #AeFaceEntry,
	#instVars : [
		'bytes'
	],
	#category : #'Alexandrie-FreeType-Manager'
}

{ #category : #accessing }
AeMemoryFaceEntry >> bytes [

	^ bytes
]

{ #category : #accessing }
AeMemoryFaceEntry >> bytes: aByteArray [

	bytes := aByteArray
]

{ #category : #'instance creation' }
AeMemoryFaceEntry >> newFaceWith: anAeFTLibrary [ 
	
	^ anAeFTLibrary newFaceFromMemory: bytes index: index
	
]
