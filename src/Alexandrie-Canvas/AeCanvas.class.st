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
It depends on the argument sent to `shouldClipAfterDrawingFigure:`.

See my test suite for some examples, and 'Bloc-Alexandrie' package.
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
		'pathBlock',
		'cairoContext',
		'fontOptions',
		'identityMatrix',
		'textExtents',
		'borderBlock',
		'figureBlock',
		'hasJoins',
		'hasCaps',
		'scaledFontCache',
		'dashesCache',
		'shouldClipAfterDrawingFigure'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #'instance creation' }
AeCanvas class >> extent: aPoint [

	^ self newFor: (AeCairoImageSurface extent: aPoint)
]

{ #category : #'instance creation' }
AeCanvas class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
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
AeCanvas >> clear: aColor [
	"Clear the surface with a color."

	cairoContext
		clearR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #API }
AeCanvas >> clearTransparent [
	"Clear the surface with transparent color."

	cairoContext clearTransparent
]

{ #category : #API }
AeCanvas >> drawClosedCurvedPathWith: aUnaryBlock [
	"Establish how to draw the path of the figure.
	The block closure receives an instance of AeCairoContext to build the geometric
	path. It is expected to utilize the path drawing API (bindings of
	https://www.cairographics.org/manual/cairo-Paths.html)"

	self
		setPathKey: self
		hasJoins: false
		hasCaps: false
		block: aUnaryBlock
]

{ #category : #API }
AeCanvas >> drawClosedPathWith: aUnaryBlock [
	"Establish how to draw the path of the figure.
	The block closure receives an instance of AeCairoContext to build the geometric
	path. It is expected to utilize the path drawing API (bindings of
	https://www.cairographics.org/manual/cairo-Paths.html)"

	self
		setPathKey: self
		hasJoins: true
		hasCaps: false
		block: aUnaryBlock
]

{ #category : #API }
AeCanvas >> drawFigure [

	figureBlock value
]

{ #category : #API }
AeCanvas >> drawOpenPathWith: aUnaryBlock [
	"Establish how to draw the path of the figure.
	The block closure receives an instance of AeCairoContext to build the geometric
	path. It is expected to utilize the path drawing API (bindings of
	https://www.cairographics.org/manual/cairo-Paths.html)"

	self
		setPathKey: self
		hasJoins: true
		hasCaps: true
		block: aUnaryBlock
]

{ #category : #text }
AeCanvas >> drawText: aeGlyphArray font: aScaledFont [

	cairoContext
		scaledFont: aScaledFont;
		showGlyphs: aeGlyphArray size: aeGlyphArray size
]

{ #category : #accessing }
AeCanvas >> extent [

	^ cairoSurface extent
]

{ #category : #rendering }
AeCanvas >> flush [

	cairoSurface flush
]

{ #category : #initialization }
AeCanvas >> initializeCaches [

	shouldClipAfterDrawingFigure := false.
	identityMatrix := AeCairoMatrix newIdentity.
	textExtents := AeCairoTextExtents new.

	scaledFontCache := Dictionary new.

	dashesCache := LRUCache new
		maximumWeight: 400;
		factory: [ :anArray |
			| buf |
			buf := ByteArray new: 8 * anArray size.
			anArray withIndexDo: [ :len :i |
				buf doubleAt: (i-1) * 8 + 1 put: len asFloat ].
			buf ];
		yourself.

	formToCairoSurfaceCache := LRUCache new
		maximumWeight: 400;
		factory: [ :form | AeCairoImageSurface fromForm: form ];
		yourself.

]

{ #category : #initialization }
AeCanvas >> initializeWith: aeCairoSurface [

	self initialize.

	cairoSurface := aeCairoSurface.
	cairoContext := cairoSurface newContext.

	self initializeCaches.

	self setHighQualityOptions.

]

{ #category : #text }
AeCanvas >> metricsFor: aCairoGlyphsArray font: aCairoScaledFont [
	"Return a AeCairoTextMetrics font metrics for the given glyphs and font"

	| textMetrics |
	textMetrics := AeCairoTextMetrics new
		ascent: aCairoScaledFont extents ascent negated;
		descent: aCairoScaledFont extents descent;
		yourself.

	self
		textExtentsFor: aCairoGlyphsArray
		scaledFont: aCairoScaledFont
		do: [ :aTextExtents | 
			textMetrics
				advanceX: aTextExtents advanceX;
				bearingX: aTextExtents bearingX;
				bearingY: aTextExtents bearingY;
				width: aTextExtents width;
				height: aTextExtents height ].

	^ textMetrics
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

	cairoContext paintGroupWith: aBlock
]

{ #category : #API }
AeCanvas >> paintGroupWith: aBlock alpha: aNumber [

	cairoContext paintGroupWith: aBlock alpha: aNumber
]

{ #category : #API }
AeCanvas >> pathScale: aPoint [

	cairoContext scaleBy: aPoint
]

{ #category : #API }
AeCanvas >> pathTransform: aeCairoMatrix [

	aeCairoMatrix isIdentity ifTrue: [ ^self ].
	cairoContext transformWith: aeCairoMatrix
]

{ #category : #API }
AeCanvas >> pathTranslate: aPoint [

	aPoint isZero ifTrue: [ ^self ].
	cairoContext translateBy: aPoint
]

{ #category : #private }
AeCanvas >> preparePath [

	pathBlock value: cairoContext
]

{ #category : #private }
AeCanvas >> prepareStrokeDoubleWidth: aBoolean [

	borderBlock value.

	aBoolean ifTrue:[ borderWidth := borderWidth * 2.0 ].	
	cairoContext lineWidth: borderWidth.

]

{ #category : #private }
AeCanvas >> prepareStrokeWithDoubledWidth [

	borderBlock value.

	cairoContext lineWidth: borderWidth * 2.0.

]

{ #category : #private }
AeCanvas >> prepareStrokeWithSingleWidth [

	borderBlock value.

	cairoContext lineWidth: borderWidth.

]

{ #category : #private }
AeCanvas >> privateAeCairoContext [

	^ cairoContext
]

{ #category : #API }
AeCanvas >> restoreContextAfter: aBlock [

	cairoContext restoreStateAfter: aBlock
]

{ #category : #private }
AeCanvas >> restoreContextIfShouldntClipAfter: aBlock [

	shouldClipAfterDrawingFigure
		ifTrue: aBlock
		ifFalse: [ self restoreContextAfter: aBlock ]

]

{ #category : #text }
AeCanvas >> scaledFontForFace: aFTFace size: pointSize [
	"Answer a AeCairoScaledFont that corresponds to the provided face and point size."

	^ scaledFontCache
		  at: {aFTFace. pointSize}
		  ifAbsentPut: [ self newScaledFontForFace: aFTFace size: pointSize ]
]

{ #category : #API }
AeCanvas >> setBackgroundOff [

	hasBackground := false.

]

{ #category : #API }
AeCanvas >> setBackgroundWith: aBlock [
	"Set the block that sets background. The alpha will be 1.0."

	hasBackground := true.
	backgroundAlpha := 1.0.
	backgroundSourceBlock := aBlock
]

{ #category : #API }
AeCanvas >> setBackgroundWith: aBlock alpha: aDouble [
	"Set the block that sets background with a given alpha.

	Note: If alpha is zero, it's faster using #setBackgroundOff."

	hasBackground := true.
	backgroundAlpha := aDouble.
	backgroundSourceBlock := aBlock
]

{ #category : #API }
AeCanvas >> setBackgroundWithForm: aForm alpha: aDouble [

	self
		setBackgroundWith: [ 
			| aCairoSurface |
			aCairoSurface := formToCairoSurfaceCache at: aForm.
			cairoContext sourceSurface: aCairoSurface x: 0.0 y: 0.0 ]
 		alpha: aDouble

]

{ #category : #API }
AeCanvas >> setBorderBlock: aBlockClosure [

	borderBlock := aBlockClosure
]

{ #category : #API }
AeCanvas >> setBorderOff [

	hasBackground
		ifTrue: [ self setFigureWithBackgroundAndNoBorder ]
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
	
	cairoContext lineCap: AeCairoCapStyle CAIRO_LINE_CAP_ROUND
]

{ #category : #API }
AeCanvas >> setCapSquare [
	
	cairoContext lineCap: AeCairoCapStyle CAIRO_LINE_CAP_SQUARE
]

{ #category : #API }
AeCanvas >> setDashes: dashArray offset: dashOffset [ 
	"Set the dashes and offset for the figure's stroke. Don't send this message to draw a figure without dashes.
	
	See https://www.cairographics.org/samples/dash/"

	cairoContext
		dash: (dashesCache at: dashArray)
		count: dashArray size
		offset: dashOffset

]

{ #category : #private }
AeCanvas >> setFigureIsNull [
	
	figureBlock := [ ]

]

{ #category : #private }
AeCanvas >> setFigureWithBackgroundAndNoBorder [
	
	figureBlock := [

		self preparePath.

		self restoreContextIfShouldntClipAfter: [

			"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clip;
				paintWithAlpha: backgroundAlpha ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderCenterAndNoBackground [

	figureBlock := [

		self preparePath.

		"Paint border, and clip if required"
		self prepareStrokeWithSingleWidth.
		shouldClipAfterDrawingFigure
			ifTrue: [
				cairoContext
					strokePreserve;
					clip ]
			ifFalse: [
				cairoContext stroke ]
		 ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderCenterAndOpaqueBackground [

	figureBlock := [

		self preparePath.

		"Need to restore clipping area to draw the border afterwards"
		self restoreContextAfter: [

			"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clipPreserve;
				paint ].
				
		"Paint border, and clip if required"
		self prepareStrokeWithSingleWidth.
		shouldClipAfterDrawingFigure
			ifTrue: [
				cairoContext
					strokePreserve;
					clip ]
			ifFalse: [
				cairoContext stroke ] ] 

]

{ #category : #private }
AeCanvas >> setFigureWithBorderCenterAndTranslucentBackground [

	figureBlock := [

		self preparePath.

		"Need to restore clipping area to draw the border afterwards"
		self restoreContextAfter: [

	 		"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clipPreserve;
				paintWithAlpha: backgroundAlpha ].

		"Paint border, and clip if required"
		self prepareStrokeWithSingleWidth.
		shouldClipAfterDrawingFigure
			ifTrue: [
				cairoContext
					strokePreserve;
					clip ]
			ifFalse: [
				cairoContext stroke ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderInsideAndNoBackground [

	figureBlock := [

		self preparePath.

		self restoreContextIfShouldntClipAfter: [

			"Paint border"
			self prepareStrokeWithDoubledWidth.
			cairoContext 
				clipPreserve;
				stroke ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderInsideAndOpaqueBackground [

	figureBlock := [

		self preparePath.

		self restoreContextIfShouldntClipAfter: [

			"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clipPreserve;
				paint.

			"Paint border"
			self prepareStrokeWithDoubledWidth.
			cairoContext stroke ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderInsideAndTranslucentBackground [

	figureBlock := [

		self preparePath.

		self restoreContextIfShouldntClipAfter: [

			"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clipPreserve;
				paintWithAlpha: backgroundAlpha.

			"Paint border"
			self prepareStrokeWithDoubledWidth.
			cairoContext stroke ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndNoBackground [

	figureBlock := [

		self preparePath.

		self paintGroupWith: [ 
			
			"Paint border with double width"
			self prepareStrokeWithDoubledWidth.
			cairoContext strokePreserve.
			
			"Clear the inner half of the border.
			Needs to be done inside a group to do not erase the target surface.
			The changed operator will be restored when the group is poped."
			cairoContext setOperatorClear.
			shouldClipAfterDrawingFigure
				ifTrue: [ cairoContext fillPreserve ]
				ifFalse: [ cairoContext fill ] ].
		
		"Clip if required.
		Needs to be doen after poping the group (above)."
		shouldClipAfterDrawingFigure
			ifTrue: [ cairoContext clip ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndOpaqueBackground [

	figureBlock := [

		self preparePath.

		self restoreContextIfShouldntClipAfter: [ 

			"Paint border"
			self prepareStrokeWithDoubledWidth.
			cairoContext strokePreserve.

			"Paint background"
			backgroundSourceBlock value.
			cairoContext
				clip;
				paint ] ]

]

{ #category : #private }
AeCanvas >> setFigureWithBorderOutsideAndTranslucentBackground [

	figureBlock := [

		self preparePath.

		self paintGroupWith: [
			
			"Paint border with double width"
			self prepareStrokeWithDoubledWidth.
			cairoContext strokePreserve.

			"Clear the inner half of the border"
			self restoreContextAfter: [ 
				cairoContext
					setOperatorClear;
					fillPreserve ] ].
		
		"Paint background"
		self restoreContextIfShouldntClipAfter: [
			backgroundSourceBlock value.
			cairoContext
				clip;
				paintWithAlpha: backgroundAlpha ] ]

]

{ #category : #initialization }
AeCanvas >> setHighQualityOptions [

	| antialiasOption |
	antialiasOption := AeCairoAntialias CAIRO_ANTIALIAS_FAST.

	cairoContext
		tolerance: 0.2;
		antialias: antialiasOption.

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

	cairoContext lineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_BEVEL
]

{ #category : #API }
AeCanvas >> setJoinMiter: limit [
	
	"No need to set miter join as it's the default in Cairo"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-join"
	
	"But we might need to set the miter limit if it's not the default"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-miter-limit"
	limit = 10.0 ifFalse: [ 
		cairoContext miterLimit: limit ]

]

{ #category : #API }
AeCanvas >> setJoinRound [

	cairoContext lineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_ROUND
]

{ #category : #API }
AeCanvas >> setLineCapBlock: aFullBlockClosure [ 
	"Set the block that sets the line cap, if geometry is open."
	
	hasCaps ifTrue: aFullBlockClosure
]

{ #category : #API }
AeCanvas >> setLineJoinBlock: aFullBlockClosure [ 
	"Set the block that will be valued if geometry has joins."
	
	hasJoins ifTrue: aFullBlockClosure
]

{ #category : #initialization }
AeCanvas >> setLowQualityOptions [

	cairoContext
		tolerance: 0.5;
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_NONE.

	fontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias CAIRO_ANTIALIAS_FAST;
		hintMetrics: AeCairoHintMetrics CAIRO_HINT_METRICS_OFF;
		hintStyle: AeCairoHintStyle CAIRO_HINT_STYLE_NONE;
		subpixelOrder: AeCairoSubpixelOrder CAIRO_SUBPIXEL_ORDER_DEFAULT;
		yourself

]

{ #category : #API }
AeCanvas >> setOutskirtsCentered [

	hasBackground
		ifTrue: [
			backgroundAlpha = 1.0
				ifTrue: [ self setFigureWithBorderCenterAndOpaqueBackground ]
				ifFalse: [ self setFigureWithBorderCenterAndTranslucentBackground ] ]
		ifFalse: [
			self setFigureWithBorderCenterAndNoBackground ]

]

{ #category : #API }
AeCanvas >> setOutskirtsInside [

	hasBackground
		ifTrue: [
			backgroundAlpha = 1.0
				ifTrue: [ self setFigureWithBorderInsideAndOpaqueBackground ]
				ifFalse: [ self setFigureWithBorderInsideAndTranslucentBackground ] ]
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
	
	The block closure receives an instance of AeCairoContext to build the geometric
	path. The block must only send messages in the 'API - path' protocol of AeCairoContext.
	This is, only the bindings of: https://www.cairographics.org/manual/cairo-Paths.html"

	hasJoins := hasJoinsBoolean.
	hasCaps := hasCapsBoolean.
	pathBlock := aUnaryBlock
]

{ #category : #private }
AeCanvas >> setSourceColor: aColor [

	"TODO: The default source pattern is opaque black, (that is, it is equivalent to cairo_set_source_rgba(cr, 0.0, 0.0, 0.0, 1.0))."

	aColor isTranslucent
		ifTrue: [ self setSourceTranslucentColor: aColor ]
		ifFalse: [ self setSourceSolidColor: aColor ]
]

{ #category : #API }
AeCanvas >> setSourceLinearPatternStops: aCollection start: startPoint end: endPoint [
	
	| aPattern |
	aPattern := AeCairoLinearGradientPattern from: startPoint to: endPoint.
	aCollection do: [ :each |
		aPattern addStopAt: each key color: each value ].
	
	cairoContext source: aPattern.
]

{ #category : #API }
AeCanvas >> setSourceRadialPatternStops: aCollection center: aPoint radius: aNumber [
	
	| aPattern |
	aPattern := AeCairoRadialGradientPattern
		innerCenter: aPoint
		innerRadius: 0
		outerCenter: aPoint
		outerRadius: aNumber.

	aCollection do: [ :each |
		aPattern addStopAt: each key color: each value ].
	
	cairoContext source: aPattern.
]

{ #category : #private }
AeCanvas >> setSourceSolidColor: aColor [

	cairoContext
		sourceColorR: aColor red
		g: aColor green
		b: aColor blue
]

{ #category : #private }
AeCanvas >> setSourceTranslucentColor: aColor [

	cairoContext sourceColorRGBA: aColor

]

{ #category : #API }
AeCanvas >> shouldClipAfterDrawingFigure: aBoolean [

	shouldClipAfterDrawingFigure := aBoolean
]

{ #category : #text }
AeCanvas >> textExtentsFor: aeGlyphsArray scaledFont: aeScaledFont do: aUnaryBlockClosure [
	"Evaluate a block closure with an instance of AeCairoTextExtents which holds
	the metrics of the fiven glyph array and scaled font.

	Nota: Sender must assume the AeCairoTextExtents instance is valid ONLY during
	the execution of the block closure."
	
	cairoContext
		scaledFont: aeScaledFont;
		getGlyphExtentsOf: aeGlyphsArray
			size: aeGlyphsArray size
			on: textExtents.
	aUnaryBlockClosure value: textExtents
]
