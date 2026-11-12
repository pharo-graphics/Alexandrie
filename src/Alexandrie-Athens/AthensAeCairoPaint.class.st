Class {
	#name : #AthensAeCairoPaint,
	#superclass : #AthensPaint,
	#instVars : [
		'cairoPattern'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoPaint class >> on: aCairoPattern [

	^ self basicNew
		initializeOn: aCairoPattern;
		yourself
]

{ #category : #rendering }
AthensAeCairoPaint >> athensFillPath: anAthensPath on: aCanvas [

	aCanvas
		newPath;
		loadPath: anAthensPath.
	aCanvas paintTransform loadInvertedOnPattern: cairoPattern.
	self loadOnCairoCanvas: aCanvas.
	aCanvas fill
]

{ #category : #rendering }
AthensAeCairoPaint >> athensFillRectangle: aRectangle on: aCanvas [

	aCanvas rectangle: aRectangle.
	aCanvas paintTransform loadInvertedOnPattern: cairoPattern.
	self loadOnCairoCanvas: aCanvas.
	aCanvas fill
]

{ #category : #accessing }
AthensAeCairoPaint >> cairoPattern [

	^ cairoPattern
]

{ #category : #initialization }
AthensAeCairoPaint >> initializeOn: aCairoPattern [

	self initialize.
	cairoPattern := aCairoPattern
]

{ #category : #rendering }
AthensAeCairoPaint >> loadOnCairoCanvas: aCanvas [

	cairoPattern status isSuccess
		ifTrue: [
			aCanvas cairoContext sourcePattern: cairoPattern ]
		ifFalse: [
			aCanvas
				setSourceR: 1.0
				g: 0.0
				b: 0.0
				a: 1.0 ]
]
