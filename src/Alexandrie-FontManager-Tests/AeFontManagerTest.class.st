"
An AeFontManagerTest is a test class for testing the behavior of AeFontManager
"
Class {
	#name : #AeFontManagerTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-FontManager-Tests'
}

{ #category : #tests }
AeFontManagerTest >> testDetectFamilyNameSlantWeightStretchIfNone [

	| aManager aCairoFontFace aFace isAbsent |
	aManager := AeFontManager new.
	aManager
		scanDirectory: AeFilesystemResources fontsDirectory;
		scanEmbeddedFonts.

	aCairoFontFace := aManager
		detectFamilyName: 'Inria Serif'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	self assert: aCairoFontFace freetypeFace class equals: AeFTFace.

	aCairoFontFace := aManager
		detectFamilyName: 'INRIA SERIF' "<-- it ignores case"
		slant: AeFontSlant italic
		weight: AeFontWeight light
		stretch: AeFontStretch normal
		ifNone: [ self fail ].
	aFace := aCairoFontFace freetypeFace.
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
		scanDirectory: AeFilesystemResources fontsDirectory;
		scanEmbeddedFonts.

	self
		assert: aManager familyNames asArray
		equals: #('Cascadia Code' 'Inria Serif' 'Noto Color Emoji' 'Source Code Pro' 'Source Sans Pro')

]

{ #category : #tests }
AeFontManagerTest >> testGlobalInstance [
	"Warning: this test resets the singleton instance."
	
	| aManager |
	AeFontManager resetGlobalInstance.
	aManager := AeFontManager globalInstance.
	
	self assert: (aManager familyNames includes: AeSourceSansPro_Regular familyName).
	self assert: aManager defaultFace familyName equals: AeSourceSansPro_Regular familyName.
]

{ #category : #tests }
AeFontManagerTest >> testIncludesFamilyName [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesystemResources fontsDirectory.

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
	"May take long as it scans several disk directories, according to the OS platform."

	| aManager timeToScan |
	self timeLimit: 60 seconds.

	aManager := AeFontManager new.
	timeToScan := [aManager scanDefaultDirectories] timeToRun.
	
	self denyEmpty: aManager familyNames.
	'Time to scan system fonts: ' trace. timeToScan traceCr.
	'Number of system fonts: ' trace. aManager familyNames size traceCr.
]

{ #category : #tests }
AeFontManagerTest >> testScanDirectoryWithoutDuplicates [

	| aManager |
	aManager := AeFontManager new.
	aManager scanDirectory: AeFilesystemResources fontsDirectory.

	self denyEmpty: aManager familyNames.

	"This test directory has ttf and otf files"
	self
		assert: (aManager faceEntriesByFamilyName at: 'inria serif') size
		equals: AeFilesystemResources inriaSerifRegularTTF parent files size.

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
