Class {
	#name : #AeCairoFreetypeTest,
	#superclass : #TestCase,
	#instVars : [
		'aScaledFont',
		'aFontFace',
		'aFTFace',
		'aFTLibrary',
		'aFontMatrix',
		'cairoSurface',
		'cairoContext'
	],
	#category : #'Alexandrie-CairoFreetype-Tests'
}

{ #category : #accessing }
AeCairoFreetypeTest >> resources [

	^ { AeFTLibraryResource }
]

{ #category : #running }
AeCairoFreetypeTest >> setUp [
	super setUp.

	cairoSurface := AeCairoImageSurface extent: 100 @ 20.
	cairoContext := cairoSurface newContext.

	aFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	aFontFace := aFTFace newCairoFontFace.
	aFontMatrix := AeCairoMatrix newScalingByX: 10 y: 15.
	aScaledFont := aFontFace 
		newScaledFontWithFontMatrix: aFontMatrix
		userToDeviceMatrix: AeCairoMatrix newIdentity
		options: AeCairoFontOptions new.

]

{ #category : #tests }
AeCairoFreetypeTest >> testFontMatrix [

	| retrievedScaledFont |
	cairoContext scaledFont: aScaledFont.
	
	"Retrieved font matches initial parameters"
	retrievedScaledFont := cairoContext scaledFont.	
	self assert: retrievedScaledFont status isSuccess.
	self
		assert: retrievedScaledFont fontMatrix
		equals: aFontMatrix
]

{ #category : #tests }
AeCairoFreetypeTest >> testScaleMatrix [

	| retrievedScaledFont |
	cairoContext scaledFont: aScaledFont.
	
	"Retrieved font matches initial parameters"
	retrievedScaledFont := cairoContext scaledFont.	
	self assert: retrievedScaledFont status isSuccess.
	self
		assert: retrievedScaledFont scaleMatrix
		equals: aFontMatrix
]

{ #category : #tests }
AeCairoFreetypeTest >> testSetFontMatrix [

	| retrievedScaledFont |
	cairoContext scaledFont: aScaledFont.
	
	"Change with a custom matrix"
	aFontMatrix := AeCairoMatrix newRotationByRadians: 1.
	cairoContext fontMatrix: aFontMatrix.
	retrievedScaledFont := cairoContext scaledFont.	
	
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
	cairoContext scaledFont: aScaledFont.
	
	"Change font size"
	cairoContext fontSize: 23.
	retrievedScaledFont := cairoContext scaledFont.	
	aFontMatrix := AeCairoMatrix newScalingByX: 23 y: 23.
	
	self
		assert: retrievedScaledFont fontMatrix
		equals: aFontMatrix.
	self
		assert: retrievedScaledFont scaleMatrix
		equals: aFontMatrix
]

{ #category : #tests }
AeCairoFreetypeTest >> testUserToDeviceMatrix [

	| retrievedScaledFont |
	cairoContext scaledFont: aScaledFont.
	
	retrievedScaledFont := cairoContext scaledFont.
	self assert: retrievedScaledFont userToDeviceMatrix isIdentity
]
