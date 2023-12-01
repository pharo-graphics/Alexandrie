"
An AeHarfbuffLibraryTest is a test class for testing the behavior of AeHarfbuffLibrary
"
Class {
	#name : 'AeHbBufferTest',
	#superclass : 'TestCase',
	#category : 'Alexandrie-Harfbuzz-Tests',
	#package : 'Alexandrie-Harfbuzz-Tests'
}

{ #category : 'tests' }
AeHbBufferTest >> testClearContents [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	self assert: buffer length equals: 0.
	buffer addString: 'ab'.
	self assert: buffer length equals: 2.
	buffer clearContents.
	self assert: buffer length equals: 0.

]

{ #category : 'tests' }
AeHbBufferTest >> testGuessSegmentProperties [

	| buffer |
	buffer := AeHbBuffer new
		addString: 'Hello';
		guessSegmentProperties;
		yourself.
		
	self
		assert: buffer segmentProperties direction
		equals: AeHbDirection leftToRight.

	self
		assert: buffer segmentProperties script
		equals: AeHbScript latin.

	"CI showed different results depending on the platform: 'utf-8', 'c' and 'en-us'"
	self deny: buffer segmentProperties language toString isEmpty
]

{ #category : 'tests' }
AeHbBufferTest >> testMultipleAdd [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	self assert: buffer length equals: 0.

	buffer addString: 'ab'.
	self assert: buffer length equals: 2.

	buffer addString: 'cd'.
	self assert: buffer length equals: 4.

]

{ #category : 'tests' }
AeHbBufferTest >> testReset [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	buffer addString: 'ab'.
	self assert: buffer length equals: 2.
	buffer reset.
	self assert: buffer length equals: 0.

]

{ #category : 'tests' }
AeHbBufferTest >> testShapeExample [

	| aBuffer aBlob aFace aFont |
	aBuffer := AeHbBuffer new
		addString: 'off';
		guessSegmentProperties;
		yourself.
	aBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	aFace := aBlob newHbFaceAtIndex: 0.
	aFont := aFace newHbFont.
	
	aBuffer shapeWithFont: aFont.

	self assert: aBuffer length equals: 2.
	self assert: aBuffer glyphInfos size equals: 2.
	self assert: aBuffer glyphPositions size equals: 2.
]

{ #category : 'tests' }
AeHbBufferTest >> testShapeWithFontFeatures [
	"By default, shape with this font replaces the ff sequence by a single glyph.
	This test shows how to disable one of the possible replacements."

	| aBuffer aBlob aFace aFont featuresArray aString |
	aString := 'off;off;off;'.
	aBuffer := AeHbBuffer new
		addString: aString;
		guessSegmentProperties;
		yourself.

	aBlob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	aFace := aBlob newHbFaceAtIndex: 0.
	aFont := aFace newHbFont.
	
	featuresArray := FFIExternalArray newType: AeHbFeature size: 2.
	featuresArray first  readIntoSelf: '+liga[0:4]'.
	featuresArray second readIntoSelf: '-liga[4:8]'.

	aBuffer shapeWithFont: aFont features: featuresArray.
	"if all ff occurences were replaced, it would be -3:"
	self assert: aBuffer length equals: aString size - 2
]

{ #category : 'tests' }
AeHbBufferTest >> testSimpleExample [
	"Adaptation of https://harfbuzz.github.io/a-simple-shaping-example.html"

	| buffer font infos positions blob face |
	"1. Create a buffer and put your text in it."
	buffer := AeHbBuffer new.
	buffer addString: 'flor'.

	"2. Set the script, language and direction of the buffer."
	buffer direction: AeHbDirection leftToRight.
	buffer script: AeHbScript latin.
	buffer language: AeHbLanguage en.

	"3. Create a face and a font from a font file."
	blob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	face := blob newHbFaceAtIndex: 0. 
	font := face newHbFont.

	"4. Shape!"
	buffer shapeWithFont: font.

	"5. Get the glyph and position information."
	infos := buffer glyphInfos.
	positions := buffer glyphPositions.

	"6. Iterate over each glyph."
	#(75 52 55) withIndexDo: [ :each :index |
		self assert: (infos at: index) codepoint equals: each ].
	#(625 557 439) withIndexDo: [ :each :index |
		self assert: (positions at: index) xAdvance equals: each ].

]
