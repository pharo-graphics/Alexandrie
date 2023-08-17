Class {
	#name : #AeCairoFreetypeTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context',
		'aScaledFont',
		'aFontFace',
		'aFTFace',
		'aFTLibrary',
		'aFontMatrix'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #running }
AeCairoFreetypeTest >> setUp [
	super setUp.

	surface := AeCairoImageSurface extent: 100 @ 20.
	context := surface newContext.
		
	aFTLibrary := AeFTLibrary newInitialized.
	aFTFace := AeSourceSansPro_Regular firstFaceUsing: aFTLibrary.
	aFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aFontMatrix := AeCairoMatrix newScalingByX: 10 y: 15.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: aFontMatrix
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.

]

{ #category : #running }
AeCairoFreetypeTest >> tearDown [

	{ aScaledFont. aFontFace. aFTFace. aFTLibrary } do: #externallyFree.
	
	super tearDown
]

{ #category : #tests }
AeCairoFreetypeTest >> testFontMatrix [

	| retrievedScaledFont |
	context scaledFont: aScaledFont.
	
	"Retrieved font matches initial parameters"
	retrievedScaledFont := context scaledFont.	
	self assert: retrievedScaledFont status isSuccess.
	self
		assert: retrievedScaledFont fontMatrix
		equals: aFontMatrix
]

{ #category : #tests }
AeCairoFreetypeTest >> testScaleMatrix [

	| retrievedScaledFont |
	context scaledFont: aScaledFont.
	
	"Retrieved font matches initial parameters"
	retrievedScaledFont := context scaledFont.	
	self assert: retrievedScaledFont status isSuccess.
	self
		assert: retrievedScaledFont scaleMatrix
		equals: aFontMatrix
]

{ #category : #tests }
AeCairoFreetypeTest >> testSetFontMatrix [

	| retrievedScaledFont |
	context scaledFont: aScaledFont.
	
	"Change with a custom matrix"
	aFontMatrix := AeCairoMatrix newRotationByRadians: 1.
	context fontMatrix: aFontMatrix.
	retrievedScaledFont := context scaledFont.	
	
	self
		assert: retrievedScaledFont fontMatrix
		equals: aFontMatrix.
	self
		assert: retrievedScaledFont scaleMatrix
		equals: aFontMatrix.

]

{ #category : #tests }
AeCairoFreetypeTest >> testSetFontSize [

	| retrievedScaledFont |
	context scaledFont: aScaledFont.
	
	"Change font size"
	context fontSize: 23.
	retrievedScaledFont := context scaledFont.	
	aFontMatrix := AeCairoMatrix newScalingByX: 23 y: 23.
	
	self
		assert: retrievedScaledFont fontMatrix
		equals: aFontMatrix.
	self
		assert: retrievedScaledFont scaleMatrix
		equals: aFontMatrix
]
