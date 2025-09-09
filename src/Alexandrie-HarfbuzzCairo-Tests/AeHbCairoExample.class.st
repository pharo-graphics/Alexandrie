"
I'm useful to view text and font metrics.
"
Class {
	#name : #AeHbCairoExample,
	#superclass : #Object,
	#instVars : [
		'cairoContext',
		'string',
		'fontExtents',
		'glyphExtents',
		'font',
		'glyphArray',
		'cairoFontFace',
		'cairoScaledFont',
		'fontSize'
	],
	#category : #'Alexandrie-HarfbuzzCairo-Tests'
}

{ #category : #'instance creation' }
AeHbCairoExample class >> exampleDraw: aString face: aHbFace [

	self exampleDraw: aString font: aHbFace newHbFont fontSize: 100
]

{ #category : #'instance creation' }
AeHbCairoExample class >> exampleDraw: aString font: aHbFont fontSize: fontSize [

	| cairoSurface instance |
	cairoSurface := AeCairoImageSurface
		extent: 1000 @ (fontSize * 2)
		format: AeCairoSurfaceFormat argb32.
	
	"cairoSurface := AeCairoPDFSurface
		extent: 1000 @ 1000
		to: 'c.pdf' asFileReference.
	cairoSurface status ensureIsSuccess."
	"cairoSurface := AeCairoSVGSurface
		extent: 1000 @ (fontSize * 20)
		to: 'b_.svg' asFileReference."
	"cairoSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorAndAlpha
			bounds: AeCairoRectangle null."

	cairoSurface status ensureIsSuccess.
	
	instance := self
			newWith: aString
			font: aHbFont
			fontSize: fontSize
			cairoContext: cairoSurface newContext.
	
	instance
		clearSurface;
		drawHighlighting;
		drawBaseline;
		drawText;
		drawUnderline;
		drawStrikeout;
		inspect
]

{ #category : #examples }
AeHbCairoExample class >> exampleDrawFFLigature [

	self exampleDraw: 'Officey' face: self newInriaFace
]

{ #category : #examples }
AeHbCairoExample class >> exampleDrawLigature [

	self exampleDraw: 'a->>g' face: self newCascadiaFace
]

{ #category : #examples }
AeHbCairoExample class >> exampleDrawLoremIpsum [

	self
		exampleDraw: (String loremIpsum: 120)
		font: self newSourceSansProFace newHbFont
		fontSize: 20
]

{ #category : #examples }
AeHbCairoExample class >> exampleEmoji [

	self exampleDraw: '😁' face: self newEmojiFace
]

{ #category : #examples }
AeHbCairoExample class >> exampleZWJEmoji [

	| string |
	string := WideString streamContents: [ :stream |
	 	#( 16r1F468 16r1F469 16r1F467 16r1F466 )
			do: [ :each | stream nextPut: (Unicode value: each) ]
			separatedBy: [ stream nextPut: Unicode zeroWidthJoiner ]].

	self exampleDraw: string face: self newEmojiFace
]

{ #category : #examples }
AeHbCairoExample class >> newCascadiaFace [

	^ (AeHbBlob newLocatedAt:
			AeCascadiaCodeDownloadedFont new fileReference)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoExample class >> newEmojiFace [

	^ (AeHbBlob newLocatedAt:
			AeNotoColorEmojiDownloadedFont new fileReference)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoExample class >> newInriaFace [

	^ (AeHbBlob newLocatedAt:
			AeFilesystemResources inriaSerifRegularTTF)
				newHbFaceAtIndex: 0
]

{ #category : #examples }
AeHbCairoExample class >> newSourceSansProFace [

	^ (AeHbBlob newFrom:
			AeSourceSansPro_Regular fontContentsData)
				newHbFaceAtIndex: 0
]

{ #category : #'instance creation' }
AeHbCairoExample class >> newWith: aString face: aHbFace fontSize: aFontSize [

	| cairoSurface |
	cairoSurface := AeCairoImageSurface
		extent: 1000 @ (aFontSize * 1.5)
		format: AeCairoSurfaceFormat argb32.
	
	"cairoSurface := AeCairoPDFSurface
		extent: 1000 @ 1000
		to: 'c.pdf' asFileReference.
	cairoSurface status ensureIsSuccess."
	"cairoSurface := AeCairoSVGSurface
		extent: 1000 @ (fontSize * 20)
		to: 'b_.svg' asFileReference."
	"cairoSurface :=
		AeCairoRecordingSurface
			newContentType: AeCairoContent colorAndAlpha
			bounds: AeCairoRectangle null."

	cairoSurface status ensureIsSuccess.
	
	^ self newWith: aString font: aHbFace fontSize: aFontSize cairoContext: cairoSurface newContext
]

{ #category : #'instance creation' }
AeHbCairoExample class >> newWith: aString font: aHbFont fontSize: aFontSize cairoContext: aCairoContext [

	^ self basicNew
		  initializeWith: aString
		  font: aHbFont
		  fontSize: aFontSize
		  cairoContext: aCairoContext;
		  yourself
]

{ #category : #drawing }
AeHbCairoExample >> clearSurface [

	cairoContext restoreStateAfter: [
		cairoContext
			sourceColor: Color cyan;
			paint ]
]

{ #category : #drawing }
AeHbCairoExample >> drawBaseline [

	self
		drawDottedHLineCenteredAt: fontExtents ascent
		thickness: 2.0
		left: 0.0
		right: glyphExtents advanceX
		color: Color blue
]

{ #category : #drawing }
AeHbCairoExample >> drawDottedHLineCenteredAt: centerY thickness: thickness left: left right: right color: aColor [

	cairoContext restoreStateAfter: [
		cairoContext
			moveToX: left y: centerY;
			lineToX: right y: centerY.

		cairoContext
			strokeSize: thickness;
			strokeCap: AeCairoStrokeCap round;
			strokeDashPattern: { 0. 2*thickness }
			offset: 0.

		cairoContext
			sourceColor: aColor;
			stroke ]
]

{ #category : #drawing }
AeHbCairoExample >> drawHighlighting [

	cairoContext restoreStateAfter: [
		cairoContext
			rectangleX: glyphExtents bearingX
				y: 0
				width: glyphExtents width
				height: fontExtents height;
			sourceColor: Color yellow;
			fill ]

]

{ #category : #drawing }
AeHbCairoExample >> drawSolidHLineCenteredAt: centerY thickness: thickness left: left width: width color: aColor [

	cairoContext restoreStateAfter: [
		cairoContext
			rectangleX: left
			y: centerY - (thickness/2.0)
			width: width
			height: thickness.
		cairoContext
			sourceColor: aColor;
			fill ]
]

{ #category : #drawing }
AeHbCairoExample >> drawStrikeout [

	self
		drawSolidHLineCenteredAt: fontExtents ascent - font strikeoutOffset
		thickness: font strikeoutSize
		left: glyphExtents bearingX
		width: glyphExtents width
		color: Color green
]

{ #category : #drawing }
AeHbCairoExample >> drawText [

	cairoContext restoreStateAfter: [
		cairoContext
			translateByX: 0.0 y: fontExtents ascent;
			sourceColor: Color black;
			showGlyphs: glyphArray ]
]

{ #category : #drawing }
AeHbCairoExample >> drawUnderline [

	self
		drawSolidHLineCenteredAt: fontExtents ascent - font underlineOffset
		thickness: font underlineSize
		left: glyphExtents bearingX
		width: glyphExtents width
		color: Color red
]

{ #category : #initialization }
AeHbCairoExample >> font: aHbFont [

	font := aHbFont.
	self prepareCairoTextObjects
]

{ #category : #initialization }
AeHbCairoExample >> initializeWith: aString font: aHbFont fontSize: aFontSize cairoContext: aCairoContext [

	self initialize.
	
	string := aString.
	fontSize := aFontSize.
	cairoContext := aCairoContext.

	self font: aHbFont
]

{ #category : #'debugging - new tools' }
AeHbCairoExample >> inspectionOfSurfaceAsForm: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Cairo context'>

	^ cairoContext inspectionOfSurfaceAsForm: aBuilder
]

{ #category : #private }
AeHbCairoExample >> newCairoFontOptions [ 

	^ AeCairoFontOptions new
		hintMetrics: AeCairoHintMetrics off;
		hintStyle: AeCairoHintStyle none;
		yourself
]

{ #category : #initialization }
AeHbCairoExample >> prepareCairoTextObjects [

	font scale: fontSize as26Dot6FractionalPoint asPoint.
	cairoFontFace := font newCairoFontFace.
	cairoContext fontFace: cairoFontFace.
	cairoContext fontSize: fontSize.
	cairoContext fontOptions: self newCairoFontOptions.
	cairoScaledFont := cairoContext scaledFont.
	glyphArray := cairoScaledFont glyphArrayForString: string.
	glyphExtents := cairoScaledFont glyphExtentsOf: glyphArray.
	fontExtents := cairoScaledFont fontExtents

]

{ #category : #drawing }
AeHbCairoExample >> seeClassSide [
]
