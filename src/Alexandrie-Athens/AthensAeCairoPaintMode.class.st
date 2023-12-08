Class {
	#name : #AthensAeCairoPaintMode,
	#superclass : #AthensPaintMode,
	#instVars : [
		'cairoContext'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoPaintMode class >> on: aCairoContext [

	^ self basicNew
		initializeOn: aCairoContext;
		yourself
]

{ #category : #initialization }
AthensAeCairoPaintMode >> initializeOn: aCairoContext [

	self initialize.
	
	cairoContext := aCairoContext
]

{ #category : #modes }
AthensAeCairoPaintMode >> over [

	cairoContext operator: AeCairoOperator over
]

{ #category : #convenience }
AthensAeCairoPaintMode >> restoreAfter: aBlock [

	| anOperator |
	anOperator := cairoContext operator.
	aBlock ensure: [
		cairoContext operator: anOperator ]
]

{ #category : #modes }
AthensAeCairoPaintMode >> source [

	cairoContext operator: AeCairoOperator source
]
