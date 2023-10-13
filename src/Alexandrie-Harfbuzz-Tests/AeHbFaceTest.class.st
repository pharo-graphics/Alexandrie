"
An AeHbFaceTest is a test class for testing the behavior of AeHbFace
"
Class {
	#name : #AeHbFaceTest,
	#superclass : #TestCase,
	#instVars : [
		'inriaSerifRegularFace',
		'inriaSerifRegularBlob'
	],
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #running }
AeHbFaceTest >> setUp [

	super setUp.

	inriaSerifRegularBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	inriaSerifRegularFace := inriaSerifRegularBlob newHbFaceAtIndex: 0
]

{ #category : #tests }
AeHbFaceTest >> testGlyphCount [

	self
		assert: inriaSerifRegularFace glyphCount
		equals: 597
]

{ #category : #tests }
AeHbFaceTest >> testUnitsPerEm [

	self
		assert: inriaSerifRegularFace unitsPerEm
		equals: 1000
]
