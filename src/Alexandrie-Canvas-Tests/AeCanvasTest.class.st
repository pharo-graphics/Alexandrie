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

	^ self class selectors select: [ :each | each isUnary and: [each beginsWith: 'canvasWith'] ]
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

	"Key message being tested"
	aeCanvas shouldClipAfterDrawingFigure: true.

	"Draw container figure (a rectangle)"
	aeCanvas pathTranslate: 10 asPoint.
	aeCanvas setBackgroundWith: [
		aeCanvas setSourceColor: Color blue ].
	aeCanvas setBorderOff.
	aeCanvas drawClosedPathWith: [ :cairoContext |
		cairoContext rectangleTo: 30 asPoint ].
	aeCanvas drawFigure.

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
AeCanvasTest >> canvasWithNestedFiguresAndBackgroundAlpha: backgroundAlpha hasBorder: hasBorder outskirtsSelector: outskirtsSelector [

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

			aeCanvas
				shouldClipAfterDrawingFigure: depth odd;
				drawFigure.
				
			depth > 0 ifTrue: [
				drawFigureBlock value: depth-1 ] ] ].

	"Move to initial position and draw with depth=2"
	aeCanvas pathTranslate: referenceExtent / 4.
	drawFigureBlock value: 2.

	^ aeCanvas
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderCenterAndNoBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderCenterAndOpaqueBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderCenterAndTranslucentBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsCentered
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderInsideAndNoBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderInsideAndOpaqueBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderInsideAndTranslucentBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsInside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderOutsideAndNoBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderOutsideAndOpaqueBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 1.0
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithBorderOutsideAndTranslucentBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.5
		  hasBorder: true
		  outskirtsSelector: #setOutskirtsOutside
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithoutBorderAndOpaqueBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 1.0
		  hasBorder: false
		  outskirtsSelector: nil
]

{ #category : #tests }
AeCanvasTest >> canvasWithNestedFiguresWithoutBorderAndTranslucentBackground [

	^ self
		  canvasWithNestedFiguresAndBackgroundAlpha: 0.5
		  hasBorder: false
		  outskirtsSelector: nil
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

	cairoGlyphsArray := cairoScaledFont glyphArrayForString: 'Office'.

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
