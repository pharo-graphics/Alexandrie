"
I represent examples to compare usage of Harfbuzz library.
"
Class {
	#name : #AeHarfbuzzRenderExample,
	#superclass : #Object,
	#instVars : [
		'freetypeFace',
		'string',
		'fontSize'
	],
	#category : #'Alexandrie-Canvas-Tests-Examples'
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
	aFace := AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: self ffString;
		fontSize: self ffFontSize;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example2InriaSerif [

	| aFace |
	AeFontManager globalInstance scanDirectory: AeFilesystemResources fontsDirectory.

	aFace := AeFontManager globalInstance
		detectFamilyName: 'Inria Serif'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: self ffString;
		fontSize: self ffFontSize;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example3Futura [
	"This fontface comes with Apple MacBook."

	| aFace |
	aFace := AeFontManager globalInstance
		detectFamilyName: 'Futura'
		slant: AeFontSlant normal
		weight: AeFontWeight medium
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: self ffString;
		fontSize: self ffFontSize;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example4FiraCode [

	| aFace |
	"
	1. Download from: https://github.com/tonsky/FiraCode
	2. Evaluate: AeFontManager globalInstance scanDefaultDirectories
	"
	aFace := AeFontManager globalInstance
		detectFamilyName: 'Fira Code'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: self arrowsString;
		fontSize: self arrowsFontSize;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example5CascadiaCode [

	| aFace |
	AeFontManager globalInstance scanDirectory: AeFilesystemResources fontsDirectory.

	aFace := AeFontManager globalInstance
		detectFamilyName: AeCascadiaCodeDownloadedFont new familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: self arrowsString;
		fontSize: self arrowsFontSize;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example6Emoji [

	| aFace aWideString |
	BlSpaceFixture new ensureEmojiFontFace.

	aFace := AeFontManager globalInstance
		detectFamilyName: AeNotoColorEmojiDownloadedFont new familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	aWideString := (WideString streamContents: [ :stream |
 	#( 16r1F468 16r1F469 16r1F467 16r1F466 )
		do: [ :each | stream nextPut: (Unicode value: each) ]
		separatedBy: [ stream nextPut: Unicode zeroWidthSeparator ]]). 

	(self new
		freetypeFace: aFace;
		string: aWideString;
		fontSize: 40;
		yourself)
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

{ #category : #accessing }
AeHarfbuzzRenderExample >> fontSize [

	^ fontSize
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> fontSize: anObject [

	fontSize := anObject
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> freetypeFace [

	^ freetypeFace
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> freetypeFace: anObject [

	freetypeFace := anObject
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> glyphArrayWithHarfbuzz [

	| buffer |
	buffer := AeHbBuffer new.
	buffer addUtf8String: string.
	buffer primSetDirection: AeHbDirection HB_DIRECTION_LTR.
	buffer primSetScript: AeHbScript HB_SCRIPT_LATIN.
	buffer primSetLanguage: AeHbLanguage en.
	"buffer primGuessSegmentProperties."

	^ buffer cairoGlyphArrayForFace: freetypeFace size: fontSize
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> glyphArrayWithoutHarfbuzz: cairoScaledFont [

	^ cairoScaledFont glyphArrayFor: string
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> newForm [

	| aeCanvas cairoScaledFont |
	aeCanvas := AeCanvas extent: 1000 @ (fontSize * 4).
	aeCanvas clear: Color white.

	cairoScaledFont := aeCanvas scaledFontForFace: freetypeFace size: fontSize.

	"Margin"
	aeCanvas pathTranslate: (fontSize/2) @ 0.

	"Draw text withOUT Harfbuzz:"
	aeCanvas pathTranslate: 0 @ (fontSize*1.1).
	aeCanvas setSourceColor: Color red muchDarker.
	aeCanvas
		drawText: (self glyphArrayWithoutHarfbuzz: cairoScaledFont)
		font: cairoScaledFont.

	"Draw text with Harfbuzz:"
	aeCanvas pathTranslate: 0 @ (fontSize*1.1).
	aeCanvas setSourceColor: Color green muchDarker.
	aeCanvas
		drawText: self glyphArrayWithHarfbuzz
		font: cairoScaledFont.

	^ aeCanvas asForm
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> string [

	^ string
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> string: anObject [

	string := anObject
]
