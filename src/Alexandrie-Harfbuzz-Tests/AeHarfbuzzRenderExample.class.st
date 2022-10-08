Class {
	#name : #AeHarfbuzzRenderExample,
	#superclass : #Object,
	#instVars : [
		'freetypeFace',
		'string',
		'fontSize'
	],
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #examples }
AeHarfbuzzRenderExample class >> example1ff [

	| aFace |
	aFace := AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: 'T.WAV.film.office';
		fontSize: 72;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example2fi [

	| aFace |
	aFace := AeFontManager globalInstance
		detectFamilyName: 'Inria Serif'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	(self new
		freetypeFace: aFace;
		string: 'T.WAV.film.office';
		fontSize: 72;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example3emoji [

	| aFace aWideString |
	BlSpaceFixture new ensureEmojiFontFace.

	aFace := AeFontManager globalInstance
		detectFamilyName: 'Noto Color Emoji'
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ NotFound signal ].

	aWideString := (WideString streamContents: [ :stream |
 	#( 16r1F468 16r200D 16r1F680   ) do: [ :each |
			stream nextPut: (Unicode value: each) ]]). 

	(self new
		freetypeFace: aFace;
		string: aWideString;
		fontSize: 43;
		yourself)
		newForm inspect
]

{ #category : #examples }
AeHarfbuzzRenderExample class >> example4fira [

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
		string: 'a := A->B->>C <= c|=>d~~>e.';
		fontSize: 32;
		yourself)
		newForm inspect
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

	| buffer font len infos positions cairoGlyphsArray currentX currentY |
	buffer := AeHbBuffer new.

	buffer addUtf8String: string.


	buffer primSetDirection: AeHbDirection HB_DIRECTION_LTR.
	buffer primSetScript: AeHbScript HB_SCRIPT_LATIN.
	buffer primSetLanguage: (AeHbLanguage fromString: 'en').
	"buffer primGuessSegmentProperties."

	freetypeFace
		charSizeWidth: fontSize * 64
		height: fontSize * 64.
	font := AeHbFont primFontCreateForFreetypeReferenced: freetypeFace.
	buffer shapeWithFont: font.

	len := buffer primGetLength.
	infos := buffer glyphInfos.
	positions := buffer glyphPositions.

	cairoGlyphsArray := AeCairoGlyphArray externalNew: len.
	currentX := 0.
	currentY := 0.
	cairoGlyphsArray doWithIndex: [ :each :index |
		| position |
		position := positions at: index. 
		each
			index: (infos at: index) codepoint;
			x: currentX + (position x_offset / 64);
			y: (currentY + (position y_offset / 64)) negated.
		currentX := currentX + (position x_advance / 64).
		currentY := currentY + (position y_advance / 64) ].

	^ cairoGlyphsArray
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> glyphArrayWithoutHarfbuzz: cairoScaledFont [

	^ cairoScaledFont glyphArrayForString: string
]

{ #category : #accessing }
AeHarfbuzzRenderExample >> newForm [

	| aeCanvas cairoScaledFont |
	aeCanvas := AeCanvas extent: 900 @ (fontSize * 4).
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
