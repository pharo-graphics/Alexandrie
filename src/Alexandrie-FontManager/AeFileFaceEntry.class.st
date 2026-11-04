"
I'm a light-weight representation of FreeType font face located in the filesystem.
"
Class {
	#name : #AeFileFaceEntry,
	#superclass : #AeFaceEntry,
	#instVars : [
		'location'
	],
	#category : #'Alexandrie-FontManager'
}

{ #category : #accessing }
AeFileFaceEntry >> location [

	^ location
]

{ #category : #accessing }
AeFileFaceEntry >> location: aFileReference [

	location := aFileReference
]

{ #category : #'instance creation' }
AeFileFaceEntry >> newFTFaceWith: anAeFTLibrary [ 
	
	^ anAeFTLibrary newFaceFromFile: location index: index
	
]
