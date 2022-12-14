"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #hooks }
AeCanvasTest class >> allFormSelectors [

	^ self selectors select: [ :each | each isUnary and: [each beginsWith: 'render'] ]
]

{ #category : #convenience }
AeCanvasTest class >> deleteAllExports [
	<script: 'self deleteAllExports' >

	super deleteAllExports
]

{ #category : #convenience }
AeCanvasTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AeCanvasTest class >> inspectAll [
	<script: 'self inspectAll' >

	super inspectAll
]

{ #category : #private }
AeCanvasTest >> emojiZWJString [ 

	^ (WideString streamContents: [ :stream |
	 	#(16r1F468 16r1F469 16r1F467 16r1F466)
			do: [ :each | stream nextPut: (Unicode value: each) ]
			separatedBy: [ stream nextPut: Unicode zeroWidthJoiner ]])

]

{ #category : #hooks }
AeCanvasTest >> expectedFormsDirectory [

	^ AeFilesystemResources canvasDirectory
]

{ #category : #hooks }
AeCanvasTest >> formBehavior [

	^ self
]

{ #category : #private }
AeCanvasTest >> notoColorEmojiFace [

	"Ensure font is available"
	AeFontManager globalInstance scanDirectory: AeFilesystemResources fontsDirectory.

	^ AeFontManager globalInstance
		detectFamilyName: AeNotoColorEmojiDownloadedFont new familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self error ].
]

{ #category : #tests }
AeCanvasTest >> renderArbitraryFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	aeCanvas
		setPathKey: self
		hasJoins: true
		hasCaps: true
		block: [ :cairoContext |
			cairoContext
				rectangle: (0 asPoint extent: 20 asPoint);
				circleRadius: 20 ].

	aeCanvas drawFigure.


	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderBackgroundAlpha: backgroundAlpha hasBorder: hasBorder outskirtsSelector: outskirtsSelector [

	| aeCanvas drawFigureBlock referenceExtent |
	referenceExtent := 50 asPoint.
	aeCanvas := AeCanvas extent: referenceExtent.
	aeCanvas clear: Color yellow.

	drawFigureBlock := [ :depth |

		aeCanvas restoreContextAfter: [ 

			aeCanvas
				pathTranslate: referenceExtent / -10;
				pathScale: 0.75 asPoint.

			aeCanvas
				setBackgroundWith: [
					aeCanvas setSourceColor: 
						(depth odd
							ifTrue: [ Color green ]
							ifFalse: [ Color red ]) ]
				alpha: backgroundAlpha.

			hasBorder
				ifTrue: [ 
					aeCanvas setBorderBlock: [
						aeCanvas setSourceColor: Color black.
						aeCanvas setBorderWidth: referenceExtent x / 10 ].
					aeCanvas perform: outskirtsSelector ]
				ifFalse: [ aeCanvas setBorderOff ].

			aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
				cairoContext circleRadius: referenceExtent x / 2 ].

			aeCanvas drawFigureAndPrepareToClip: depth odd.
				
			depth > 0 ifTrue: [
				drawFigureBlock value: depth-1 ] ] ].

	"Move to initial position and draw with depth=2"
	aeCanvas pathTranslate: referenceExtent / 4.
	drawFigureBlock value: 2.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderBorderCenterAndNoBackground [

	^ self
		  renderBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> renderBorderCenterAndOpaqueBackground [

	^ self
		  renderBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> renderBorderCenterAndTranslucentBackground [

	^ self
		  renderBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> renderBorderInsideAndNoBackground [

	^ self
		  renderBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> renderBorderInsideAndOpaqueBackground [

	^ self
		  renderBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> renderBorderInsideAndTranslucentBackground [

	^ self
		  renderBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> renderBorderOffAndOpaqueBackground [

	^ self
		  renderBackgroundAlpha: 1.0
		  hasBorder: false
		  outskirtsSelector: nil
]

{ #category : #tests }
AeCanvasTest >> renderBorderOffAndTranslucentBackground [

	^ self
		  renderBackgroundAlpha: 0.5
		  hasBorder: false
		  outskirtsSelector: nil
]

{ #category : #tests }
AeCanvasTest >> renderBorderOutsideAndNoBackground [

	^ self
		  renderBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> renderBorderOutsideAndOpaqueBackground [

	^ self
		  renderBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> renderBorderOutsideAndTranslucentBackground [

	^ self
		  renderBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> renderClear [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 10 asPoint.
	aeCanvas clearTransparent.
	aeCanvas clear: Color green.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderClippedFigures [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.
	aeCanvas clear: Color yellow.

	"Draw container figure (a rectangle)"
	aeCanvas pathTranslate: 10 asPoint.
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangleTo: 30 asPoint ].

	"Key message for this test"
	aeCanvas drawFigureAndPrepareToClip.

	"Draw a child circle that is clipped by the parent rectangle."
	aeCanvas pathTranslate: 15 asPoint.
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color orange ].
	aeCanvas setBorderOff.
	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext circleRadius: 15 ].
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderClosedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangle: (10 asPoint extent: 20 asPoint) ].

	aeCanvas drawFigure.


	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderCurvedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext circleRadius: 25 ].

	aeCanvas drawFigure.


	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderEmoji [

	| emojiFTFace fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |
	emojiFTFace := self notoColorEmojiFace.
	fontHeight := 25.
	aeCanvas := AeCanvas extent: fontHeight * 1.3 asPoint.
	aeCanvas clear: Color paleYellow.
	cairoScaledFont :=
		aeCanvas
			scaledFontForFace: emojiFTFace
			size: fontHeight.

	cairoGlyphsArray := cairoScaledFont glyphArrayForString: (Unicode value: 16r1F468) asString.

	self
		renderGlyphs: cairoGlyphsArray
		scaledFont: cairoScaledFont
		on: aeCanvas.
		 
	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderForm [

	| aeCanvas aForm |
	aeCanvas := AeCanvas extent: 50@75.
	aeCanvas clear: Color paleGreen.
	
	aForm := Smalltalk ui icons iconNamed: #pharoBig.

	aeCanvas
		setBackgroundWithForm: aForm
		alpha: 1.0.
	aeCanvas setBorderOff.

	aeCanvas pathScale: (aeCanvas extent / aForm extent) asFloatPoint.
	aeCanvas drawClosedPathWith: [ :cairoContext |
		"Tip: Use another path to clip the form"
		cairoContext rectangleTo: aForm extent ].

	aeCanvas drawFigure.


	^ aeCanvas
]

{ #category : #private }
AeCanvasTest >> renderGlyphs: aCairoGlyphsArray scaledFont: aCairoScaledFont on: aeCanvas [

	| metrics baseline |

	"Calculate text metrics"
	metrics := aeCanvas metricsFor: aCairoGlyphsArray font: aCairoScaledFont.
	baseline := metrics bearingX @ metrics ascent negated.

	"Draw baseline"
	aeCanvas restoreContextAfter: [
		aeCanvas setBackgroundOff.
		aeCanvas setOutskirtsCentered.

		aeCanvas setBorderBlock: [
			aeCanvas setSourceColor: Color gray.
			aeCanvas setDashes: #(1 1) offset: 0.
			aeCanvas setBorderWidth: 1 ].

		aeCanvas drawOpenPathWith: [ :cairoContext |
			cairoContext
				moveTo: baseline;
				relativeLineToX: metrics advanceX y: 0 ].

		aeCanvas drawFigure ].

	"Draw the glyphs"
	aeCanvas
		setSourceColor: Color orange;
		pathTranslate: baseline;
		drawText: aCairoGlyphsArray
			font: aCairoScaledFont.

]

{ #category : #tests }
AeCanvasTest >> renderLigatureTextWithHarfbuzz [
	"Test Harfbuzz converting a 'ff' pair of letters into a single glyph."

	| aString fontSize aeCanvas aFTFace cairoScaledFont cairoGlyphsArray |
	aString := 'Office'.
	fontSize := 19.
	aeCanvas := AeCanvas extent: 50 @ 25.
	aeCanvas clear: Color paleBlue.
	"We do know this typeface defines a glyph for ff"
	aFTFace := self sourceSansProRegularFace.
	cairoScaledFont := aeCanvas scaledFontForFace: aFTFace size: fontSize.

	"This is the key message send of this test"
	cairoGlyphsArray := AeHbBuffer
		defaultCairoGlyphArrayFor: aString
		face: aFTFace
		size: fontSize.

	"The output of Harfbuzz has a single glyph for the 'ff' pair"
	self assert: cairoGlyphsArray size equals: aString size - 1.

	self
		renderGlyphs: cairoGlyphsArray
		scaledFont: cairoScaledFont
		on: aeCanvas.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderLigatureTextWithoutHarfbuzz [
	"Even if this font defines a ligature glyph for the 'ff' pair of letters, Cairo doesn't take it into account."

	| aString fontSize aeCanvas aFTFace cairoScaledFont cairoGlyphsArray |
	aString := 'Office'.
	fontSize := 19.
	aeCanvas := AeCanvas extent: 50 @ 25.
	aeCanvas clear: Color paleBlue.
	"We do know this typeface defines a glyph for ff"
	aFTFace := self sourceSansProRegularFace.
	cairoScaledFont := aeCanvas scaledFontForFace: aFTFace size: fontSize.

	"We know that cairo ignores the ff ligature (that'd be provided by Harfbuzz)"
	cairoGlyphsArray := cairoScaledFont glyphArrayForString: aString.

	"Cairo performs a 1:1 mapping of the input string to glyphs"
	self assert: cairoGlyphsArray size equals: aString size.

	self
		renderGlyphs: cairoGlyphsArray
		scaledFont: cairoScaledFont
		on: aeCanvas.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderOpenFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	"Background and other outskirts than centered are an option but
	they do not look well on open figures."
	aeCanvas setBackgroundOff.
	aeCanvas setOutskirtsCentered.

	aeCanvas setBorderBlock: [
		aeCanvas setSourceColor: Color red.
		aeCanvas setDashes: #(4 6) offset: 2.
		aeCanvas setLineJoinBlock: [ aeCanvas setJoinRound ].
		aeCanvas setLineCapBlock: [ aeCanvas setCapSquare ].
		aeCanvas setBorderWidth: 4 ].

	aeCanvas drawOpenPathWith: [ :cairoContext |
		cairoContext
			moveTo: 20@10;
			lineTo: 30@40 ].

	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderZWJEmojiWithHarfbuzz [

	| emojiFTFace fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |
	self skip. "Bug"
	
	emojiFTFace := self notoColorEmojiFace.
	fontHeight := 24.
	aeCanvas := AeCanvas extent: 200 @ (fontHeight * 2).
	aeCanvas clear: Color white.
	cairoScaledFont :=
		aeCanvas
			scaledFontForFace: emojiFTFace
			size: fontHeight.

	"This is the key message send of this test"
	cairoGlyphsArray :=
		AeHbBuffer
			defaultCairoGlyphArrayFor: self emojiZWJString
			face: emojiFTFace
			size: fontHeight.

	"The output of Harfbuzz is a single glyph"
	self assert: cairoGlyphsArray size equals: 1.

	self
		renderGlyphs: cairoGlyphsArray
		scaledFont: cairoScaledFont
		on: aeCanvas.
		 
	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderZWJEmojiWithoutHarfbuzz [

	| emojiFTFace fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |
	emojiFTFace := self notoColorEmojiFace.
	fontHeight := 21.
	aeCanvas := AeCanvas extent: (fontHeight * 5.5) @ (fontHeight * 1.2).
	aeCanvas clear: Color white.
	cairoScaledFont :=
		aeCanvas
			scaledFontForFace: emojiFTFace
			size: fontHeight.

	"We know that cairo ignores the ZWJ sequence (that'd be provided by Harfbuzz)"
	cairoGlyphsArray := cairoScaledFont glyphArrayForString: self emojiZWJString.

	"Cairo performs a 1:1 mapping of the input string to glyphs"
	self assert: cairoGlyphsArray size equals: self emojiZWJString size.

	self
		renderGlyphs: cairoGlyphsArray
		scaledFont: cairoScaledFont
		on: aeCanvas.

	^ aeCanvas
]

{ #category : #private }
AeCanvasTest >> sourceSansProRegularFace [

	^ AeFontManager globalInstance
		detectFamilyName: AeSourceSansPro_Regular familyName
		slant: AeFontSlant normal
		weight: AeFontWeight normal
		stretch: AeFontStretch normal
		ifNone: [ self error ]
]
