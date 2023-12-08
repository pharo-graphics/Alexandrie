"
I'm useful to view text and font metrics.
"
Class {
	#name : #AeHbCairoFeaturesExample,
	#superclass : #Object,
	#instVars : [
		'cairoContext',
		'string',
		'font',
		'features',
		'fontSize'
	],
	#category : #'Alexandrie-HarfbuzzCairo'
}

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDraw: aString binaryTag: aTagAsString font: aHbFont fontSize: fontSize [

	self
		exampleDraw: aString
		binaryTags: { aTagAsString }
		font: aHbFont
		fontSize: fontSize
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDraw: aString binaryTags: aTagAsStringCollection font: aHbFont fontSize: fontSize [
	
	| aFeatureArray utf8Size |
	utf8Size := aString utf8Encoded size.
	aFeatureArray := AeHbFeatureArray newOf: 2 * aTagAsStringCollection size.

	aTagAsStringCollection withIndexDo: [ :each :index |
		(aFeatureArray at: index)
			readIntoSelf: ('{1}[:{2}]=0'
				format: { each. utf8Size }).
		(aFeatureArray at: index + aTagAsStringCollection size)
			readIntoSelf: ('{1}[{2}:]=1'
				format: { each. utf8Size }) ].

	self
		exampleDraw: aString, aString
		features: aFeatureArray
		font: aHbFont 
		fontSize: fontSize
]

{ #category : #'instance creation' }
AeHbCairoFeaturesExample class >> exampleDraw: aString features: featuresExternalArray font: aHbFont fontSize: fontSize [

	| cairoSurface instance |
	cairoSurface := AeCairoImageSurface
		extent: 400 @ (fontSize * 1.75)
		format: AeCairoSurfaceFormat rgb24.
	
	cairoSurface status ensureIsSuccess.
	
	instance := self
			newWith: aString
			features: featuresExternalArray
			font: aHbFont
			fontSize: fontSize
			cairoContext: cairoSurface newContext.
	
	instance
		draw;
		inspectWithLabel: featuresExternalArray asString
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawCascadiaArrows [

	self
		exampleDraw: '<--> '
		binaryTag: 'calt'
		font: self newCascadiaFace newHbFont
		fontSize: 70

]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawDiagonalFraction [

	| aString aFeatureArray |
	aString := '123/71 '.
	
	aFeatureArray := AeHbFeatureArray newOf: 1.
	aFeatureArray first readIntoSelf: ('frac[{1}:]=1' format: { aString utf8Encoded size }).

	self
		exampleDraw: aString, ' ', aString
		features: aFeatureArray
		font: self newSourceSansProFace newHbFont
		fontSize: 70
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawFFLigature [

	self
		exampleDraw: 'coff '
		binaryTag: 'liga'
		font: self newInriaFace newHbFont
		fontSize: 90

]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawMultiCharacterEmoji [

	self
		exampleDraw: '👨‍👩‍👧‍👦 '
		binaryTag: 'ccmp'
		font: self newEmojiFace newHbFont
		fontSize: 24
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawNotEquals [

	self
		exampleDraw: 'a~=b '
		binaryTag: 'ss02'
		font: self newCascadiaFace newHbFont
		fontSize: 70
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawOldStyleNumbers [

	self
		exampleDraw: '234567890.png  '
		binaryTag: 'onum'
		font: self newSourceSansProFace newHbFont
		fontSize: 28
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawOrdinal [

	self
		exampleDraw: '1st 2nd  '
		binaryTag: 'ordn'
		font: self newSourceSansProFace newHbFont
		fontSize: 60
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawSlashedZero [

	| aString aFeatureArray separator |
	aString := '100'.
	separator := '  '.
	
	aFeatureArray := AeHbFeatureArray newOf: 1.
	aFeatureArray first readIntoSelf:
		('zero[{1}:]=1' format: { aString utf8Encoded size + separator size }).

	self
		exampleDraw: aString, separator, aString
		features: aFeatureArray
		font: self newCascadiaFace newHbFont
		fontSize: 70
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawSmallCaps [

	self
		exampleDraw: 'Title '
		binaryTag: 'smcp'
		font: self newSourceSansProFace newHbFont
		fontSize: 80
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawSmallCapsAll [

	self
		exampleDraw: 'Title '
		binaryTags: #('smcp' 'c2sc')
		font: self newSourceSansProFace newHbFont
		fontSize: 80
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawSubscript [

	| aString aFeatureArray |
	aString := 'a2'.
	
	aFeatureArray := AeHbFeatureArray newOf: 1.
	aFeatureArray first  readIntoSelf: ('subs[1]').

	self
		exampleDraw: aString, '   ', aString
		features: aFeatureArray
		font: self newSourceSansProFace newHbFont
		fontSize: 90
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawTabularNumbers [

	self
		exampleDraw: '111000 '
		binaryTag: 'tnum'
		font: self newInriaFace newHbFont
		fontSize: 55
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> newCascadiaFace [

	^ (AeHbBlob newLocatedAt:
			AeCascadiaCodeDownloadedFont new fileReference)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> newEmojiFace [

	^ (AeHbBlob newLocatedAt:
			AeNotoColorEmojiDownloadedFont new fileReference)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> newInriaFace [

	^ (AeHbBlob newLocatedAt:
			AeFilesystemResources inriaSerifRegularTTF)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> newSourceSansProFace [

	^ (AeHbBlob newFrom:
			AeSourceSansPro_Regular fontContentsData)
				newHbFaceAtIndex: 0
]

{ #category : #'instance creation' }
AeHbCairoFeaturesExample class >> newWith: aString features: features font: aHbFont fontSize: aFontSize cairoContext: aCairoContext [

	^ self basicNew
		  initializeWith: aString
		  features: features
		  font: aHbFont
		  fontSize: aFontSize
		  cairoContext: aCairoContext;
		  yourself
]

{ #category : #drawing }
AeHbCairoFeaturesExample >> draw [

	| aBuffer cairoScaledFont glyphArray glyphExtents fontExtents |
	cairoContext
		sourceColor: Color white;
		paint.

	aBuffer :=
		AeHbBuffer new
			direction: AeHbDirection leftToRight;
			script: AeHbScript latin;
			language: AeHbLanguage en;
			addString: string;
			shapeWithFont: font features: features;
			yourself.
	glyphArray := aBuffer cairoGlyphArray.

	cairoContext fontFace: font newCairoFontFace.
	cairoContext fontSize: fontSize.
	cairoContext fontOptions: self newCairoFontOptions.
	cairoScaledFont := cairoContext scaledFont.
	glyphExtents := cairoScaledFont glyphExtentsOf: glyphArray.
	fontExtents := cairoScaledFont fontExtents.

	cairoContext
		translateByX: 10 y: 10;
		translateByX: 0.0 y: fontExtents ascent;
		sourceColor: Color black;
		showGlyphs: glyphArray
]

{ #category : #initialization }
AeHbCairoFeaturesExample >> initializeWith: aString features: anExternalArray font: aHbFont fontSize: aFontSize cairoContext: aCairoContext [

	self initialize.
	
	string := aString.
	features := anExternalArray.
	fontSize := aFontSize.
	font := aHbFont.
	font scale: fontSize as26Dot6FractionalPoint asPoint.

	cairoContext := aCairoContext
]

{ #category : #'debugging - new tools' }
AeHbCairoFeaturesExample >> inspectionOfSurfaceAsForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Cairo context'>

	^ cairoContext inspectionOfSurfaceAsForm: aBuilder
]

{ #category : #private }
AeHbCairoFeaturesExample >> newCairoFontOptions [ 

	^ AeCairoFontOptions new
		hintMetrics: AeCairoHintMetrics off;
		hintStyle: AeCairoHintStyle none;
		yourself
]

{ #category : #drawing }
AeHbCairoFeaturesExample >> seeClassSide [
]
