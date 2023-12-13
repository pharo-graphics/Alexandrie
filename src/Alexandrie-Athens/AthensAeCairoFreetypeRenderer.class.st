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

{ #category : #initialization }
AthensAeCairoFreetypeRenderer >> advance: aPoint [

	advance := aPoint
]

{ #category : #'as yet unclassified' }
AthensAeCairoFreetypeRenderer >> cairoScaledFontFor: aFont ftFace: ftFace [

	^ AthensAeCairoBackendCache soleInstance
		at: aFont
		ifAbsentPut: [
			AeCairoScaledFont
				fontFace: (AeCairoFreetypeFontFace newForFace: ftFace)
				fontMatrix: (AeCairoMatrix newScalingBy: aFont pixelSize asPoint)
				userToDeviceMatrix: identityMatrix
				options: fontOptions ]
]

{ #category : #initialization }
AthensAeCairoFreetypeRenderer >> freetypeFontForLogicalFont: aFont [

	aFont familyNames do: [ :eachFamilyName |
		| realFont |
		self haltIf: [ aFont weightValue ~= 400 ].
		self haltIf: [ aFont slantValue ~= 0 ].
		self haltIf: [ aFont stretchValue ~= 5 ].
		
		realFont := fontManager
			detectFamilyName: eachFamilyName
			slant: AeFontSlant normal
			weight: AeFontWeight normal
			stretch: AeFontStretch normal
			ifNone: [ nil ].

		realFont ifNotNil: [ ^ realFont ] ].
	
	^ fontManager defaultFont
]

{ #category : #private }
AthensAeCairoFreetypeRenderer >> glyphsOf: aString from: start to: end [

	| glyphs |
	utfConverter convert: aString from: start to: end.

	canvas
		setScaledFont: cairoScaledFont;
		setFontSize: originalFont pixelSize.

	glyphs := cairoScaledFont
		glyphArrayForUtf8Array: utfConverter buffer
		size: utfConverter bufferLength.

	cairoScaledFont getGlyphExtentsOf: glyphs
		size: glyphs size
		into: glyphExtents.
	advance := glyphExtents width @ glyphExtents height.

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
]

{ #category : #initialization }
AthensAeCairoFreetypeRenderer >> logicalFont: aFont [

	originalFont := aFont.

	cairoFontFace := self freetypeFontForLogicalFont: aFont.
	cairoScaledFont := self
		cairoScaledFontFor: aFont
		ftFace: cairoFontFace.
	fontExtents := cairoScaledFont fontExtents
]

{ #category : #rendering }
AthensAeCairoFreetypeRenderer >> renderCharacters: aString from: start to: end [

	| glyphs |
	glyphs := self glyphsOf: aString from: start to: end.
	self renderGlyphs: glyphs.

	^ advance
]

{ #category : #rendering }
AthensAeCairoFreetypeRenderer >> renderGlyphs: cairoGlyphs [

	cairoScaledFont lock.

	canvas
		setPathMatrix;
		setScaledFont: cairoScaledFont.
	canvas paint loadOnCairoCanvas: canvas.
	canvas cairoContext showGlyphs: cairoGlyphs.

	cairoScaledFont unlock
]
