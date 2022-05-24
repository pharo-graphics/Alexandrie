"
I let Bloc elements render in a Cairo surface.

"
Class {
	#name : #AeCanvas,
	#superclass : #Object,
	#instVars : [
		'hasBackground',
		'borderColor',
		'borderWidth',
		'formToCairoSurfaceCache',
		'backgroundAlpha',
		'cairoSurface',
		'backgroundSourceBlock',
		'borderStyle',
		'arrayToDashesBuf',
		'drawFillAndStrokeBlock',
		'hasOpaqueBackground',
		'isClosedGeometry',
		'pathBlock',
		'isPathSetAsClip',
		'cairoContext',
		'pathCache',
		'fontOptions',
		'identityMatrix',
		'textExtents',
		'scaledFontByFreetypeFont',
		'fontExtentsByScaledFont'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #accessing }
AeCanvas class >> extent: aPoint [

	^ self basicNew
		  initializeExtent: aPoint;
		  yourself
]

{ #category : #accessing }
AeCanvas class >> new [

	^ self shouldNotImplement
]

{ #category : #visiting }
AeCanvas >> acceptBlImageBackground: aBlImageBackground [ 

	| image |
	hasBackground := true.
	backgroundAlpha := aBlImageBackground opacity.
	image := aBlImageBackground image.
	hasOpaqueBackground := image isTranslucent not.

	"TODO: do not initialize here, and reset on new session"	
	formToCairoSurfaceCache ifNil: [
		formToCairoSurfaceCache := LRUCache new
			maximumWeight: 400;
			factory: [ :aForm | AeCairoImageSurface fromForm: aForm ];
			yourself ].
	
	backgroundSourceBlock := [ 
		| aCairoSurface |
		aCairoSurface := formToCairoSurfaceCache at: image.
		cairoContext primSetSourceSurface: aCairoSurface x: 0.0 y: 0.0.
		].

]

{ #category : #visiting }
AeCanvas >> acceptBlPaintBackground: aBlPaintBackground [

	hasBackground := true.
	backgroundAlpha := aBlPaintBackground opacity.
	hasOpaqueBackground := aBlPaintBackground isOpaque.
	backgroundSourceBlock := [
		self setSourceColor: aBlPaintBackground paint color ]

]

{ #category : #visiting }
AeCanvas >> acceptBlTransparentBackground: aBlTransparentBackground [ 

	hasBackground := false.
	backgroundAlpha := 0.0.
	hasOpaqueBackground := false.
	backgroundSourceBlock := nil.
]

{ #category : #visiting }
AeCanvas >> acceptColorPaintBorder: aBlColorPaint border: aBlBorder [

	borderColor := aBlColorPaint color.
	borderWidth := aBlBorder width.
	borderStyle := aBlBorder style.

	(borderColor isTransparent or: [ borderWidth isZero ]) ifTrue: [
		self setWithoutBorder ].


]

{ #category : #visiting }
AeCanvas >> acceptTransparentPaintBorder: aBlElement [ 
	
	self setWithoutBorder.
]

{ #category : #private }
AeCanvas >> applyPathBlock [

	pathBlock value: cairoContext
]

{ #category : #converting }
AeCanvas >> asForm [

	^ cairoSurface asForm
]

{ #category : #API }
AeCanvas >> drawElementAlpha: aNumber with: aBlock [

	aNumber = 1.0
		ifTrue: [ cairoContext restoreAfter: aBlock ]
		ifFalse: [ cairoContext paintGroupWith: aBlock alpha: aNumber ]
]

{ #category : #API }
AeCanvas >> drawFillAndStroke [

	drawFillAndStrokeBlock value
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

{ #category : #rendering }
AeCanvas >> fullDraw: anElement [

	anElement aeDrawOn: self.
	self flush.
	
	^ #()
]

{ #category : #initialization }
AeCanvas >> initializeExtent: aPoint [

	self initialize.

	cairoSurface := AeCairoImageSurface extent: aPoint.
	cairoContext := AeCairoContext create: cairoSurface.
	identityMatrix := AeCairoMatrix newIdentity.
	textExtents := AeCairoTextExtents new.

	self setDefaultCairoContextOptions.

]

{ #category : #API }
AeCanvas >> pathTransform: aMatrix [

	aMatrix isIdentity ifTrue: [ ^self ].
	cairoContext primApplyTransform: aMatrix
]

{ #category : #API }
AeCanvas >> pathTranslate: aPoint [

	aPoint isZero ifTrue: [ ^self ].
	cairoContext translate: aPoint
]

{ #category : #API }
AeCanvas >> restoreAfter: aBlock [

	cairoContext restoreAfter: aBlock
]

{ #category : #text }
AeCanvas >> scaledFontFor: aFreeTypeFont [
	"Answer a AeCairoScaledFont that corresponds to the provided font.
	Since the FreeTypeFont is cached in Pharo, it is used as key in a cache."

	scaledFontByFreetypeFont ifNil: [
		scaledFontByFreetypeFont := Dictionary new ].
	
	^ scaledFontByFreetypeFont
		at: aFreeTypeFont
		ifAbsentPut: [ | aCairoFontFace aFontMatrix |
			aCairoFontFace := AeCairoFreetypeFontFace newFor: aFreeTypeFont.
			aFontMatrix := AeCairoMatrix scaleBy: aFreeTypeFont pointSize.
			
			aCairoFontFace 
				newScaledFontWithFontMatrix: aFontMatrix
				userToDeviceMatrix: identityMatrix
				options: fontOptions ]
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
AeCanvas >> setClipChildren: aBoolean [

	aBoolean
		ifTrue: [
			isPathSetAsClip ifFalse: [ 
				self applyPathBlock.
				cairoContext primClip ] ]
		ifFalse: [
			isPathSetAsClip ifTrue: [
				cairoContext resetClip ] ].
	isPathSetAsClip := aBoolean
]

{ #category : #initialization }
AeCanvas >> setDefaultCairoContextOptions [

	| antialiasOption |
	antialiasOption := AeCairoAntialias CAIRO_ANTIALIAS_FAST.

	cairoContext
		primSetTolerance: 0.5;
		primSetAntialias: antialiasOption.

	fontOptions := AeCairoFontOptions new
		antialias: antialiasOption;
		hintMetrics: AeCairoHintMetrics CAIRO_HINT_METRICS_ON;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_SLIGHT;
		subpixelOrder: AeCairoSubpixelOrder CAIRO_SUBPIXEL_ORDER_RGB;
		yourself

]

{ #category : #private }
AeCanvas >> setDoubleWidth [

	borderWidth := borderWidth * 2.0
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
AeCanvas >> setOutskirtsCentered [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		hasBackground ifTrue: [
			backgroundSourceBlock value.
			cairoContext
				primClipPreserve;
				primPaintAlpha: backgroundAlpha;
				resetClip ].

		self setStrokeParameters.
		cairoContext primStroke ]

]

{ #category : #API }
AeCanvas >> setOutskirtsInside [

	hasBackground
		ifTrue: [ self setWithInsideBorderAndBackground ]
		ifFalse: [ self setWithInsideBorderAndNoBackground ]
]

{ #category : #API }
AeCanvas >> setOutskirtsOutside [

	hasBackground
		ifTrue: [
			hasOpaqueBackground
				ifTrue: [ self setWithOutsideBorderAndOpaqueBackground ]
				ifFalse: [ self setWithOutsideBorderAndTranslucentBackground ] ]
		ifFalse: [
			self setWithOutsideBorderAndNoBackground ]
	
]

{ #category : #API }
AeCanvas >> setPathFor: anObject isClosed: aBoolean with: aBlock [
	"Establish how to draw the path, which can be open or closed.
	The anObject argument might serve as a cache key."

	isPathSetAsClip := false.
	isClosedGeometry := aBoolean.
	pathBlock := aBlock

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

	cairoContext
		primSetSourceR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #private }
AeCanvas >> setStrokeDashes [

	"TODO: do not initialize here, and reset on new session"	
	| dashArray |
	
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

	dashArray := borderStyle dashArray.

	cairoContext
		primSetDash: (arrayToDashesBuf at: dashArray)
		count: dashArray size
		offset: borderStyle dashOffset

]

{ #category : #private }
AeCanvas >> setStrokeParameters [

	self setSourceColor: borderColor.
	
	cairoContext primSetLineWidth: borderWidth.

	borderStyle dashArray ifNotEmpty: [ self setStrokeDashes ].

	borderStyle lineJoin
		aeApplyTo: self
		style: borderStyle.

	isClosedGeometry ifFalse: [
		borderStyle lineCap aeApplyTo: self ].

]

{ #category : #private }
AeCanvas >> setWithInsideBorderAndBackground [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		backgroundSourceBlock value.
		cairoContext
			primClipPreserve;
			primPaintAlpha: backgroundAlpha.
		isPathSetAsClip := true.

		self
			setDoubleWidth;
			setStrokeParameters.
		cairoContext primStroke.

		]

]

{ #category : #private }
AeCanvas >> setWithInsideBorderAndNoBackground [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		self
			setDoubleWidth;
			setStrokeParameters.
		cairoContext 
			primClipPreserve;
			primStroke.
		isPathSetAsClip := true.

		]

]

{ #category : #private }
AeCanvas >> setWithOutsideBorderAndNoBackground [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		cairoContext paintGroupWith: [ 
			"Draw doubled border"
			self
				setDoubleWidth;
				setStrokeParameters.
			cairoContext primStrokePreserve.
			"Clear inside"
			cairoContext
				setOperatorClear;
				primFill ].

		 ]

]

{ #category : #private }
AeCanvas >> setWithOutsideBorderAndOpaqueBackground [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		self
			setDoubleWidth;
			setStrokeParameters.
		cairoContext primStrokePreserve.

		backgroundSourceBlock value.
		cairoContext
			primClip;
			primPaint.
		isPathSetAsClip := true.

		]

]

{ #category : #private }
AeCanvas >> setWithOutsideBorderAndTranslucentBackground [

	drawFillAndStrokeBlock := [

		self applyPathBlock.

		cairoContext paintGroupWith: [ 
			"Draw doubled border"
			self
				setDoubleWidth;
				setStrokeParameters.
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
AeCanvas >> setWithoutBorder [

	hasBackground
		ifTrue: [ self setWithoutBorderAndBackground ]
		ifFalse: [ self setWithoutBorderAndNoBackground ]
]

{ #category : #private }
AeCanvas >> setWithoutBorderAndBackground [
	
	drawFillAndStrokeBlock := [

		self applyPathBlock.
		backgroundSourceBlock value.

		cairoContext
			primClip;
			primPaintAlpha: backgroundAlpha.
		isPathSetAsClip := true.
		
		]

]

{ #category : #private }
AeCanvas >> setWithoutBorderAndNoBackground [
	
	drawFillAndStrokeBlock := [ ]

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
