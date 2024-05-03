"
I represent examples to compare usage of Harfbuzz library.
"
Class {
	#name : #AeHarfbuzzRenderExample,
	#superclass : #Object,
	#instVars : [
		'freetypeFace',
		'string',
		'fontHeight'
	],
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #examples }
AeHarfbuzzRenderExample class >> arrowsFontSize [

	^ 22
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> arrowsString [
		
	^ 'a := A->B->>C <= c|=>d~~>e.'
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example1SourceSansPro [

	| aFace |
	aFace := AeFTLibraryResource current sourceSansProRegularFTFace.

	(self
		freetypeFace: aFace
		string: self ffString
		fontHeight: self ffFontSize)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example2InriaSerif [

	| aFTLibrary aFace |
	aFTLibrary := AeFTLibrary newInitialized.
	aFace := aFTLibrary newFaceFromFile: AeFilesystemResources inriaSerifRegularTTF index: 0.

	(self
		freetypeFace: aFace
		string: self ffString
		fontHeight: self ffFontSize)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example5CascadiaCode [

	| aFTLibrary aFace |
	aFTLibrary := AeFTLibrary newInitialized.
	aFace := AeCascadiaCodeDownloadedFont new 
		downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
		ensureDownloaded;
		firstFaceUsing: aFTLibrary.

	(self
		freetypeFace: aFace
		string: self arrowsString
		fontHeight: self arrowsFontSize)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example6Emoji [

	| aFace aWideString aFTLibrary |
	aFTLibrary := AeFTLibrary newInitialized.
	aFace := AeNotoColorEmojiDownloadedFont new 
		downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
		ensureDownloaded;
		firstFaceUsing: aFTLibrary.

	aWideString := (WideString streamContents: [ :stream |
 	#( 16r1F468 16r1F469 16r1F467 16r1F466 )
		do: [ :each | stream nextPut: (Unicode value: each) ]
		separatedBy: [ stream nextPut: Unicode zeroWidthJoiner ]]). 

	(self
		freetypeFace: aFace
		string: aWideString
		fontHeight: 40)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> ffFontSize [

	^ 30
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> ffString [

	^ 'The special film starts after coffee et office... (AV.)'
]

{ #category : #'instance creation' }
AeHarfbuzzRenderExample class >> freetypeFace: aFace string: aWideString fontHeight: aNumber [

	^ self new
		  freetypeFace: aFace;
		  string: aWideString;
		  fontHeight: aNumber;
		  yourself
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> fontHeight: aNumber [

	fontHeight := aNumber
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> freetypeFace: aeFTFace [

	freetypeFace := aeFTFace
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> glyphArrayWithHarfbuzz [

	^ AeHbBuffer new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		clusterLevel: AeHbBufferClusterLevel recommended;
		flags: AeHbBufferFlags beginningOrEndingOfText;
		addString: string;
		cairoGlyphArrayForFace: freetypeFace size: fontHeight
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> glyphArrayWithoutHarfbuzz: cairoScaledFont [

	^ cairoScaledFont glyphArrayForString: string
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> newForm [

	| aeCanvas cairoScaledFont |
	aeCanvas := AeCanvas extent: 1000 @ (fontHeight * 4).
	aeCanvas clear: Color white.

	cairoScaledFont := aeCanvas scaledFontForFace: freetypeFace size: fontHeight.

	"Margin"
	aeCanvas pathTranslate: (fontHeight/2) @ 0.

	"Draw text withOUT Harfbuzz:"
	aeCanvas pathTranslate: 0 @ (fontHeight*1.1).
	aeCanvas setSourceColor: Color red muchDarker.
	aeCanvas
		drawGlyphs: (self glyphArrayWithoutHarfbuzz: cairoScaledFont)
		font: cairoScaledFont.

	"Draw text with Harfbuzz:"
	aeCanvas pathTranslate: 0 @ (fontHeight*1.1).
	aeCanvas setSourceColor: Color green muchDarker.
	aeCanvas
		drawGlyphs: self glyphArrayWithHarfbuzz
		font: cairoScaledFont.

	^ aeCanvas asForm
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> string: aString [

	string := aString
]
