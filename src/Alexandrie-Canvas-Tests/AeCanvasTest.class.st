"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #hooks }
AeCanvasTest >> actualFormFor: aSymbol [

	^ (self perform: aSymbol)
		flush;
		asForm
]

{ #category : #hooks }
AeCanvasTest >> allFormSelectors [

	^ self class selectors select: [ :each | each beginsWith: 'canvasWith' ]
]

{ #category : #tests }
AeCanvasTest >> canvasWithArbitraryFigure [

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
AeCanvasTest >> canvasWithClear [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 10 asPoint.
	aeCanvas clearTransparent.
	aeCanvas clear: Color green.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> canvasWithClippedFigures [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.
	aeCanvas clear: Color yellow.

	aeCanvas pathTranslate: 10 asPoint.
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangleTo: 30 asPoint ].
	aeCanvas drawFigure.

	"Key message being tested:"
	aeCanvas prepareToDrawChildrenWithClipping: true.

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
AeCanvasTest >> canvasWithClosedFigure [

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
AeCanvasTest >> canvasWithCurvedFigure [

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
AeCanvasTest >> canvasWithForm [

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

{ #category : #tests }
AeCanvasTest >> canvasWithOpenFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.

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
AeCanvasTest >> canvasWithText [

	| aeCanvas aFTFace cairoScaledFont cairoGlyphsArray baselineY baselineX |
	aeCanvas := AeCanvas extent: 100 @ 50.
	aeCanvas clear: Color paleBlue.

	aFTFace := AeFontManager globalInstance defaultFace.
	cairoScaledFont := aeCanvas scaledFontForFace: aFTFace size: 40.

	baselineY := cairoScaledFont extents ascent.

	cairoGlyphsArray := cairoScaledFont glyphArrayFor: 'Office'.

	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents | baselineX := aTextExtents bearingX ].

	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: baselineX @ baselineY.
		aeCanvas setSourceColor: Color orange.
		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont ].

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> canvasWithTextWithHarfbuzz [

	| aeCanvas aFTFace cairoScaledFont cairoGlyphsArray baselineY baselineX |
	aeCanvas := AeCanvas extent: 100 @ 50.
	aeCanvas clear: Color paleBlue.

	aFTFace := AeFontManager globalInstance defaultFace.
	cairoScaledFont := aeCanvas scaledFontForFace: aFTFace size: 40.

	baselineY := cairoScaledFont extents ascent.

	cairoGlyphsArray := AeHbBuffer defaultCairoGlyphArrayFor: 'Office' face: aFTFace size: 40.

	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents | baselineX := aTextExtents bearingX ].

	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: baselineX @ baselineY.
		aeCanvas setSourceColor: Color orange.
		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont ].

	^ aeCanvas
]

{ #category : #convenience }
AeCanvasTest >> deleteAllExports [
	<script: 'self new deleteAllExports' >

	super deleteAllExports
]

{ #category : #hooks }
AeCanvasTest >> expectedFormsDirectory [

	^ AeFilesystemResources canvasDirectory
]

{ #category : #convenience }
AeCanvasTest >> exportAll [
	<script: 'self new exportAll' >

	super exportAll
]
