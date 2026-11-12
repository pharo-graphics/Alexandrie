"
I render StrikeFont instances onto an AthensAeCairoCanvas using the Cairo toy text API.
"
Class {
	#name : #AthensAeCairoStrikeFontRenderer,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'font',
		'advance',
		'textExtents'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoStrikeFontRenderer class >> on: aCanvas [

	^ self basicNew
		initializeOn: aCanvas;
		yourself
]

{ #category : #'instance creation' }
AthensAeCairoStrikeFontRenderer class >> on: aCanvas forFont: aFont [

	^ (self on: aCanvas)
		font: aFont;
		yourself
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> advance [

	^ advance
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> advance: aPoint [

	advance := aPoint
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> canvas: aCanvas [

	canvas := aCanvas
]

{ #category : #private }
AthensAeCairoStrikeFontRenderer >> familyNameForDescription: aFontDescription [

	| family |
	family := aFontDescription fontFamily.
	(family beginsWith: 'Bitmap ') ifTrue: [ ^ family copyFrom: 8 to: family size ].
	^ family
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> font [

	^ font
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> font: aFont [

	font := aFont
]

{ #category : #initialization }
AthensAeCairoStrikeFontRenderer >> initializeOn: aCanvas [

	self initialize.
	canvas := aCanvas.
	advance := 0 @ 0.
	textExtents := AeCairoTextExtents new
]

{ #category : #rendering }
AthensAeCairoStrikeFontRenderer >> renderCharacters: aString from: startIndex to: endIndex [

	| substring fontDescription advanceDelta |
	aString isEmpty ifTrue: [ ^ 0 @ 0 ].
	substring := aString copyFrom: startIndex to: endIndex.
	fontDescription := font asAthensFontDescription.
	canvas cairoContext
		selectFont: (self familyNameForDescription: fontDescription)
		slant: (self slantForDescription: fontDescription)
		weight: (self weightForDescription: fontDescription);
		fontSize: fontDescription fontSize.
	canvas setPathMatrix.
	advance = (0 @ 0) ifFalse: [ canvas cairoContext translateByX: advance x y: advance y ].
	canvas paint loadOnCairoCanvas: canvas.
	canvas cairoContext showText: substring utf8Encoded.
	canvas cairoContext getTextExtentsOf: substring utf8Encoded into: textExtents.
	advanceDelta := textExtents advance.
	advanceDelta x = 0 ifTrue: [ advanceDelta := (font widthOfString: substring) @ 0 ].

	^ advanceDelta
]

{ #category : #accessing }
AthensAeCairoStrikeFontRenderer >> setColor: aColor [

	canvas setPaint: aColor
]

{ #category : #private }
AthensAeCairoStrikeFontRenderer >> slantForDescription: aFontDescription [

	^ aFontDescription fontSlant == #italic
		ifTrue: [ AeCairoFontSlant italic ]
		ifFalse: [ AeCairoFontSlant normal ]
]

{ #category : #private }
AthensAeCairoStrikeFontRenderer >> weightForDescription: aFontDescription [

	^ aFontDescription fontWeight == #bold
		ifTrue: [ AeCairoFontWeight bold ]
		ifFalse: [ AeCairoFontWeight normal ]
]
