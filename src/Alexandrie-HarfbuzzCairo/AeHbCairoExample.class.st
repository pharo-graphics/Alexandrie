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
		'cairoScaledFont'
	],
	#category : #'Alexandrie-HarfbuzzCairo'
}

{ #category : #'instance creation' }
AeHbCairoExample class >> exampleDraw: aString face: aHbFace [

	| cairoSurface fontSize instance |
	fontSize := 100.

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
			face: aHbFace
			fontSize: fontSize
			cairoContext: cairoSurface newContext.
	
	instance
		clearSurface;
		drawBackground;
		drawBaseline;
		drawText;
		drawUnderline;
		drawStrikeout;
		inspect
]

{ #category : #examples }
AeHbCairoExample class >> exampleDrawFFLigature [

	self exampleDraw: 'Office' face: self newInriaFace
]

{ #category : #examples }
AeHbCairoExample class >> exampleDrawLigature [

	self exampleDraw: 'a->>g' face: self newCascadiaFace
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

{ #category : #'instance creation' }
AeHbCairoExample class >> newWith: aString face: aHbFace fontSize: aFontSize cairoContext: aCairoContext [

	^ self basicNew
		  initializeWith: aString
		  face: aHbFace
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
AeHbCairoExample >> drawBackground [

	cairoContext restoreStateAfter: [
		cairoContext
			rectangleX: glyphExtents bearingX
				y: 0
				width: glyphExtents width
				height: fontExtents ascent;
			sourceColor: Color yellow;
			fill ]

]

{ #category : #drawing }
AeHbCairoExample >> drawBaseline [

	| thickness lineY |
	thickness := 1.0.
	lineY := fontExtents ascent + (thickness/2.0).
	cairoContext restoreStateAfter: [
		cairoContext
			moveToX: 0.0 y: lineY;
			lineToX: glyphExtents advanceX y: lineY.

		cairoContext
			lineCap: AeCairoCapStyle square;
			dash: (AeCairoDoubleArray newFrom: {0.0. 3*thickness}) offset: 0.

		cairoContext
			sourceColor: Color black;
			stroke ]

]

{ #category : #drawing }
AeHbCairoExample >> drawStrikeout [

	cairoContext restoreStateAfter: [
		cairoContext
			rectangleX: glyphExtents bearingX
			y: fontExtents ascent - font strikeoutOffset
			width: glyphExtents width
			height: font strikeoutSize.
		cairoContext sourceColor: Color green; fill ]

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

	cairoContext restoreStateAfter: [
		cairoContext
			rectangleX: glyphExtents bearingX
			y: fontExtents ascent - font underlineOffset
			width: glyphExtents width
			height: font underlineSize.
		cairoContext sourceColor: Color red; fill ]
]

{ #category : #initialization }
AeHbCairoExample >> initializeWith: aString face: aHbFace fontSize: aFontSize cairoContext: aCairoContext [

	| face fontSize |
	self initialize.
	
	string :=aString.
	face := aHbFace.
	fontSize := aFontSize.
	cairoContext := aCairoContext.

	font := face newHbFont.
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

{ #category : #drawing }
AeHbCairoExample >> seeClassSide [
]
