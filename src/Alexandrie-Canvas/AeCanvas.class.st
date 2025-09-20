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

# Background Forms & caching

The canvas receives Forms as arguments to `setBackgroundWithForm*` API, and converts those Forms to Cairo surfaces.
Such conversion is a linear algorithm that can be time consuming, and we assume such Forms don't change often.
That's the reason for the canvas to cache. The downside is that an update in a Form would require to manually reset the caches.
This can be done via `resetFormCaches`.
"
Class {
	#name : #AeCanvas,
	#superclass : #Object,
	#instVars : [
		'hasBackground',
		'borderWidth',
		'formToCairoSurfaceCache',
		'formSetToCairoSurfaceCache',
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
		'borderPathBlock',
		'clipAfterwards',
		'clippingRectangle',
		'deviceScaleMatrix'
	],
	#classVars : [
		'HighQualityFontOptions',
		'LowQualityFontOptions'
	],
	#category : #'Alexandrie-Canvas-Base'
}

{ #category : #'instance creation' }
AeCanvas class >> extent: aPoint [

	^ self newFor: (AeCairoImageSurface extent: aPoint)
]

{ #category : #'class initialization' }
AeCanvas class >> initialize [

	SessionManager default registerUserClassNamed: self name.

	self initializeFontOptions
]

{ #category : #initialization }
AeCanvas class >> initializeFontOptions [

	LowQualityFontOptions :=
		AeCairoFontOptions new
			antialias: AeCairoAntialias fast;
			hintMetrics: AeCairoHintMetrics off;
			hintStyle: AeCairoHintStyle none;
			subpixelOrder: AeCairoSubpixelOrder default;
			yourself.

	HighQualityFontOptions :=
		AeCairoFontOptions new
			antialias: AeCairoAntialias fast;
			hintMetrics: AeCairoHintMetrics on;
			hintStyle: AeCairoHintStyle slight;
			subpixelOrder: AeCairoSubpixelOrder default;
			yourself
]

{ #category : #'instance creation' }
AeCanvas class >> newFor: aeCairoSurface [

	^ self new
		prepareForSurface: aeCairoSurface;
		yourself
]

{ #category : #'instance creation' }
AeCanvas class >> newWithoutSurface [
	"Answer a new canvas without surface, it should not be used before sending #prepareForSurface:"
	
	^ self new
]

{ #category : #'system startup' }
AeCanvas class >> startUp: isImageStarting [

	isImageStarting ifTrue: [ self initializeFontOptions ]
]

{ #category : #'API - text' }
AeCanvas >> appendGlyphsPath: aeGlyphArray font: aScaledFont [

	cairoContext
		scaledFont: aScaledFont;
		appendGlyphsPath: aeGlyphArray
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

	cairoContext clearColor: aColor
]

{ #category : #'API - painting' }
AeCanvas >> clearTransparent [
	"Clear the surface with transparent color."

	cairoContext clearTransparent
]

{ #category : #accessing }
AeCanvas >> clippingRectangle [

	^ clippingRectangle ifNil: [
		clippingRectangle := 0@0 extent: (cairoSurface extent / cairoSurface deviceScale) ]
]

{ #category : #accessing }
AeCanvas >> clippingRectangle: aRectangle [

	clippingRectangle := aRectangle
]

{ #category : #accessing }
AeCanvas >> deviceScale [

	^ cairoSurface deviceScale
]

{ #category : #'API - draw' }
AeCanvas >> drawFigure [

	self drawFigureAndPrepareToClip: false
]

{ #category : #'API - draw' }
AeCanvas >> drawFigureAndPrepareToClip [

	clipAfterwards := true.
	figureBlock value
]

{ #category : #'API - draw' }
AeCanvas >> drawFigureAndPrepareToClip: aBoolean [

	clipAfterwards := aBoolean.
	figureBlock value
]

{ #category : #private }
AeCanvas >> drawFigureWithBackgroundAndNoBorder [
	
	self preparePath.
	backgroundSourceBlock value.
	self fillAndClipAfterwardsIfRequired
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderCenterAndBackground [

	self preparePath.

	"Draw background"
	backgroundSourceBlock value.
	(backgroundAlpha < 1.0)
		ifTrue: [
			"Need to restore clipping area to draw the border afterwards"
			self restoreContextAfter: [
				self fillViaClipPreservingPath ] ]
		ifFalse: [ cairoContext fillPreservingPath ].

	"Draw border, and clip afterwards if required"
	self prepareStrokeWithSingleWidth.
	clipAfterwards
		ifTrue: [ cairoContext strokePreservingPath; clip ]
		ifFalse: [ cairoContext stroke ]
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderCenterAndNoBackground [

	self preparePath.

	"Draw border and clip (if required)"
	self prepareStrokeWithSingleWidth.
	clipAfterwards
		ifTrue: [ cairoContext strokePreservingPath; clip ]
		ifFalse: [ cairoContext stroke ]
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderInsideAndBackground [

	self preparePath.

	self restoreContextOnlyIfClipAfterwards: [
		"Draw background"
		backgroundSourceBlock value.
		self fillViaClipPreservingPath.

		"Draw border"
		self prepareStrokeWithDoubledWidth.
		cairoContext stroke ]
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderInsideAndNoBackground [

	self preparePath.

	self restoreContextOnlyIfClipAfterwards: [
		"Draw border"
		self prepareStrokeWithDoubledWidth.
		cairoContext clipPreservingPath; stroke ]
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndNoBackground [

	self preparePath.

	"Draw border.
	The stroke is draw as centered and with double width,
	BUT inner half will be cleared afterwards. This needs to be
	done inside a group to do not clear the target surface.
	Note: The clear operator affects only the group."
	cairoContext paintGroupWith: [
		self prepareStrokeWithDoubledWidth.
		cairoContext
			strokePreservingPath;
			setOperatorClear;
			fillPreservingPath: clipAfterwards ].
	
	"Clip if required.
	Needs to be done after poping the group (above)."
	clipAfterwards ifTrue: [ cairoContext clip ]
]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndOpaqueBackground [

	self preparePath.

	"Draw border"
	self prepareStrokeWithDoubledWidth.
	cairoContext strokePreservingPath.

	"Draw background. As it is opaque, it overlaps
	the inner half of the double-sized border, emulating
	the outside outskirts."
	backgroundSourceBlock value.
	clipAfterwards
		ifTrue: [ cairoContext clip; paint ]
		ifFalse: [ cairoContext fill ]

]

{ #category : #private }
AeCanvas >> drawFigureWithBorderOutsideAndTranslucentBackground [

	self preparePath.

	"Draw border.
	The stroke is draw as centered and with double width,
	BUT inner half will be cleared afterwards. This needs to be
	done inside a group to do not clear the target surface.
	Note: The clear operator affects only the group."
	cairoContext paintGroupWith: [
		self prepareStrokeWithDoubledWidth.
		cairoContext
			strokePreservingPath;
			setOperatorClear;
			fillPreservingPath ].
	
	"Draw background"
	backgroundSourceBlock value.
	self restoreContextOnlyIfClipAfterwards: [
		cairoContext clip; paintWithAlpha: backgroundAlpha ]
]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderInsideAndBackground [

	"Draw background"
	self preparePath.
	backgroundSourceBlock value.
	self fillAndClipAfterwardsIfRequired.

	"Draw border. 
	As it's outskirts inside, then:
	- no problem with current clip as it fits inside
	- it needs to be done after (over) the background"
	self prepareStrokeWithSingleWidth.
	self prepareBorderPath.
	cairoContext stroke

]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderInsideAndNoBackground [

	"Draw border"
	self prepareBorderPath.
	self prepareStrokeWithSingleWidth.
	cairoContext stroke.

	"Clip is done over the default border"
	clipAfterwards ifFalse: [ ^ self ].
	self preparePath.
	cairoContext clip
]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderOutsideAndBackground [

	"Draw border"
	self prepareBorderPath.
	self prepareStrokeWithSingleWidth.
	cairoContext stroke.

	"Draw background. Do it after border because:
	- the border is outside then it shouldn't overlap with background
	- if we'd do it before border, same clip could need to be set twice (less efficient)"
	self preparePath.
	backgroundSourceBlock value.
	self fillAndClipAfterwardsIfRequired
]

{ #category : #private }
AeCanvas >> drawFigureWithExplicitBorderOutsideAndNoBackground [

	"Paint border"
	self prepareBorderPath.
	self prepareStrokeWithSingleWidth.
	cairoContext stroke.

	clipAfterwards ifFalse: [ ^self ].

	"We are responsible of updating the clipping area. 
	The path to use in this case if the default one
	(not the explicit border path)."
	self preparePath.
	cairoContext clip
]

{ #category : #'API - text' }
AeCanvas >> drawGlyphs: aeGlyphArray font: aScaledFont [

	cairoContext
		scaledFont: aScaledFont;
		showGlyphs: aeGlyphArray
]

{ #category : #private }
AeCanvas >> drawNothingButMayClip [

	clipAfterwards ifFalse: [ ^ self ].

	self preparePath.
	cairoContext clip
]

{ #category : #accessing }
AeCanvas >> extent [

	^ cairoSurface extent
]

{ #category : #private }
AeCanvas >> fillAndClipAfterwardsIfRequired [

	clipAfterwards ifTrue: [ ^ self fillViaClip ].

	backgroundAlpha < 1.0 ifTrue: [
		^ self restoreContextAfter: [ self fillViaClip ] ].

	cairoContext fill
]

{ #category : #private }
AeCanvas >> fillViaClip [

	cairoContext clip.
	backgroundAlpha < 1.0
		ifTrue: [ cairoContext paintWithAlpha: backgroundAlpha ]
		ifFalse: [ cairoContext paint ]
]

{ #category : #private }
AeCanvas >> fillViaClipPreservingPath [

	cairoContext clipPreservingPath.
	backgroundAlpha < 1.0
		ifTrue: [ cairoContext paintWithAlpha: backgroundAlpha ]
		ifFalse: [ cairoContext paint ]
]

{ #category : #'API - state' }
AeCanvas >> finish [

	cairoSurface finish
]

{ #category : #'API - state' }
AeCanvas >> flush [

	cairoSurface flush
]

{ #category : #'API - text' }
AeCanvas >> fontForFamily: familyName size: fontSize slant: slant weight: weight stretch: stretch [

	| aCairoFontFace fontSizeMatrix |
	aCairoFontFace := AeFontManager globalInstance
		detectFamilyName:familyName
		slant: slant
		weight: weight
		stretch: stretch 
		ifNone: [ AeFontManager globalInstance defaultFace ].

	fontSizeMatrix := AeCairoMatrix newScalingByX: fontSize y: fontSize.
	
	^ aCairoFontFace
		newScaledFontWithFontMatrix: fontSizeMatrix
		userToDeviceMatrix: deviceScaleMatrix
		options: fontOptions
]

{ #category : #initialization }
AeCanvas >> initialize [

	super initialize.

	self initializeCaches
]

{ #category : #initialization }
AeCanvas >> initializeCaches [

	textExtents := AeCairoTextExtents new.

	dashesCache := LRUCache new
		maximumWeight: 400;
		factory: [ :anArray | AeFFIDoubleArray newFrom: anArray ];
		yourself.

	formToCairoSurfaceCache := LRUCache new
		maximumWeight: 400;
		factory: [ :form | AeCairoImageSurface fromForm: form ];
		yourself.

	formSetToCairoSurfaceCache := LRUCache new
		maximumWeight: 400;
		factory: [ :formSet |
			| scale |
			scale := self deviceScale max rounded.
			(AeCairoImageSurface fromForm: (formSet asFormAtScale: scale))
				deviceScale: scale asPoint;
				yourself ];
		yourself.
]

{ #category : #testing }
AeCanvas >> isValid [
	
	^ cairoContext isNull not
]

{ #category : #'API - painting' }
AeCanvas >> maskGroupWith: aBlockClosure [

	cairoContext maskGroupWith: aBlockClosure
]

{ #category : #'API - painting' }
AeCanvas >> maskSurface: aSurface x: surfaceX y: surfaceY color: aColor [
	"Apply a surface as a mask, previously setting a color as source. Note: Context state is not restored."

	cairoContext
		sourceColor: aColor;
		maskSurface: aSurface x: surfaceX y: surfaceY
]

{ #category : #'API - text' }
AeCanvas >> metricsFor: aCairoGlyphsArray font: aCairoScaledFont [
	"Return a AeCairoTextMetrics font metrics for the given glyphs and font"

	| textMetrics |
	textMetrics := AeCairoTextMetrics new
		               ascent: aCairoScaledFont fontExtents ascent negated;
		               descent: aCairoScaledFont fontExtents descent;
		               yourself.

	self
		textExtentsFor: aCairoGlyphsArray
		scaledFont: aCairoScaledFont
		do: [ :aTextExtents |
			textMetrics
				advanceX: aTextExtents advanceX;
				advanceY: aTextExtents advanceY;
				bearingX: aTextExtents bearingX;
				bearingY: aTextExtents bearingY;
				width: aTextExtents width;
				height: aTextExtents height ].

	^ textMetrics
]

{ #category : #'API - other' }
AeCanvas >> newCairoSurfaceExtent: aLogicalExtent [

	| aScale aSurface |
	aScale := self deviceScale.
	aSurface := AeCairoImageSurface extent: aLogicalExtent * aScale.
	aSurface deviceScale: aScale.
	^ aSurface
]

{ #category : #'API - other' }
AeCanvas >> newSurfaceWithGaussianShadow: extent width: width canvasDo: aBlock [

	| alphaSurface alphaCanvas |
	alphaSurface := cairoSurface
		newSimilarImageFormat: AeCairoSurfaceFormat a8
		width: extent x
		height: extent y.
	alphaSurface status ensureIsSuccess.

	alphaCanvas := AeCanvas newFor: alphaSurface.
	aBlock value: alphaCanvas.

	AeCairoA8FastGaussianBlurFilter new
		surface: alphaSurface;
		applyRadius: width.

	^ alphaSurface
]

{ #category : #'API - painting' }
AeCanvas >> paint: aCairoPattern alpha: opacity [
	"Paint a pattern. opacity is a Number between 0 and 1. Note: Context state is not restored."

	cairoContext sourcePattern: aCairoPattern.

	opacity < 1.0
		ifTrue: [ cairoContext paintWithAlpha: opacity ]
		ifFalse: [ cairoContext paint ]
	
]

{ #category : #'API - painting' }
AeCanvas >> paintGroupWith: aBlock [

	cairoContext paintGroupWith: aBlock
]

{ #category : #'API - painting' }
AeCanvas >> paintGroupWith: aBlock alpha: aNumber [

	cairoContext paintGroupWith: aBlock alpha: aNumber
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
AeCanvas >> pathRotateByRadians: angle [
	"Rotate by an angle, expressed in radians, about 0@0."

	cairoContext rotateByRadians: angle
]

{ #category : #'API - transformations' }
AeCanvas >> pathRotateByRadians: angle about: aPoint [
	"Rotate by an angle, expressed in radians, about aPoint."

	cairoContext rotateByRadians: angle center: aPoint
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

{ #category : #initialization }
AeCanvas >> prepareForSurface: aeCairoSurface [

	cairoSurface := aeCairoSurface.
	cairoContext := cairoSurface newContext.
	deviceScaleMatrix := cairoSurface deviceScaleMatrix.

	self setHighQualityOptions
]

{ #category : #private }
AeCanvas >> preparePath [

	pathBlock value: cairoContext
]

{ #category : #private }
AeCanvas >> preparePathAndClip [

	self preparePath.
	cairoContext clip.
]

{ #category : #private }
AeCanvas >> prepareStrokeWithDoubledWidth [

	borderBlock value.

	cairoContext strokeSize: borderWidth * 2.0.

]

{ #category : #private }
AeCanvas >> prepareStrokeWithSingleWidth [

	borderBlock value.

	cairoContext strokeSize: borderWidth.

]

{ #category : #unstable }
AeCanvas >> privateAeCairoContext [

	^ cairoContext
]

{ #category : #unstable }
AeCanvas >> privateAeCairoSurface [

	^ cairoSurface
]

{ #category : #initialization }
AeCanvas >> removeSurface [

	cairoContext ifNotNil: [ cairoContext externallyFree ].
	cairoContext := nil.
	cairoSurface := nil
]

{ #category : #initialization }
AeCanvas >> resetFormCaches [
	"Reset the caches that #setBackgroundWithForm* API use to avoid conversions. But an update in a Form may require to reset these caches."

	formToCairoSurfaceCache removeAll.
	formSetToCairoSurfaceCache removeAll
]

{ #category : #'API - state' }
AeCanvas >> restoreContextAfter: aBlock [

	cairoContext restoreStateAfter: aBlock
]

{ #category : #'API - state' }
AeCanvas >> restoreContextAfterPaintAlpha: opacity with: aBlock [
	"Evaluate a block to paint with certain opacity (a value in 0.0 to 1.0 interval).
	* When opacity is translucent (less than 1.0), then the paint operation in the block
	closure will be performed into a 'Cairo group' (a kind of temporary surface) that
	will be finally painted with such opacity.
	* When opacity is 1.0, then do it more efficiently: paint directly on the target surface,
	using Cairo save and restore to keep the Cairo context state untouched on return."

	opacity < 1.0
		ifTrue: [ self paintGroupWith: aBlock alpha: opacity ]
		ifFalse: [ self restoreContextAfter: aBlock ]
]

{ #category : #private }
AeCanvas >> restoreContextOnlyIfClipAfterwards: aBlock [

	clipAfterwards
		ifTrue: aBlock
		ifFalse: [ self restoreContextAfter: aBlock ]

]

{ #category : #'API - text' }
AeCanvas >> scaledFontForFace: aFace size: fontSize [
	"Answer a `AeCairoScaledFont` that corresponds to the provided face and point size."

 	| aCairoFontFace |
	self deprecated: 'Use the similar method that receives the AeCairoFontFace'.

	aCairoFontFace := aFace newCairoFontFace.

	cairoContext
		fontFace: aCairoFontFace;
		fontSize: fontSize;
		fontOptions: fontOptions.
	^ cairoContext scaledFont
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
			cairoContext sourceSurface: aCairoSurface ]
 		alpha: aDouble

]

{ #category : #'API - background' }
AeCanvas >> setBackgroundWithFormSet: aFormSet alpha: aDouble [

	self
		setBackgroundWith: [ 
			| aCairoSurface |
			aCairoSurface := formSetToCairoSurfaceCache at: aFormSet.
			cairoContext sourceSurface: aCairoSurface ]
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
			ifFalse: [ self drawNothingButMayClip ] ]

]

{ #category : #'API - border' }
AeCanvas >> setBorderWidth: aDouble [

	borderWidth := aDouble

]

{ #category : #'API - border' }
AeCanvas >> setCapButt [
	"Note: it's the default in Cairo.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-cap"

	cairoContext strokeCap: AeCairoStrokeCap butt
]

{ #category : #'API - border' }
AeCanvas >> setCapRound [
	
	cairoContext strokeCap: AeCairoStrokeCap round
]

{ #category : #'API - border' }
AeCanvas >> setCapSquare [
	
	cairoContext strokeCap: AeCairoStrokeCap square
]

{ #category : #'API - border' }
AeCanvas >> setDashes: dashArray offset: dashOffset [
	"Set the dashes and offset for the figure's stroke. Don't send this message to draw a figure without dashes.
	
	See https://www.cairographics.org/samples/dash/"

	cairoContext
		strokeDashPattern: (dashesCache at: dashArray)
		offset: dashOffset
]

{ #category : #initialization }
AeCanvas >> setHighQualityOptions [

	cairoContext
		tolerance: 0.2;
		antialias: AeCairoAntialias fast.

	fontOptions := HighQualityFontOptions
]

{ #category : #'API - transformations' }
AeCanvas >> setIdentityMatrix [

	cairoContext setIdentityMatrix
]

{ #category : #'API - border' }
AeCanvas >> setJoinBevel [

	cairoContext strokeJoin: AeCairoStrokeJoin bevel
]

{ #category : #'API - border' }
AeCanvas >> setJoinMiter: limit [
	
	"Hint: there may be NO need to set miter join as it's the default in Cairo"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-line-join"
	cairoContext strokeJoin: AeCairoStrokeJoin miter.
	
	"We might NOT need to set the miter limit if it's 10.0, the default"
	"https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-miter-limit"
	cairoContext strokeJoinMiterLimit: limit

]

{ #category : #'API - border' }
AeCanvas >> setJoinRound [

	cairoContext strokeJoin: AeCairoStrokeJoin round
]

{ #category : #initialization }
AeCanvas >> setLowQualityOptions [

	cairoContext
		tolerance: 0.5;
		antialias: AeCairoAntialias none.

	fontOptions := LowQualityFontOptions
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

	cairoContext sourcePattern: aPattern
]

{ #category : #'API - source' }
AeCanvas >> setSourceRadialPatternStops: aCollection innerCenter: anInnerCenter innerRadius: anInnerRadius outerCenter: anOuterCenter outerRadius: anOuterRadius [ 
	
	| aPattern |
	aPattern := AeCairoRadialGradientPattern
		innerCenter: anInnerCenter
		innerRadius: anInnerRadius
		outerCenter: anOuterCenter
		outerRadius: anOuterRadius
		addStopsFrom: aCollection.
	
	cairoContext sourcePattern: aPattern
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

	cairoContext
		sourceColorR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
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

{ #category : #'API - other' }
AeCanvas >> writePngTo: aFileReference [

	^ cairoSurface writePngTo: aFileReference
]
