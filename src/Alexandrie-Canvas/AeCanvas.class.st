"
I am a canvas to render geometrical figures on a Cairo surface.

# Draw a figure

To draw a figure, prepare the canvas using `set*` methods in the API protocol,
using this order:

1. set up background
2. set up border and outskirts
3. set up path
4. send `drawFigure`

Note: Background MUST be set BEFORE border.

## Special cases:

1. Outside outskirt + translucent color as background: use alpha value as background alpha.
2. Cap round: use only with center outskirt.

# Nesting figures

I'm prepared to draw a tree of figures, A node's children can be either clipped or not.
It depends on the argument sent to `prepareToDrawChildrenWithClipping:`.

"
Class {
	#name : #AeCanvas,
	#superclass : #Object,
	#instVars : [
		'hasBackground',
		'borderWidth',
		'formToCairoSurfaceCache',
		'backgroundAlpha',
		'cairoSurface',
		'backgroundSourceBlock',
		'arrayToDashesBuf',
		'pathBlock',
		'isPathSetAsClip',
		'cairoContext',
		'fontOptions',
		'identityMatrix',
		'textExtents',
		'scaledFontByFreetypeFont',
		'fontExtentsByScaledFont',
		'borderBlock',
		'figureBlock',
		'hasJoins',
		'hasCaps',
		'currentScaledFontId'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #accessing }
AeCanvas class >> extent: aPoint [

	^ self newFor: (AeCairoImageSurface extent: aPoint)
]

{ #category : #accessing }
AeCanvas class >> new [

	^ self shouldNotImplement
]

{ #category : #accessing }
AeCanvas class >> newFor: aeCairoSurface [

	^ self basicNew
		  initializeWith: aeCairoSurface;
		  yourself
]

{ #category : #converting }
AeCanvas >> asForm [

	^ cairoSurface asForm
]

{ #category : #API }
AeCanvas >> drawFigure [

	figureBlock value
]

{ #category : #text }
AeCanvas >> drawText: aeGlyphArray font: aScaledFont [

	cairoContext
		primSetScaledFont: aScaledFont;
		primShowGlyphs: aeGlyphArray num: aeGlyphArray size
]

{ #category : #accessing }
AeCanvas >> extent [

	^ cairoSurface extent
]

{ #category : #rendering }
AeCanvas >> flush [

	cairoSurface flush
]

{ #category : #text }
AeCanvas >> fontExtentsOf: aeScaledFont [

	fontExtentsByScaledFont ifNil:[
		fontExtentsByScaledFont := IdentityDictionary new ].

	^ fontExtentsByScaledFont
		at: aeScaledFont
		ifAbsentPut:[ aeScaledFont extents ]

]

{ #category : #initialization }
AeCanvas >> initializeWith: aeCairoSurface [

	self initialize.

	cairoSurface := aeCairoSurface.
	cairoContext := cairoSurface newContext.
	identityMatrix := AeCairoMatrix newIdentity.
	textExtents := AeCairoTextExtents new.

	self setHighQualityOptions.

]

{ #category : #text }
AeCanvas >> newScaledFontForFace: aFTFace size: aSize [
	"Answer a AeCairoScaledFont that corresponds to the provided font and scale"

 	| aCairoFontFace aFontMatrix |
	aCairoFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aFontMatrix := AeCairoMatrix scaleBy: aSize.
			
	^ aCairoFontFace 
				newScaledFontWithFontMatrix: aFontMatrix
				userToDeviceMatrix: identityMatrix
				options: fontOptions
]

{ #category : #API }
AeCanvas >> paintGroupWith: aBlock [
	"Note: Cairo already saves and restores its state with push_group and pop_group"

	cairoContext primPushGroup.

	aBlock value.

	cairoContext
		primPopGroupToSource;
		primPaint
]

{ #category : #API }
AeCanvas >> paintGroupWith: aBlock alpha: aNumber [
	"Note: Cairo already saves and restores its state with push_group and pop_group"

	cairoContext primPushGroup.

	aBlock value.

	cairoContext
		primPopGroupToSource;
		primPaintAlpha: aNumber
]

{ #category : #API }
AeCanvas >> pathScale: aPoint [

	cairoContext scale: aPoint
]

{ #category : #API }
AeCanvas >> pathTransform: aeCairoMatrix [

	aeCairoMatrix isIdentity ifTrue: [ ^self ].
	cairoContext primApplyTransform: aeCairoMatrix
]

{ #category : #API }
AeCanvas >> pathTranslate: aPoint [

	aPoint isZero ifTrue: [ ^self ].
	cairoContext translate: aPoint
]

{ #category : #private }
AeCanvas >> preparePath [

	pathBlock value: cairoContext
]

{ #category : #private }
AeCanvas >> prepareStroke: aBoolean [

	borderBlock value.

	aBoolean ifTrue:[ borderWidth := borderWidth * 2.0 ].	
	cairoContext primSetLineWidth: borderWidth.

]

{ #category : #API }
AeCanvas >> prepareToDrawChildrenWithClipping: aBoolean [

	aBoolean
		ifTrue: [
			isPathSetAsClip ifFalse: [ 
				self preparePath.
				cairoContext primClip ] ]
		ifFalse: [
			isPathSetAsClip ifTrue: [
				cairoContext resetClip ] ].
	isPathSetAsClip := aBoolean
]

{ #category : #private }
AeCanvas >> privateAeCairoContext [

	^ cairoContext
]

{ #category : #API }
AeCanvas >> restoreContextAfter: aBlock [

	cairoContext primSave.

	aBlock value.

	cairoContext primRestore
]

{ #category : #text }
AeCanvas >> scaledFontForFace: aFTFace size: pointSize [
	"Answer a AeCairoScaledFont that corresponds to the provided face and point size."

	scaledFontByFreetypeFont ifNil: [ scaledFontByFreetypeFont := Dictionary new ].

	^ scaledFontByFreetypeFont
		  at: {aFTFace. pointSize}
		  ifAbsentPut: [ self newScaledFontForFace: aFTFace size: pointSize ]
]

{ #category : #API }
AeCanvas >> setBackgroundOff [

	hasBackground := false.

]

{ #category : #API }
AeCanvas >> setBackgroundWith: aBlock alpha: aDouble [
	"Note: If alpha is zero, it's faster using #setBackgroundOff."

	hasBackground := true.
	backgroundAlpha := aDouble.
	backgroundSourceBlock := aBlock
]

{ #category : #API }
AeCanvas >> setBackgroundWithForm: aForm alpha: aDouble [

	"TODO: do not initialize here, and reset on new session"	
	formToCairoSurfaceCache ifNil: [
		formToCairoSurfaceCache := LRUCache new
			maximumWeight: 400;
			factory: [ :form | AeCairoImageSurface fromForm: form ];
			yourself ].

	self
		setBackgroundWith: [ 
			| aCairoSurface |
			aCairoSurface := formToCairoSurfaceCache at: aForm.
			cairoContext primSetSourceSurface: aCairoSurface x: 0.0 y: 0.0 ]
 		alpha: aDouble

]

{ #category : #API }
AeCanvas >> setBorderBlock: aBlockClosure [

	borderBlock := aBlockClosure
]

{ #category : #API }
AeCanvas >> setBorderOff [

	hasBackground
		ifTrue: [ self setFigureWithoutBorderAndBackground ]
		ifFalse: [ self setFigureIsNull ]
]

{ #category : #API }
AeCanvas >> setBorderWidth: aDouble [

	borderWidth := aDouble

]

{ #category : #API }
AeCanvas >> setCapButt [

	"Do nothing as it's the default in Cairo"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-cap"
]

{ #category : #API }
AeCanvas >> setCapRound [
	
	cairoContext primSetLineCap: AeCairoCapStyle CAIRO_LINE_CAP_ROUND
]

{ #category : #API }
AeCanvas >> setCapSquare [
	
	cairoContext primSetLineCap: AeCairoCapStyle CAIRO_LINE_CAP_SQUARE
]

{ #category : #API }
AeCanvas >> setDashes: dashArray offset: dashOffset [ 

	"TODO: do not initialize here, and reset on new session"	
	arrayToDashesBuf ifNil: [
		arrayToDashesBuf := LRUCache new
			maximumWeight: 400;
			factory: [ :anArray |
				| buf |
				buf := ByteArray new: 8 * anArray size.
				anArray withIndexDo: [ :len :i |
					buf doubleAt: (i-1) * 8 + 1 put: len asFloat ].
				buf ];
			yourself ].

	cairoContext
		primSetDash: (arrayToDashesBuf at: dashArray)
		count: dashArray size
		offset: dashOffset

]

{ #category : #private }
AeCanvas >> setFigureIsNull [
	
	figureBlock := [ ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderCenter [

	figureBlock := [

		self preparePath.

		hasBackground ifTrue: [
			backgroundSourceBlock value.
			cairoContext
				primClipPreserve;
				primPaintAlpha: backgroundAlpha;
				resetClip ].

		self prepareStroke: false.
		cairoContext primStroke ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderInsideAndBackground [

	figureBlock := [

		self preparePath.

		backgroundSourceBlock value.
		cairoContext
			primClipPreserve;
			primPaintAlpha: backgroundAlpha.
		isPathSetAsClip := true.

		self prepareStroke: true.
		cairoContext primStroke.

		]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderInsideAndNoBackground [

	figureBlock := [

		self preparePath.

		self prepareStroke: true.
		cairoContext 
			primClipPreserve;
			primStroke.
		isPathSetAsClip := true.

		]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndNoBackground [

	figureBlock := [

		self preparePath.

		self paintGroupWith: [ 
			self prepareStroke: true.
			cairoContext primStrokePreserve.
	
			"Clear inside"
			cairoContext
				setOperatorClear;
				primFill ].

		 ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndOpaqueBackground [

	figureBlock := [

		self preparePath.

		self prepareStroke: true.
		cairoContext primStrokePreserve.

		backgroundSourceBlock value.
		cairoContext
			primClip;
			primPaint.
		isPathSetAsClip := true.

		]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndTranslucentBackground [

	figureBlock := [

		self preparePath.

		self paintGroupWith: [ 
			self prepareStroke: true.
			cairoContext primStrokePreserve.

			"Clear inside"
			cairoContext
				setOperatorClear;
				primFillPreserve ].

		backgroundSourceBlock value.
		cairoContext
			primClip;
			primPaintAlpha: backgroundAlpha.
		isPathSetAsClip := true.

		]

]

{ #category : #private }
AeCanvas >> setFigureWithoutBorderAndBackground [
	
	figureBlock := [

		self preparePath.

		backgroundSourceBlock value.
		cairoContext
			primClip;
			primPaintAlpha: backgroundAlpha.
		isPathSetAsClip := true.
		
		]

]

{ #category : #initialization }
AeCanvas >> setHighQualityOptions [

	| antialiasOption |
	antialiasOption := AeCairoAntialias CAIRO_ANTIALIAS_FAST.

	cairoContext
		primSetTolerance: 0.2;
		primSetAntialias: antialiasOption.

	fontOptions := AeCairoFontOptions new
		antialias: antialiasOption;
		hintMetrics: AeCairoHintMetrics CAIRO_HINT_METRICS_ON;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_SLIGHT;
		subpixelOrder: AeCairoSubpixelOrder CAIRO_SUBPIXEL_ORDER_DEFAULT;
		yourself

"As Sparta-Cairo would be:
	fontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_SUBPIXEL;
		hintMetrics: AeCairoHintMetrics CAIRO_HINT_METRICS_ON;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_MEDIUM;
		subpixelOrder: AeCairoSubpixelOrder CAIRO_SUBPIXEL_ORDER_RGB;
		yourself
"

]

{ #category : #API }
AeCanvas >> setJoinBevel [

	cairoContext primSetLineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_BEVEL
]

{ #category : #API }
AeCanvas >> setJoinMiter: limit [
	
	"No need to set miter join as it's the default in Cairo"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-join"
	
	"But we might need to set the miter limit if it's not the default"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-miter-limit"
	limit = 10.0 ifFalse: [ 
		cairoContext primSetMiterLimit: limit ]

]

{ #category : #API }
AeCanvas >> setJoinRound [

	cairoContext primSetLineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_ROUND
]

{ #category : #API }
AeCanvas >> setLineCapBlock: aFullBlockClosure [ 
	
	hasCaps ifTrue: aFullBlockClosure
]

{ #category : #API }
AeCanvas >> setLineJoinBlock: aFullBlockClosure [ 
	
	hasJoins ifTrue: aFullBlockClosure
]

{ #category : #initialization }
AeCanvas >> setLowQualityOptions [

	cairoContext
		primSetTolerance: 0.5;
		primSetAntialias: AeCairoAntialias CAIRO_ANTIALIAS_NONE.

	fontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_FAST;
		hintMetrics: AeCairoHintMetrics CAIRO_HINT_METRICS_OFF;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_NONE;
		subpixelOrder: AeCairoSubpixelOrder CAIRO_SUBPIXEL_ORDER_DEFAULT;
		yourself

]

{ #category : #API }
AeCanvas >> setOutskirtsCentered [

	self setFigureWithBorderCenter
]

{ #category : #API }
AeCanvas >> setOutskirtsInside [

	hasBackground
		ifTrue: [ self setFigureWithBorderInsideAndBackground ]
		ifFalse: [ self setFigureWithBorderInsideAndNoBackground ]
]

{ #category : #API }
AeCanvas >> setOutskirtsOutside [

	hasBackground
		ifTrue: [
			backgroundAlpha = 1.0
				ifTrue: [ self setFigureWithBorderOutsideAndOpaqueBackground ]
				ifFalse: [ self setFigureWithBorderOutsideAndTranslucentBackground ] ]
		ifFalse: [
			self setFigureWithBorderOutsideAndNoBackground ]

]

{ #category : #API }
AeCanvas >> setPathKey: anObject hasJoins: hasJoinsBoolean hasCaps: hasCapsBoolean block: aUnaryBlock [
	"Establish how to draw the path and some properties that serve to optimize.
	The anObject argument might serve as a cache key.
	The block closure receives an instance of AeCairoContext to build the geometrical
	path. It is expected to utilize the path drawing API (bindings of
	https://www.cairographics.org/manual/cairo-Paths.html)"

	isPathSetAsClip := false.
	hasJoins := hasJoinsBoolean.
	hasCaps := hasCapsBoolean.
	pathBlock := aUnaryBlock
]

{ #category : #private }
AeCanvas >> setSourceColor: aColor [

	"TODO: The default source pattern is opaque black, (that is, it is equivalent to cairo_set_source_rgba(cr, 0.0, 0.0, 0.0, 1.0))."
"	aColor isBlack ifTrue: [ ^ self ]."

	aColor isTranslucent
		ifTrue: [ self setSourceTranslucentColor: aColor ]
		ifFalse: [ self setSourceSolidColor: aColor ]
]

{ #category : #private }
AeCanvas >> setSourceSolidColor: aColor [

	cairoContext
		primSetSourceR: aColor red
		g: aColor green
		b: aColor blue
]

{ #category : #private }
AeCanvas >> setSourceTranslucentColor: aColor [

	cairoContext setSourceRGBAColor: aColor

]

{ #category : #text }
AeCanvas >> textExtentsFor: aeGlyphsArray scaledFont: aeScaledFont do: aUnaryBlockClosure [
	
	cairoContext
		primSetScaledFont: aeScaledFont;
		primGlyphExtents: aeGlyphsArray
			num: aeGlyphsArray size
			metrics: textExtents.
	aUnaryBlockClosure value: textExtents
]
