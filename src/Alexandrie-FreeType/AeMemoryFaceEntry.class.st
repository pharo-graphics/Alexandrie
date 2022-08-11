Class {
	#name : #AeMemoryFaceEntry,
	#superclass : #AeFaceEntry,
	#instVars : [
		'bytes'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeMemoryFaceEntry >> bytes [

	^ bytes
]

{ #category : #accessing }
AeMemoryFaceEntry >> bytes: anObject [

	bytes := anObject
]

{ #category : #'instance creation' }
AeMemoryFaceEntry >> newFaceWith: anAeFTLibrary [ 
	
	^ anAeFTLibrary newFaceFromMemory: bytes index: index
	
]
