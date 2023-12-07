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

{ #category : #'instance creation' }
AeHbCairoFeaturesExample class >> exampleDraw: aString features: featuresExternalArray font: aHbFont fontSize: fontSize [

	| cairoSurface instance |
	cairoSurface := AeCairoImageSurface
		extent: 400 @ (fontSize * 1.5)
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
		inspect
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawDistinct [


	| aFeatureArray |
	aFeatureArray := AeHbFeatureArray newOf: 3.
	aFeatureArray first readIntoSelf: 'ss02[0:5]=1'.
	aFeatureArray second readIntoSelf: 'zero[0:5]=1'.
	aFeatureArray third readIntoSelf: 'ss19[0:5]'.
	
	self
		exampleDraw: 'a~=0 a~=0'
		features: aFeatureArray
		font: self newCascadiaFace newHbFont
		fontSize: 70
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawFFLigature [

	| aFeatureArray |
	aFeatureArray := AeHbFeatureArray newOf: 2.
	aFeatureArray first readIntoSelf: 'liga[0:6]=0'.
	aFeatureArray second readIntoSelf: 'kern[0:6]=0'.

	self
		exampleDraw: 'coff  coff'
		features: aFeatureArray
		font: self newInriaFace newHbFont
		fontSize: 90
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawFraction [

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
AeHbCairoFeaturesExample class >> exampleDrawSmallCaps [

	| aString aFeatureArray |
	aString := 'Title '.
	
	aFeatureArray := AeHbFeatureArray newOf: 1.
	aFeatureArray first readIntoSelf: ('smcp[{1}:]' format: { aString utf8Encoded size }).

	self
		exampleDraw: aString, ' ', aString
		features: aFeatureArray
		font: self newSourceSansProFace newHbFont
		fontSize: 80
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawSubscript [

	| aString aFeatureArray |
	aString := 'a2'.
	
	aFeatureArray := AeHbFeatureArray newOf: 2.
	aFeatureArray first  readIntoSelf: ('subs[1]').

	self
		exampleDraw: aString, '   ', aString
		features: aFeatureArray
		font: self newSourceSansProFace newHbFont
		fontSize: 90
]

{ #category : #examples }
AeHbCairoFeaturesExample class >> exampleDrawZero [

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
