"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #AePixelMatchTest,
	#instVars : [
		'emojiFTFace',
		'ffLigatureFTFace'
	],
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #hooks }
AeCanvasTest class >> allFormSelectors [

	^ self selectors select: [ :each | each isUnary and: [each beginsWith: 'render'] ]
]

{ #category : #convenience }
AeCanvasTest class >> exportAll [
	<script: 'super exportAll' >

	super exportAll
]

{ #category : #convenience }
AeCanvasTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
AeCanvasTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
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

{ #category : #tests }
AeCanvasTest >> renderArbitraryFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext
			rectangle: (0 asPoint extent: 20 asPoint);
			circleRadius: 20 ].

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderBackgroundAlpha: backgroundAlpha hasBorder: hasBorder outskirtsSelector: outskirtsSelector [

	^ AeTestRecursiveFiguresBuilder new
		backgroundAlpha: backgroundAlpha;
		hasBorder: hasBorder;
		outskirtsSelector: outskirtsSelector;
		newCanvas
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
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: 30 asPoint ].
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	"Key message for this test"
	aeCanvas drawFigureAndPrepareToClip.

	"Draw a child circle that is clipped by the parent rectangle."
	aeCanvas pathTranslate: 15 asPoint.
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext circleRadius: 15 ].
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color orange ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderClosedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangle: (10 asPoint extent: 20 asPoint) ].

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderCurvedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext circleRadius: 25 ].

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderEmoji [

	| fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |

	self skip. "Randomly fails. We suspect we need a more recent version of cairo (it introduced improvements in this area)."

	fontHeight := 25.
	aeCanvas := AeCanvas extent: fontHeight * 1.3 asPoint.
	aeCanvas clear: Color paleYellow.

	emojiFTFace := AeFTLibraryResource current emojiFTFace.
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
	aeCanvas := AeCanvas extent: 60@20.
	aeCanvas clear: Color paleGreen.
	
	aForm := Form fromFileNamed: AeFilesystemResources removeIconPNG.

	aeCanvas pathScale: (aeCanvas extent / aForm extent) asFloatPoint.
	aeCanvas pathFactory: [ :cairoContext |
		"Tip: Use another path to clip the form"
		cairoContext rectangleTo: aForm extent ].

	aeCanvas
		setBackgroundWithForm: aForm
		alpha: 1.0.
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderFormSet [

	| aeCanvas aForm aFormSet |

	SystemVersion current major >= 12 ifFalse: [ self skip ]. "Earlier versions do not have FormSet"

	aeCanvas := AeCanvas newFor: ((AeCairoImageSurface extent: (60@20) * 2) deviceScale: 2 asPoint; yourself).
	aeCanvas clear: Color paleGreen.
	
	aForm := Form fromFileNamed: AeFilesystemResources removeIcon2xPNG.
	aFormSet := FormSet extent: aForm extent // 2 depth: aForm depth forms: { aForm }.

	aeCanvas pathScale: ((aeCanvas extent / aeCanvas deviceScale) / aFormSet extent) asFloatPoint.
	aeCanvas pathFactory: [ :cairoContext |
		"Tip: Use another path to clip the form"
		cairoContext rectangleTo: aFormSet extent ].

	aeCanvas
		setBackgroundWithFormSet: aFormSet
		alpha: 1.0.
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderFormThatUpdated [

	| aeCanvas aFormCanvas |
	aeCanvas := AeCanvas extent: 16@16.
	
	aFormCanvas := FormCanvas extent: 16@16.
	aFormCanvas fillColor: Color red.

	"1) Horizontal red rectangle"
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: 16@8 ].
	aeCanvas
		setBackgroundWithForm: aFormCanvas form
		alpha: 1.0.
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	"2) Vertical rectangle:
	Without the Form cache, this rectangle would be green.
	However, the cache makes it be painted red again."
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: 8@16 ].
	aFormCanvas fillColor: Color green.
	aeCanvas
		setBackgroundWithForm: aFormCanvas form
		alpha: 1.0.
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	"3) Smaller rectangle:
	This time, we reset the caches and it's painted in green"
	aeCanvas resetFormCaches.
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: 8@8 ].
	aeCanvas
		setBackgroundWithForm: aFormCanvas form
		alpha: 1.0.
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #private }
AeCanvasTest >> renderGlyphs: aCairoGlyphsArray scaledFont: aCairoScaledFont on: aeCanvas [

	| metrics baseline |

	"Calculate text metrics"
	metrics :=
		aeCanvas
			metricsFor: aCairoGlyphsArray
			font: aCairoScaledFont.
	baseline := metrics bearingX @ metrics ascent negated.

	"Draw baseline"
	aeCanvas restoreContextAfter: [
		aeCanvas
			pathFactory: [ :cairoContext |
				cairoContext
					moveTo: baseline;
					relativeLineToX: metrics advanceX y: 0 ];
			setBackgroundOff;
			setOutskirtsCentered;
			setBorderBlock: [
				aeCanvas
					setSourceColor: Color gray;
					setDashes: #(1 1) offset: 0;
					setBorderWidth: 1 ];
			drawFigure ].

	"Draw the glyphs"
	aeCanvas
		setSourceColor: Color orange;
		pathTranslate: baseline;
		drawGlyphs: aCairoGlyphsArray
			font: aCairoScaledFont
]

{ #category : #tests }
AeCanvasTest >> renderLigatureTextWithHarfbuzz [
	"Test Harfbuzz converting a 'ff' pair of letters into a single glyph."

	| aString fontSize aeCanvas cairoScaledFont cairoGlyphsArray |
	aString := 'Office'.
	fontSize := 19.
	aeCanvas := AeCanvas extent: 50 @ 25.
	aeCanvas clear: Color paleBlue.

	"We do know this typeface defines a glyph for ff"
	ffLigatureFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	cairoScaledFont := aeCanvas scaledFontForFace: ffLigatureFTFace size: fontSize.

	"This is the key message send of this test"
	cairoGlyphsArray := AeHbBuffer
		defaultCairoGlyphArrayFor: aString
		face: ffLigatureFTFace
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

	| aString fontSize aeCanvas cairoScaledFont cairoGlyphsArray |
	aString := 'Office'.
	fontSize := 19.
	aeCanvas := AeCanvas extent: 50 @ 25.
	aeCanvas clear: Color paleBlue.

	"We do know this typeface defines a glyph for ff"
	ffLigatureFTFace := AeFTLibraryResource current sourceSansProRegularFTFace.
	cairoScaledFont := aeCanvas scaledFontForFace: ffLigatureFTFace size: fontSize.

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

	"Set line path"
	aeCanvas pathFactory: [ :cairoContext |
		cairoContext
			moveTo: 20@10;
			lineTo: 30@40 ].

	"Background and other outskirts than centered are an option but
	they do not look well on open figures."
	aeCanvas
		setBackgroundOff;
		setOutskirtsCentered.

	"Finally, customize stroke options and draw the line"
	aeCanvas
		setBorderBlock: [
			aeCanvas
				setSourceColor: Color red;
				setDashes: #(4 6) offset: 2;
				setJoinRound; "A line has no joins, anyway"
				setCapSquare;
				setBorderWidth: 4 ];
		drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderWithRotation [

	| aeCanvas extent |
	extent := 40 @ 30.
	aeCanvas := AeCanvas extent: extent.

	aeCanvas pathRotateByRadians: 15 degreesToRadians.

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: extent / 2 ].

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color purple ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderWithRotationAboutCenter [

	| aeCanvas extent |
	extent := 40 @ 30.
	aeCanvas := AeCanvas extent: extent.

	aeCanvas
		pathRotateByRadians: 45 degreesToRadians
		about: extent / 2.

	aeCanvas pathFactory: [ :cairoContext |
		cairoContext rectangleTo: extent ].

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color cyan ].
	aeCanvas setBorderOff.
	aeCanvas drawFigure.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> renderZWJEmojiWithHarfbuzz [

	| fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |

	self skip. "Randomly fails. We suspect we need a more recent version of cairo (it introduced improvements in this area)."

	fontHeight := 24.
	aeCanvas := AeCanvas extent: 200 @ (fontHeight * 2).
	aeCanvas clear: Color white.

	emojiFTFace := AeFTLibraryResource current emojiFTFace.
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

	| fontHeight aeCanvas cairoScaledFont cairoGlyphsArray |

	self skip. "Randomly fails. We suspect we need a more recent version of cairo (it introduced improvements in this area)."

	fontHeight := 21.
	aeCanvas := AeCanvas extent: (fontHeight * 5.5) @ (fontHeight * 1.2).
	aeCanvas clear: Color white.

	emojiFTFace := AeFTLibraryResource current emojiFTFace.
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

{ #category : #accessing }
AeCanvasTest >> resources [

	^ { AeFTLibraryResource }
]
