"
An AeCanvasTest is a test class for testing the behavior of AeCanvas
"
Class {
	#name : #AeCanvasTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #tests }
AeCanvasTest >> testClear [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 50 asPoint.
	aeCanvas clear: Color green.
	aeCanvas clearTransparent.
	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawArbitraryFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

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


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawClosedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangle: (10 asPoint extent: 20 asPoint) ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawCurvedFigure [

	| aeCanvas |
	aeCanvas := AeCanvas extent: 200 asPoint.

	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.

	aeCanvas drawClosedCurvedPathWith: [ :cairoContext |
		cairoContext circleRadius: 10 ].

	aeCanvas drawFigure.


	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawNestedFiguresWithClipping [

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

	aeCanvas flush.

	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawOpenFigure [

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

	aeCanvas flush.
	self assert: aeCanvas asForm class equals: Form

]

{ #category : #tests }
AeCanvasTest >> testDrawText [

	| aeCanvas aFTFace cairoScaledFont cairoGlyphsArray baselineY baselineX |
	aeCanvas := AeCanvas extent: 100 @ 50.
	aeCanvas clear: Color paleBlue.

	aFTFace := AeFontManager globalInstance defaultFace.
	cairoScaledFont := aeCanvas scaledFontForFace: aFTFace size: 40.

	baselineY := cairoScaledFont extents ascent.

	cairoGlyphsArray := cairoScaledFont glyphArrayForString: 'Hello'.

	aeCanvas
		textExtentsFor: cairoGlyphsArray
		scaledFont: cairoScaledFont
		do: [ :aTextExtents | baselineX := aTextExtents bearingX ].

	aeCanvas restoreContextAfter: [ 
		aeCanvas pathTranslate: baselineX @ baselineY.
		aeCanvas setSourceColor: Color orange.
		aeCanvas drawText: cairoGlyphsArray font: cairoScaledFont ].


	aeCanvas flush.
"	aeCanvas asForm inspect."
	self assert: aeCanvas asForm class equals: Form

]
