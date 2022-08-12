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
	aManager
		scanDirectory: AeFilesytemResources fontsDirectory;
		scanEmbeddedFonts.

	aFace := aManager
		detectFamilyName: 'Inria Serif'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	self assert: aFace class equals: AeFTFace.

	aFace := aManager
		detectFamilyName: 'INRIA SERIF' "<-- it ignores case"
		slant: AeFontSlant italic
		weight: AeFontWeight light
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	self assert: aFace class equals: AeFTFace.
	self assert: aFace familyName equals: 'Inria Serif'.
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
	aManager
		scanDirectory: AeFilesytemResources fontsDirectory;
		scanEmbeddedFonts.

	self
		assert: aManager familyNames asArray
		equals: #('Inria Serif' 'Noto Color Emoji' 'Source Code Pro' 'Source Sans Pro')

]

{ #category : #tests }
AeFontManagerTest >> testGlobalInstance [
	"Warning: this test resets the singleton instance."
	
	| aManager |
	AeFontManager resetGlobalInstance.
	aManager := AeFontManager globalInstance.
	
	self assert: (aManager familyNames includes: AeSourceSansProRegular familyName).
	self assert: aManager defaultFace familyName equals: AeSourceSansProRegular familyName.
]

{ #category : #tests }
AeFontManagerTest >> testIncludesFamilyName [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesytemResources fontsDirectory.

	self assert: (aManager includesFamilyName: AeNotoColorEmojiDownloadedFont new familyName)

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

{ #category : #tests }
AeFontManagerTest >> testScanEmbeddedFonts [

	| aManager |
	aManager := AeFontManager new.
	aManager scanEmbeddedFonts.
	
	self
		assert: aManager familyNames asArray 
		equals: #('Source Code Pro' 'Source Sans Pro').

	"Trigger lazy read of attributes"
	aManager faceEntries do: [ :each |
		each slantWeightStretch ]
]
