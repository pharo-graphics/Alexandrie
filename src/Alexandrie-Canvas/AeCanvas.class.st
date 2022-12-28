"
I am a canvas to render geometrical figures on a Cairo surface.

# Draw a figure

To draw a figure, prepare the canvas using `set*` methods in the API protocol,
using this order:

1. set up path
2. set up background
3. set up border and outskirts
4. send a variant of `drawFigure*`

Note: Background MUST be set BEFORE border.

## Special cases:

1. Outside outskirt + translucent color as background: set the alpha value as background alpha.
2. Cap round: it doesn't work well with certain geometries + an outskirt other than center.

# Nesting figures

I'm prepared to draw a tree of figures, A node's children can be either clipped or not.
It depends on the chosen variant of `drawFigure*` method.

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
		'dashesCache',
		'shouldClipAfterDrawingFigure',
		'borderPathBlock'
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

{ #category : #'API - border' }
AeCanvas >> borderPathFactory: aUnaryBlock [
	"Establish how to draw the path.
	
	The block closure receives an instance of AeCairoContext to build the geometric
	path. The block must only send messages in the 'API - path' protocol of AeCairoContext.
	This is, only the bindings of: https://www.cairographics.org/manual/cairo-Paths.html"

	borderPathBlock := aUnaryBlock
]

{ #category : #'API - painting' }
AeCanvas >> clear: aColor [
	"Clear the surface with a color."

	cairoContext
		clearR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #'API - painting' }
AeCanvas >> clearTransparent [
	"Clear the surface with transparent color."

	cairoContext clearTransparent
]

{ #category : #'API - draw' }
AeCanvas >> drawFigure [

	self drawFigureAndPrepareToClip: false
]

{ #category : #'API - draw' }
AeCanvas >> drawFigureAndPrepareToClip [

	shouldClipAfterDrawingFigure := true.
	figureBlock value
]

{ #category : #'API - draw' }
AeCanvas >> drawFigureAndPrepareToClip: aBoolean [

	shouldClipAfterDrawingFigure := aBoolean.
	figureBlock value
]

{ #category : #private }
AeCanvas >> drawFigureWithBackgroundAndNoBorder [
	
	self preparePath.

	self restoreContextIfShouldntClipAfter: [

		"Paint background"
		backgroundSourceBlock value.
		cairoContext clip.
		self paintWithBackgroundAlpha ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderCenterAndBackground [

	self preparePath.

	"Need to restore clipping area to draw the border afterwards"
	self restoreContextAfter: [

 		"Paint background"
		backgroundSourceBlock value.
		cairoContext clipPreserve.
		self paintWithBackgroundAlpha ].

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

{ #category : #private }
AeCanvas >> drawFigureWithBorderCenterAndNoBackground [

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

{ #category : #private }
AeCanvas >> drawFigureWithBorderInsideAndBackground [

	self preparePath.

	self restoreContextIfShouldntClipAfter: [

		"Paint background"
		backgroundSourceBlock value.
		cairoContext clipPreserve.
		self paintWithBackgroundAlpha.

		"Paint border"
		self prepareStrokeWithDoubledWidth.
		cairoContext stroke ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderInsideAndNoBackground [

	self preparePath.

	self restoreContextIfShouldntClipAfter: [

		"Paint border"
		self prepareStrokeWithDoubledWidth.
		cairoContext 
			clipPreserve;
			stroke ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndNoBackground [

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
		ifTrue: [ cairoContext clip ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndOpaqueBackground [

	self preparePath.

	"Paint border"
	self prepareStrokeWithDoubledWidth.
	cairoContext strokePreserve.

	"Paint background. As it is opaque, it overlaps
	the inner half of the double-sized border, emulating
	the outside outskirts."
	backgroundSourceBlock value.
	
	shouldClipAfterDrawingFigure
		ifTrue: [ cairoContext clip; paint ]
		ifFalse: [ cairoContext fill ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndTranslucentBackground [

	self preparePath.


	self paintGroupWith: [
		
		"Paint border with double width"
		self prepareStrokeWithDoubledWidth.
		cairoContext strokePreserve.

		"Clear the inner half of the double-sized
		border to emulate outside outskirts."
		cairoContext
			setOperatorClear;
			fillPreserve ].
	
	"Paint background"
	backgroundSourceBlock value.
	self restoreContextIfShouldntClipAfter: [
		cairoContext
			clip;
			paintWithAlpha: backgroundAlpha ]

]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderInsideAndBackground [

	"Paint background"
	self preparePath.
	backgroundSourceBlock value.
	self restoreContextIfShouldntClipAfter: [
		cairoContext clip.
		self paintWithBackgroundAlpha ].

	"Paint border. 
	As it's outskirts inside, then:
	- no problem with current clip as it fits inside
	- it needs to be done after (over) the background"
	self prepareStrokeWithSingleWidth.
	self prepareBorderPath.
	cairoContext stroke

]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderInsideAndNoBackground [

	"Paint border"
	self prepareStrokeWithSingleWidth.
	self prepareBorderPath.
	cairoContext stroke.

	"Clip is done over the full background"
	shouldClipAfterDrawingFigure ifTrue: [
		self preparePath.
		cairoContext clip ]

]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderOutsideAndBackground [

	"Paint border"
	self prepareStrokeWithSingleWidth.
	self prepareBorderPath.
	cairoContext stroke.

	"Paint background. Do it after border because:
	- the border is outside then it doesn't overlap with background
	- if we did it before border, same clip needs to be set twice"
	self preparePath.
	backgroundSourceBlock value.
	self restoreContextIfShouldntClipAfter: [
		cairoContext clip.
		self paintWithBackgroundAlpha ]

]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderOutsideAndNoBackground [

	"Paint border"
	self prepareStrokeWithSingleWidth.
	self prepareBorderPath.
	cairoContext stroke.

	"Clip is done over the background only,
	so do not consider the outside borded."
	shouldClipAfterDrawingFigure ifTrue: [
		self preparePath.
		cairoContext clip ]

]

{ #category : #'API - text' }
AeCanvas >> drawText: aeGlyphArray font: aScaledFont [

	cairoContext
		scaledFont: aScaledFont;
		showGlyphs: aeGlyphArray
]

{ #category : #accessing }
AeCanvas >> extent [

	^ cairoSurface extent
]

{ #category : #'API - state' }
AeCanvas >> flush [

	cairoSurface flush
]

{ #category : #initialization }
AeCanvas >> initializeCaches [

	identityMatrix := AeCairoMatrix newIdentity.
	textExtents := AeCairoTextExtents new.

	dashesCache := LRUCache new
		maximumWeight: 400;
		factory: [ :anArray | AeCairoDoubleArray newFrom: anArray ];
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

{ #category : #'API - painting' }
AeCanvas >> maskGroupWith: aBlockClosure [

	cairoContext maskGroupWith: aBlockClosure
]

{ #category : #'API - text' }
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

{ #category : #'API - painting' }
AeCanvas >> paintGroupWith: aBlock [

	cairoContext paintGroupWith: aBlock
]

{ #category : #'API - painting' }
AeCanvas >> paintGroupWith: aBlock alpha: aNumber [

	cairoContext paintGroupWith: aBlock alpha: aNumber
]

{ #category : #private }
AeCanvas >> paintWithBackgroundAlpha [

	backgroundAlpha < 1.0
		ifTrue: [ cairoContext paintWithAlpha: backgroundAlpha ]
		ifFalse: [ cairoContext paint ]
]

{ #category : #'API - background' }
AeCanvas >> pathFactory: aUnaryBlock [
	"Establish how to draw the backgroudn and the border path.
	
	The block closure receives an instance of AeCairoContext to build the geometric
	path. The block must only send messages in the 'API - path' protocol of AeCairoContext.
	This is, only the bindings of: https://www.cairographics.org/manual/cairo-Paths.html"

	pathBlock := aUnaryBlock.
	borderPathBlock := nil.
]

{ #category : #'API - transformations' }
AeCanvas >> pathScale: aPoint [

	cairoContext scaleBy: aPoint
]

{ #category : #'API - transformations' }
AeCanvas >> pathTransform: aeCairoMatrix [

	aeCairoMatrix isIdentity ifTrue: [ ^self ].
	cairoContext transformWith: aeCairoMatrix
]

{ #category : #'API - transformations' }
AeCanvas >> pathTranslate: aPoint [

	aPoint isZero ifTrue: [ ^self ].
	cairoContext translateBy: aPoint
]

{ #category : #private }
AeCanvas >> prepareBorderPath [

	borderPathBlock value: cairoContext
]

{ #category : #private }
AeCanvas >> preparePath [

	pathBlock value: cairoContext
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

{ #category : #'API - state' }
AeCanvas >> restoreContextAfter: aBlock [

	cairoContext restoreStateAfter: aBlock
]

{ #category : #private }
AeCanvas >> restoreContextIfShouldntClipAfter: aBlock [

	shouldClipAfterDrawingFigure
		ifTrue: aBlock
		ifFalse: [ self restoreContextAfter: aBlock ]

]

{ #category : #'API - text' }
AeCanvas >> scaledFontForFace: aFTFace size: pointSize [
	"Answer a `AeCairoScaledFont` that corresponds to the provided face and point size."

 	| aCairoFontFace aFontMatrix |
	aCairoFontFace := AeCairoFreetypeFontFace newForFace: aFTFace.
	aFontMatrix := AeCairoMatrix newScalingByX: pointSize y: pointSize.
	
	^ aCairoFontFace 
		newScaledFontWithFontMatrix: aFontMatrix
		userToDeviceMatrix: identityMatrix
		options: fontOptions
]

{ #category : #'API - background' }
AeCanvas >> setBackgroundOff [

	hasBackground := false.

]

{ #category : #'API - background' }
AeCanvas >> setBackgroundWith: aBlock [
	"Set the block that sets background. The alpha will be 1.0."

	hasBackground := true.
	backgroundAlpha := 1.0.
	backgroundSourceBlock := aBlock
]

{ #category : #'API - background' }
AeCanvas >> setBackgroundWith: aBlock alpha: aDouble [
	"Set the block that sets background with a given alpha.

	Note: If alpha is zero, it's faster using #setBackgroundOff."

	hasBackground := true.
	backgroundAlpha := aDouble.
	backgroundSourceBlock := aBlock
]

{ #category : #'API - background' }
AeCanvas >> setBackgroundWithForm: aForm alpha: aDouble [

	self
		setBackgroundWith: [ 
			| aCairoSurface |
			aCairoSurface := formToCairoSurfaceCache at: aForm.
			cairoContext sourceSurface: aCairoSurface x: 0.0 y: 0.0 ]
 		alpha: aDouble

]

{ #category : #'API - border' }
AeCanvas >> setBorderBlock: aBlockClosure [

	borderBlock := aBlockClosure
]

{ #category : #'API - border' }
AeCanvas >> setBorderOff [

	figureBlock := [
		hasBackground
			ifTrue: [ self drawFigureWithBackgroundAndNoBorder ]
			ifFalse: [ "Nothing to do" ] ]
]

{ #category : #'API - border' }
AeCanvas >> setBorderWidth: aDouble [

	borderWidth := aDouble

]

{ #category : #'API - border' }
AeCanvas >> setCapButt [
	"Note: it's the default in Cairo.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-cap"

	cairoContext lineCap: AeCairoCapStyle CAIRO_LINE_CAP_BUTT
]

{ #category : #'API - border' }
AeCanvas >> setCapRound [
	
	cairoContext lineCap: AeCairoCapStyle CAIRO_LINE_CAP_ROUND
]

{ #category : #'API - border' }
AeCanvas >> setCapSquare [
	
	cairoContext lineCap: AeCairoCapStyle CAIRO_LINE_CAP_SQUARE
]

{ #category : #'API - border' }
AeCanvas >> setDashes: dashArray offset: dashOffset [ 
	"Set the dashes and offset for the figure's stroke. Don't send this message to draw a figure without dashes.
	
	See https://www.cairographics.org/samples/dash/"

	cairoContext
		dash: (dashesCache at: dashArray)
		offset: dashOffset

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

{ #category : #'API - border' }
AeCanvas >> setJoinBevel [

	cairoContext lineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_BEVEL
]

{ #category : #'API - border' }
AeCanvas >> setJoinMiter: limit [
	
	"Hint: there may be NO need to set miter join as it's the default in Cairo"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-join"
	cairoContext lineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_MITER.
	
	"We might NOT need to set the miter limit if it's 10.0, the default"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-miter-limit"
	cairoContext miterLimit: limit

]

{ #category : #'API - border' }
AeCanvas >> setJoinRound [

	cairoContext lineJoin: AeCairoJoinStyle CAIRO_LINE_JOIN_ROUND
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

{ #category : #'API - border' }
AeCanvas >> setOutskirtsCentered [

	figureBlock := [
		hasBackground
			ifTrue: [ self drawFigureWithBorderCenterAndBackground ]
			ifFalse: [ self drawFigureWithBorderCenterAndNoBackground ] ]
]

{ #category : #'API - border' }
AeCanvas >> setOutskirtsInside [

	figureBlock := [
		hasBackground
			ifTrue: [ 
				borderPathBlock
					ifNil: [
						"Slow but most generic option"
						self drawFigureWithBorderInsideAndBackground ]
					ifNotNil: [ 
						"Optimized"
						self drawFigureWithExplicitBorderInsideAndBackground ] ]
			ifFalse: [
				borderPathBlock
					ifNil: [ 
						"Slow but most generic option"
						self drawFigureWithBorderInsideAndNoBackground ]
					ifNotNil: [ 
						"Optimized"
						self drawFigureWithExplicitBorderInsideAndNoBackground ]
				 ] ]

]

{ #category : #'API - border' }
AeCanvas >> setOutskirtsOutside [

	figureBlock := [
		hasBackground
			ifTrue: [
				borderPathBlock
					ifNil: [
						"Slow but most generic option"
						backgroundAlpha < 1.0
							ifTrue: [ self drawFigureWithBorderOutsideAndTranslucentBackground ]
							ifFalse: [ self drawFigureWithBorderOutsideAndOpaqueBackground ] ]
					ifNotNil: [ 
						"Optimized"
						self drawFigureWithExplicitBorderOutsideAndBackground ] ]
			ifFalse: [
				borderPathBlock
					ifNil: [ 
						"Slow but most generic option"
						self drawFigureWithBorderOutsideAndNoBackground ]
					ifNotNil: [ 
						"Optimized"
						self drawFigureWithExplicitBorderOutsideAndNoBackground ]
				 ] ]

]

{ #category : #'API - source' }
AeCanvas >> setSourceColor: aColor [
	"Note: The default source pattern is opaque black, (that is, it is equivalent to cairo_set_source_rgba(cr, 0.0, 0.0, 0.0, 1.0))."

	aColor isTranslucent
		ifTrue: [ self setSourceTranslucentColor: aColor ]
		ifFalse: [ self setSourceSolidColor: aColor ]
]

{ #category : #'API - source' }
AeCanvas >> setSourceLinearPatternStops: aCollection start: startPoint end: endPoint [

	| aPattern |
	aPattern := AeCairoLinearGradientPattern
		            from: startPoint
		            to: endPoint
		            addStopsFrom: aCollection.

	cairoContext source: aPattern
]

{ #category : #'API - source' }
AeCanvas >> setSourceRadialPatternStops: aCollection center: aPoint radius: aNumber [
	
	| aPattern |
	aPattern := AeCairoRadialGradientPattern
		innerCenter: aPoint
		innerRadius: 0
		outerCenter: aPoint
		outerRadius: aNumber
		addStopsFrom: aCollection.
	
	cairoContext source: aPattern.
]

{ #category : #'API - source' }
AeCanvas >> setSourceSolidColor: aColor [

	cairoContext
		sourceColorR: aColor red
		g: aColor green
		b: aColor blue
]

{ #category : #'API - source' }
AeCanvas >> setSourceTranslucentColor: aColor [

	cairoContext sourceColorRGBA: aColor

]

{ #category : #'API - text' }
AeCanvas >> textExtentsFor: aeGlyphsArray scaledFont: aeScaledFont do: aUnaryBlockClosure [
	"Evaluate a block closure with an instance of AeCairoTextExtents which holds
	the metrics of the fiven glyph array and scaled font.

	Nota: Sender must assume the AeCairoTextExtents instance is valid ONLY during
	the execution of the block closure."
	
	cairoContext
		scaledFont: aeScaledFont;
		getGlyphExtentsOf: aeGlyphsArray
			size: aeGlyphsArray size
			into: textExtents.
	aUnaryBlockClosure value: textExtents
]
