Class {
	#name : #AthensAeCairoFreetypeRenderer,
	#superclass : #Object,
	#instVars : [
		'utfConverter',
		'advance',
		'originalFont',
		'fontExtents',
		'glyphExtents',
		'canvas',
		'cairoScaledFont',
		'fontManager',
		'identityMatrix',
		'fontOptions',
		'cairoFontFace'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoFreetypeRenderer class >> on: aCanvas [

	^ self basicNew
		initializeOn: aCanvas;
		yourself
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> advance: aPoint [

	advance := aPoint
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> cairoScaledFontFor: aFont ftFace: aFreeTypeFace [

	^ AthensAeCairoBackendCache soleInstance at: aFont ifAbsentPut: [
		AeCairoScaledFont
			fontFace: aFreeTypeFace newCairoFontFace
			fontMatrix: (AeCairoMatrix newScalingBy: aFont pixelSize asPoint)
			userToDeviceMatrix: identityMatrix
			options: fontOptions ]
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> font: aFreeTypeFont [

	originalFont := aFreeTypeFont.
	cairoFontFace := fontManager
		detectFamilyName: aFreeTypeFont familyName
		slant: (aFreeTypeFont isItalic
			ifTrue: [ AeFontSlant italic ]
			ifFalse: [ AeFontSlant normal ])
		weight: (aFreeTypeFont isBold
			ifTrue: [ AeFontWeight bold ]
			ifFalse: [ AeFontWeight normal ])
		stretch: AeFontStretch normal
		ifNone: [ fontManager defaultFace ].
	cairoScaledFont := self cairoScaledFontFor: aFreeTypeFont ftFace: cairoFontFace.
	fontExtents := cairoScaledFont fontExtents
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> freetypeFontForLogicalFont: aFont [

	| slant weight stretch |
	slant := self slantForLogicalFont: aFont.
	weight := self weightForLogicalFont: aFont.
	stretch := self stretchForLogicalFont: aFont.

	aFont familyNames do: [ :eachFamilyName |
		| realFont |
		realFont := fontManager
			detectFamilyName: eachFamilyName
			slant: slant
			weight: weight
			stretch: stretch
			ifNone: [ nil ].
		realFont ifNotNil: [ ^ realFont ] ].

	^ fontManager defaultFace
]

{ #category : #private }
AthensAeCairoFreetypeRenderer >> glyphsOf: aString from: startIndex to: endIndex [

	| glyphs |
	utfConverter convert: aString from: startIndex to: endIndex.

	canvas
		setScaledFont: cairoScaledFont;
		setFontSize: originalFont pixelSize.

	glyphs := cairoScaledFont glyphArrayForUtf8Array: utfConverter buffer size: utfConverter bufferLength.

	cairoScaledFont getGlyphExtentsOf: glyphs size: glyphs size into: glyphExtents.

	^ glyphs
]

{ #category : #initialization }
AthensAeCairoFreetypeRenderer >> initializeOn: aCanvas [

	self initialize.

	canvas := aCanvas.
	glyphExtents := AeCairoTextExtents new.
	utfConverter := AeUTF8Converter new.
	fontManager := AeFontManager globalInstance.
	identityMatrix := AeCairoMatrix newIdentity.
	fontOptions := AeCairoFontOptions new
		antialias: AeCairoAntialias fast;
		hintMetrics: AeCairoHintMetrics on;
		hintStyle: AeCairoHintStyle slight;
		yourself
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> logicalFont: aFont [

	originalFont := aFont.

	cairoFontFace := self freetypeFontForLogicalFont: aFont.
	cairoScaledFont := self
		cairoScaledFontFor: aFont
		ftFace: cairoFontFace.
	fontExtents := cairoScaledFont fontExtents
]

{ #category : #rendering }
AthensAeCairoFreetypeRenderer >> renderCharacters: aString from: startIndex to: endIndex [

	| glyphs |
	glyphs := self glyphsOf: aString from: startIndex to: endIndex.
	self renderGlyphs: glyphs.

	^ glyphExtents advance
]

{ #category : #rendering }
AthensAeCairoFreetypeRenderer >> renderGlyphs: cairoGlyphs [

	cairoScaledFont lock.

	canvas
		setPathMatrix;
		setScaledFont: cairoScaledFont.
	advance = (0 @ 0) ifFalse: [ canvas cairoContext translateByX: advance x y: advance y ].
	canvas paint loadOnCairoCanvas: canvas.
	canvas cairoContext showGlyphs: cairoGlyphs.

	cairoScaledFont unlock
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> setColor: aColor [

	canvas setPaint: aColor
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> slantForLogicalFont: aFont [

	aFont isItalic ifTrue: [ ^ AeFontSlant italic ].
	^ AeFontSlant normal
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> stretchForLogicalFont: aFont [

	^ AeFontStretch normal
]

{ #category : #accessing }
AthensAeCairoFreetypeRenderer >> weightForLogicalFont: aFont [

	aFont isBold ifTrue: [ ^ AeFontWeight bold ].
	^ AeFontWeight normal
]
