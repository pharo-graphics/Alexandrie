"
An AeEmbeddedFontFileTest is a test class for testing the behavior of AeEmbeddedFontFile
"
Class {
	#name : #AeEmbeddedFontFileTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests-Embedded'
}

{ #category : #tests }
AeEmbeddedFontFileTest >> testAllFaces [

	| lib |
	lib := AeFTLibraryResource current library.
	
	self denyEmpty: (AeSourceSansPro_Regular allFacesUsing: lib)
]

{ #category : #tests }
AeEmbeddedFontFileTest >> testFirstFace [

	| lib allFaces |
	lib := AeFTLibraryResource current library.

	allFaces := Array streamContents: [ :stream |
		AeEmbeddedFontFile allSubclassesDo: [ :each | 

			| aFTFace |
			aFTFace := each firstFaceUsing: lib.
			"Check consistency: #numberOfFaces must match"
			self
				assert: each numberOfFaces
				equals: aFTFace numberOfFaces.

			stream nextPut: aFTFace ] ].

	self denyEmpty: allFaces
]
