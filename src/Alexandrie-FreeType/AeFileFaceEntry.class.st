Class {
	#name : #AeFileFaceEntry,
	#superclass : #AeFaceEntry,
	#instVars : [
		'location'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFileFaceEntry >> location [

	^ location
]

{ #category : #accessing }
AeFileFaceEntry >> location: aFileReference [

	location := aFileReference
]

{ #category : #'double-dispatch' }
AeFileFaceEntry >> newFaceWith: anAeFTLibrary [ 
	
	^ anAeFTLibrary newFaceFromFile: location index: index
	
]
