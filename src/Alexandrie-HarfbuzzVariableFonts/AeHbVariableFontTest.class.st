Class {
	#name : #AeHbVariableFontTest,
	#superclass : #TestCase,
	#instVars : [
		'hbFace',
		'hbBlob'
	],
	#category : #'Alexandrie-HarfbuzzVariableFonts'
}

{ #category : #running }
AeHbVariableFontTest >> setUp [
	| fileReference |
	super setUp.

	fileReference := AeSourceCodeVFDownloadedFont new
		downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
		ensureDownloaded;
		fileReference.
	hbBlob := AeHbBlob newLocatedAt: fileReference.
	hbBlob faceCount.
	hbFace := hbBlob newHbFaceAtIndex: 0.

]

{ #category : #tests }
AeHbVariableFontTest >> test01FaceHasVariableFontsData [

	self assert: hbFace hasVariableFontsData
]

{ #category : #tests }
AeHbVariableFontTest >> test02FaceAxisCount [

	self assert: hbFace variableFontAxisCount equals: 1
]

{ #category : #tests }
AeHbVariableFontTest >> test03FaceAxisInfos [

	self assert: hbFace axisInfos size equals: 1.
	self assert: hbFace axisInfos first tag asHbTagString equals: 'wght'
]

{ #category : #tests }
AeHbVariableFontTest >> test04FontVariations [

	| hbFont variations |
	hbFont := hbFace newHbFont.

	variations := FFIExternalArray
		newType: AeHbVariableFontVariation
		size: hbFace variableFontAxisCount.
	hbFace axisInfos withIndexDo: [ :eachAxisInfo :oneBasedIndex |
		(variations
			at: oneBasedIndex)
				tag: eachAxisInfo tag;
				value: (eachAxisInfo minValue + eachAxisInfo maxValue) / 2 ].

	hbFont variations: variations.

]
