"
An AeHbFontTest is a test class for testing the behavior of AeHbFont
"
Class {
	#name : #AeHbFontTest,
	#superclass : #TestCase,
	#instVars : [
		'inriaSerifRegularBlob',
		'inriaSerifRegularFace',
		'inriaSerifRegularFont'
	],
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #running }
AeHbFontTest >> setUp [

	super setUp.

	inriaSerifRegularBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	inriaSerifRegularFace := inriaSerifRegularBlob newHbFaceAtIndex: 0.
	inriaSerifRegularFont := inriaSerifRegularFace newHbFont
]

{ #category : #tests }
AeHbFontTest >> testAsString [

	self
		assert: inriaSerifRegularFont asString
		equals: 'an AeHbFont(Inria Serif, Regular, (1000@1000))'
]

{ #category : #tests }
AeHbFontTest >> testFace [

	self
		assert: inriaSerifRegularFont face getHandle
		equals: inriaSerifRegularFace getHandle
]

{ #category : #test }
AeHbFontTest >> testItalic [

	self
		assert: inriaSerifRegularFont italic
		equals: 0.0
]

{ #category : #test }
AeHbFontTest >> testOpticalSize [

	self
		assert: inriaSerifRegularFont opticalSize
		equals: 12.0.
]

{ #category : #tests }
AeHbFontTest >> testPointSize [

	self
		assert: inriaSerifRegularFont pointSize
		equals: 0.0.

	inriaSerifRegularFont pointSize: 2.0.

	self
		assert: inriaSerifRegularFont pointSize
		equals: 2.0
]

{ #category : #tests }
AeHbFontTest >> testPointsPerEm [

	self
		assert: inriaSerifRegularFont pointsPerEm
		equals: 0 @ 0
]

{ #category : #tests }
AeHbFontTest >> testScale [

	self
		assert: inriaSerifRegularFont scale
		equals: 1000 @ 1000. 
	"Documentation states the default is face's UPEM:"
	self
		assert: inriaSerifRegularFace unitsPerEm
		equals: 1000. 

	inriaSerifRegularFont scale: 3000 @ 2000.
	
	self
		assert: inriaSerifRegularFont scale
		equals: 3000 @ 2000
]

{ #category : #test }
AeHbFontTest >> testSlantAngle [

	self
		assert: inriaSerifRegularFont slantAngle
		equals: 0.0.
]

{ #category : #test }
AeHbFontTest >> testSlantRatio [

	self assert: inriaSerifRegularFont slantRatio equals: 0.0
]

{ #category : #test }
AeHbFontTest >> testWeight [

	self assert: inriaSerifRegularFont weight equals: 400.0
]

{ #category : #test }
AeHbFontTest >> testWidth [

	self assert: inriaSerifRegularFont width equals: 100.0
]
