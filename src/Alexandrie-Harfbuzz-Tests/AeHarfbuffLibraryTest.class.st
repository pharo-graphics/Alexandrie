"
An AeHarfbuffLibraryTest is a test class for testing the behavior of AeHarfbuffLibrary
"
Class {
	#name : #AeHarfbuffLibraryTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHarfbuffLibraryTest >> testSimpleShapingExample [
	"Analog to https://harfbuzz.github.io/a-simple-shaping-example.html"

	| buffer blob face font infos positions |
	"1. Create a buffer and put your text in it."
	buffer := AeHbBuffer new.
	buffer addUtf8String: 'Hola mundo'.

	"2. Set the script, language and direction of the buffer."
	buffer primSetDirection: AeHbDirection HB_DIRECTION_LTR.
	buffer primSetScript: AeHbScript HB_SCRIPT_LATIN.
	buffer primSetLanguage: AeHbLanguage en.

	"3. Create a face and a font from a font file."
	blob := AeHbBlob blobCreate: AeFilesystemResources inriaSerifRegularTTF.
	face := AeHbFace primFaceCreateInBlob: blob index: 0. 
	font := AeHbFont primFontCreateFor: face.

	"4. Shape!"
	buffer shapeWithFont: font.

	"5. Get the glyph and position information."
	infos := buffer glyphInfos.
	positions := buffer glyphPositions.

	"6. Iterate over each glyph."
	infos do: [ :each | each traceCr ].
	positions do: [ :each | each traceCr ].
	
	"7. Tidy up."
	buffer := nil.
	font := nil.
	face := nil.
	blob := nil.
]
