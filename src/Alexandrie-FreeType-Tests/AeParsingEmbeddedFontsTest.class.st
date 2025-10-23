"
An AeEmbeddedFontFileTest is a test class for testing the behavior of AeEmbeddedFontFile
"
Class {
	#name : #AeParsingEmbeddedFontsTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests-Embedded'
}

{ #category : #tests }
AeParsingEmbeddedFontsTest >> testAllFaces [

	| lib |
	lib := AeFTLibrary newInitialized.
	
	self assert: (AeSourceSansPro_Regular allFacesUsing: lib) size equals: 1
]

{ #category : #tests }
AeParsingEmbeddedFontsTest >> testFirstFace [

	| lib allFaces |
	lib := AeFTLibrary newInitialized.

	allFaces := Array streamContents: [ :stream |
		AeEmbeddedFontFile allSubclassesDo: [ :each | 

			| aFTFace |
			aFTFace := each firstFaceUsing: lib.
			"Check consistency: #numberOfFaces must match"
			self
				assert: each numberOfFaces
				equals: aFTFace numberOfFaces.

			stream nextPut: aFTFace ] ].

	self assert: allFaces size equals: AeEmbeddedFontFile allSubclasses size
]
