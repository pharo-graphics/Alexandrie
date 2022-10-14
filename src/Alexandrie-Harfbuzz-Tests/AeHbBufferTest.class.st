"
An AeHarfbuffLibraryTest is a test class for testing the behavior of AeHarfbuffLibrary
"
Class {
	#name : #AeHbBufferTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbBufferTest >> inriaSerifHbFont [

	| blob face |
	blob := AeHbBlob blobCreate: AeFilesystemResources inriaSerifRegularTTF.
	face := AeHbFace primFaceCreateInBlob: blob index: 0. 
	^ AeHbFont primFontCreateFor: face

]

{ #category : #test }
AeHbBufferTest >> testMultipleAdd [

	| buffer |
	buffer := AeHbBuffer new
		primSetDirection: AeHbDirection leftToRight;
		primSetScript: AeHbScript latin;
		primSetLanguage: AeHbLanguage en;
		yourself.

	self assert: buffer primGetLength equals: 0.

	buffer addUtf8String: 'ab'.
	self assert: buffer primGetLength equals: 2.

	buffer addUtf8String: 'cd'.
	self assert: buffer primGetLength equals: 4.

]

{ #category : #test }
AeHbBufferTest >> testPrimClearContents [

	| buffer |
	buffer := AeHbBuffer new
		primSetDirection: AeHbDirection leftToRight;
		primSetScript: AeHbScript latin;
		primSetLanguage: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer primClearContents.
	self assert: buffer primGetLength equals: 0.

]

{ #category : #test }
AeHbBufferTest >> testPrimReset [

	| buffer |
	buffer := AeHbBuffer new
		primSetDirection: AeHbDirection leftToRight;
		primSetScript: AeHbScript latin;
		primSetLanguage: AeHbLanguage en;
		yourself.

	buffer addUtf8String: 'ab'.
	buffer primReset.
	self assert: buffer primGetLength equals: 0.

]

{ #category : #tests }
AeHbBufferTest >> testSimpleExample [
	"Adaptation of https://harfbuzz.github.io/a-simple-shaping-example.html"

	| buffer font infos positions |
	"1. Create a buffer and put your text in it."
	buffer := AeHbBuffer new.
	buffer addUtf8String: 'flor'.

	"2. Set the script, language and direction of the buffer."
	buffer primSetDirection: AeHbDirection leftToRight.
	buffer primSetScript: AeHbScript latin.
	buffer primSetLanguage: AeHbLanguage en.

	"3. Create a face and a font from a font file."
	font := self inriaSerifHbFont.

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
