Class {
	#name : #AeFileFaceEntry,
	#superclass : #AeFaceEntry,
	#instVars : [
		'location',
		'index'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFileFaceEntry >> index [

	^ index
]

{ #category : #accessing }
AeFileFaceEntry >> index: aZeroBasedInteger [

	index := aZeroBasedInteger
]

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
