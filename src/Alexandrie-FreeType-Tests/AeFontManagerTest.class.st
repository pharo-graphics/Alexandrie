"
An AeFontManagerTest is a test class for testing the behavior of AeFontManager
"
Class {
	#name : #AeFontManagerTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #tests }
AeFontManagerTest >> testNewIsEmpty [

	| aManager |
	aManager := AeFontManager new.
	
	self assertEmpty: aManager familyNames.
]

{ #category : #tests }
AeFontManagerTest >> testScanDefaultDirectories [
	"May take long"

	| aManager |
	aManager := AeFontManager new.
	
	aManager scanDefaultDirectories.
	
	self deny: aManager facesByFamily isEmpty.
]

{ #category : #tests }
AeFontManagerTest >> testScanDirectory [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesytemResources fontsDirectory.

	self
		assert: aManager familyNames sorted
		equals: #('Noto Emoji' 'Source Code Pro')

]
