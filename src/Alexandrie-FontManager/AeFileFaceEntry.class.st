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

{ #category : #'double-dispatch' }
AeFileFaceEntry >> newFaceWith: anAeFTLibrary [ 
	
	^ anAeFTLibrary newFaceFromFile: location index: index
	
]

{ #category : #'instance creation' }
AeFileFaceEntry >> newHbFont [
	
	| aBlob aFace |
	aBlob := AeHbBlob newLocatedAt: location.
	aFace := aBlob newHbFaceAtIndex: index.
	^ aFace newHbFont
]
