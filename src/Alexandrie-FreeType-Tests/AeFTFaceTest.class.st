"
An AeFTFaceTest is a test class for testing the behavior of AeFTFace
"
Class {
	#name : #AeFTFaceTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests-FFI'
}

{ #category : #tests }
AeFTFaceTest >> testSfnt [

	| aFace table |
	aFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	
	self assert: aFace isSfnt.
	table := aFace sfntOS2Table.

	self deny: table isNull.
	self assert: table yStrikeoutPosition equals: 291.
	self assert: table yStrikeoutSize equals: 50
]
