Class {
	#name : #AeHbVariableFontTest,
	#superclass : #TestCase,
	#instVars : [
		'hbFace',
		'hbBlob'
	],
	#category : #'Alexandrie-HarfbuzzVariableFonts-Tests'
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

	| axis |
	self assert: hbFace axisInfos size equals: 1.

	axis := hbFace axisInfos first.
	self assert: axis tagString equals: 'wght'.
	self assert: axis minValue equals: 200.0.
	self assert: axis maxValue equals: 900.0.
	self assert: axis defaultValue equals: 200.0.
	self deny: axis isHidden.

	"Less interesting:"
	self assert: axis nameId equals: 290. "https://harfbuzz.github.io/harfbuzz-hb-ot-name.html#hb-ot-name-id-t"
	self assert: axis flags equals: 0. "https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-axis-flags-t"
]

{ #category : #tests }
AeHbVariableFontTest >> test04VariationCoordinatesAreEmptyByDefault [

	| hbFont |
	hbFont := hbFace newHbFont.
	
	self assert: hbFont variationCoordinates isEmpty
]

{ #category : #tests }
AeHbVariableFontTest >> test05SetSingleVariation [

	| hbFont |
	hbFont := hbFace newHbFont.

	hbFont variationAtTagString: 'wght' put: 678.

	self assert: hbFont variationCoordinates asArray equals: #(678.0)
]

{ #category : #tests }
AeHbVariableFontTest >> test06SetMultipleVariations [
	"We assume that 'wght' is an axis in the testing font and 456.0 is a valid value in that axis."

	| hbFont variations |
	hbFont := hbFace newHbFont.

	variations := FFIExternalArray
		newType: AeHbVariableFontVariation
		size: 1.
	variations first
		tagString: 'wght';
		value: 456.
	hbFont variations: variations.

	self assert: hbFont variationCoordinates asArray equals: #(456.0)
]

{ #category : #tests }
AeHbVariableFontTest >> test07ReadVariationFromString [
	"We assume that 'wght' is an axis in the testing font and 345.0 is a valid value in that axis."

	| hbFont variations success hbFontVariation |
	hbFont := hbFace newHbFont.

	variations := FFIExternalArray
		newType: AeHbVariableFontVariation
		size: 1.
	hbFontVariation := variations first.

	success := hbFontVariation updateFromString: 'wght="345"'.
	self deny: success.

	success := hbFontVariation updateFromString: 'wght=345'.
	self assert: success.
	self assert: hbFontVariation tagString equals: 'wght'.
	self assert: hbFontVariation value closeTo: 345.

	self assert: hbFont variationCoordinates isEmpty.
	hbFont variations: variations.
	self assert: hbFont variationCoordinates asArray equals: #(345.0)
]
