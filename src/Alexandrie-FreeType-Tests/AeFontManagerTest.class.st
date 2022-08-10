"
An AeFontManagerTest is a test class for testing the behavior of AeFontManager
"
Class {
	#name : #AeFontManagerTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FreeType-Tests'
}

{ #category : #tests }
AeFontManagerTest >> testDetectFamilyNameSlantWeightStretchIfNone [

	| aManager aFace isAbsent |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesytemResources fontsDirectory.

	aFace := aManager
		detectFamilyName: 'Noto Emoji'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	self assert: aFace class equals: AeFTFace.

	aFace := aManager
		detectFamilyName: 'source code pro' "<-- it ignores case"
		slant: AeFontSlant italic
		weight: AeFontWeight extraLight
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	self assert: aFace class equals: AeFTFace.
	self assert: aFace familyName equals: 'Source Code Pro'.
	self assert: aFace isItalic.
	self deny: aFace isBold.
	self deny: aFace isFixedWidth.

	isAbsent := false.
	aManager 
		detectFamilyName: 'Source Code Pro'
		slant: AeFontSlant italic
		weight: AeFontWeight extraLight
		stretch: AeFontStretch condensed "<-- Not present"
		ifNone: [ isAbsent := true ].
	self assert: isAbsent.	isAbsent := false.

	aManager 
		detectFamilyName: 'Source Code Pr' "<-- Not present"
		slant: AeFontSlant italic
		weight: AeFontWeight extraLight
		stretch: AeFontStretch normal
		ifNone: [ isAbsent := true ].
	self assert: isAbsent.	

]

{ #category : #tests }
AeFontManagerTest >> testFamilyNames [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesytemResources fontsDirectory.

	self
		assert: aManager familyNames asArray
		equals: #('Noto Emoji' 'Source Code Pro')

]

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
	
	self denyEmpty: aManager familyNames.
	
	aManager faceEntries do: [ :each |
		each slantWeightStretch.
		(aManager faceAt: each) traceCr ]
]

{ #category : #tests }
AeFontManagerTest >> testScanDirectory [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesytemResources fontsDirectory.

	self denyEmpty: aManager familyNames
]
