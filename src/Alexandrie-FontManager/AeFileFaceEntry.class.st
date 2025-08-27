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

{ #category : #'double-dispatch' }
AeFileFaceEntry >> newHbFont [
	
	| aBlob aFace aFont |
	aBlob := AeHbBlob newLocatedAt: location.
	aFace := aBlob newHbFaceAtIndex: index.
	aFont := aFace newHbFont.
	^ aFont
]
