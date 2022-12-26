"
An AeHarfbuffLibraryTest is a test class for testing the behavior of AeHarfbuffLibrary
"
Class {
	#name : #AeHbBufferTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbBufferTest >> testClearContents [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer clearContents.
	self assert: buffer length equals: 0.

]

{ #category : #tests }
AeHbBufferTest >> testMultipleAdd [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	self assert: buffer length equals: 0.

	buffer addUtf8String: 'ab'.
	self assert: buffer length equals: 2.

	buffer addUtf8String: 'cd'.
	self assert: buffer length equals: 4.

]

{ #category : #tests }
AeHbBufferTest >> testReset [

	| buffer |
	buffer := AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer reset.
	self assert: buffer length equals: 0.

]

{ #category : #tests }
AeHbBufferTest >> testSimpleExample [
	"Adaptation of https://harfbuzz.github.io/a-simple-shaping-example.html"

	| buffer font infos positions blob face |
	"1. Create a buffer and put your text in it."
	buffer := AeHbBuffer new.
	buffer addUtf8String: 'flor'.

	"2. Set the script, language and direction of the buffer."
	buffer direction: AeHbDirection leftToRight.
	buffer script: AeHbScript latin.
	buffer language: AeHbLanguage en.

	"3. Create a face and a font from a font file."
	blob := AeHbBlob newLocatedAt: AeFilesystemResources inriaSerifRegularTTF.
	face := AeHbFace newForBlob: blob index: 0. 
	font := AeHbFont newForHbFace: face.

	"4. Shape!"
	buffer shapeWithFont: font.

	"5. Get the glyph and position information."
	infos := buffer glyphInfos.
	positions := buffer glyphPositions.

	"6. Iterate over each glyph."
	#(75 52 55) withIndexDo: [ :each :index |
		self assert: (infos at: index) codepoint equals: each ].
	#(625 557 439) withIndexDo: [ :each :index |
		self assert: (positions at: index) x_advance equals: each ].

]
