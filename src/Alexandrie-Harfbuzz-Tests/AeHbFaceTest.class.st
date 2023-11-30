"
An AeHbFaceTest is a test class for testing the behavior of AeHbFace
"
Class {
	#name : 'AeHbFaceTest',
	#superclass : 'TestCase',
	#instVars : [
		'inriaSerifRegularFace',
		'inriaSerifRegularBlob',
		'emojiBlob',
		'emojiFace'
	],
	#category : 'Alexandrie-Harfbuzz-Tests',
	#package : 'Alexandrie-Harfbuzz-Tests'
}

{ #category : 'running' }
AeHbFaceTest >> setUp [

	super setUp.

	inriaSerifRegularBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	inriaSerifRegularFace := inriaSerifRegularBlob newHbFaceAtIndex: 0.
	emojiBlob := AeHbBlob newLocatedAt: AeNotoColorEmojiDownloadedFont new fileReference.
	emojiFace := emojiBlob newHbFaceAtIndex: 0.
]

{ #category : 'tests' }
AeHbFaceTest >> testAsString [

	self
		assert: inriaSerifRegularFace asString
		equals: 'an AeHbFace(Inria Serif, Regular)'
]

{ #category : 'tests' }
AeHbFaceTest >> testGlyphCount [

	self
		assert: inriaSerifRegularFace glyphCount
		equals: 597
]

{ #category : 'tests' }
AeHbFaceTest >> testHasColor [

	self skip: 'This API requires Harfbuzz >= 7.0.0'.

	self deny: inriaSerifRegularFace hasColor.
	self assert: emojiFace hasColor
]

{ #category : 'tests' }
AeHbFaceTest >> testHasLayers [

	self deny: inriaSerifRegularFace hasLayers.
	self deny: emojiFace hasLayers
]

{ #category : 'tests' }
AeHbFaceTest >> testHasPaint [

	self skip: 'This API requires Harfbuzz >= 7.0.0'.

	self deny: inriaSerifRegularFace hasPaint.
	self deny: emojiFace hasPaint
]

{ #category : 'tests' }
AeHbFaceTest >> testHasPng [

	self deny: inriaSerifRegularFace hasPng.
	self assert: emojiFace hasPng
]

{ #category : 'test' }
AeHbFaceTest >> testOpenTypeFontFamily [

	self
		assert: inriaSerifRegularFace openTypeFontFamily
		equals: 'Inria Serif'.
	self
		assert: emojiFace openTypeFontFamily
		equals: 'Noto Color Emoji'
]

{ #category : 'test' }
AeHbFaceTest >> testOpenTypeFontSubfamily [

	self
		assert: inriaSerifRegularFace openTypeFontSubfamily
		equals: 'Regular'.
	self
		assert: emojiFace openTypeFontSubfamily
		equals: 'Regular'
]

{ #category : 'tests' }
AeHbFaceTest >> testUnitsPerEm [

	self
		assert: inriaSerifRegularFace unitsPerEm
		equals: 1000
]
