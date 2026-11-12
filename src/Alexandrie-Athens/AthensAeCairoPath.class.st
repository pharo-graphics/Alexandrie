Class {
	#name : #AthensAeCairoPath,
	#superclass : #AthensPath,
	#instVars : [
		'cairoPath'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoPath class >> on: aCairoPath [

	^ self basicNew
		initializeOn: aCairoPath;
		yourself
]

{ #category : #converting }
AthensAeCairoPath >> asAthensShapeOn: anAthensAeCairoCanvas [

	^ self
]

{ #category : #accessing }
AthensAeCairoPath >> cairoPath [

	^ cairoPath
]

{ #category : #initialization }
AthensAeCairoPath >> initializeOn: aCairoPath [

	self initialize.
	cairoPath := aCairoPath
]

{ #category : #drawing }
AthensAeCairoPath >> loadOnCairoCanvas: anAthensAeCairoCanvas [

	anAthensAeCairoCanvas cairoContext appendPath: cairoPath
]

{ #category : #converting }
AthensAeCairoPath >> paintFillsUsing: aPaint on: anAthensAeCairoCanvas [

	^ aPaint athensFillPath: self on: anAthensAeCairoCanvas
]
