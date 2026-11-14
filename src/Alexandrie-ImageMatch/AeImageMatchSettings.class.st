"
I represent configuration settings and tolerances for visual regression testing using AeImageComparison.

I encapsulate:
- perPixelColorTolerance: Float in [0.0, 1.0]. Per-pixel channel delta fuzz tolerance. When positive, two pixel colors are considered matching if the difference of each channel (red, green, blue, alpha) is less than or equal to this threshold. Default is 0.0 (exact pixel match).
- mismatchesTolerance: Integer >= 0. Maximum number of mismatching pixels allowed.
- mismatchRatioTolerance: Float in [0.0, 1.0]. Maximum ratio of mismatching pixels allowed relative to the comparable pixel area.
"
Class {
	#name : #AeImageMatchSettings,
	#superclass : #Object,
	#instVars : [
		'colorTolerance',
		'maxMismatchCount',
		'maxMismatchRatio'
	],
	#category : #'Alexandrie-ImageMatch'
}

{ #category : #'instance creation' }
AeImageMatchSettings class >> colorTolerance: aColorToleranceFloat maxMismatchCount: anInteger maxMismatchRatio: aRatioFloat [

	^ self basicNew
		  initializeWithColorTolerance: aColorToleranceFloat maxMismatchCount: anInteger maxMismatchRatio: aRatioFloat;
		  yourself
]

{ #category : #'instance creation' }
AeImageMatchSettings class >> exact [

	^ self colorTolerance: 0.0 maxMismatchCount: 0 maxMismatchRatio: 0.0
]

{ #category : #accessing }
AeImageMatchSettings >> colorTolerance [

	^ colorTolerance
]

{ #category : #initialization }
AeImageMatchSettings >> initializeWithColorTolerance: aColorToleranceFloat maxMismatchCount: anInteger maxMismatchRatio: aRatioFloat [

	self initialize.
	colorTolerance := aColorToleranceFloat.
	maxMismatchCount := anInteger.
	maxMismatchRatio := aRatioFloat
]

{ #category : #testing }
AeImageMatchSettings >> isMatchFor: anAeImageComparison [

	anAeImageComparison mismatchCount isZero ifTrue: [ ^ true ].
	^ (maxMismatchCount > 0 and: [ anAeImageComparison mismatchCount <= maxMismatchCount ]) or: [
		  maxMismatchRatio > 0.0 and: [ anAeImageComparison mismatchRatio <= maxMismatchRatio ] ]
]

{ #category : #accessing }
AeImageMatchSettings >> maxMismatchCount [

	^ maxMismatchCount
]

{ #category : #accessing }
AeImageMatchSettings >> maxMismatchRatio [

	^ maxMismatchRatio
]

{ #category : #printing }
AeImageMatchSettings >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: 'colorTolerance: ';
		print: colorTolerance;
		nextPutAll: ', maxMismatchCount: ';
		print: maxMismatchCount;
		nextPutAll: ', maxMismatchRatio: ';
		print: maxMismatchRatio;
		nextPut: $)
]

{ #category : #storing }
AeImageMatchSettings >> storeOn: aStream [

	aStream
		nextPutAll: self class name;
		cr;
		tab;
		tab;
		nextPutAll: #colorTolerance asMutator;
		space;
		store: colorTolerance;
		cr;
		tab;
		tab;
		nextPutAll: #maxMismatchCount asMutator;
		space;
		store: maxMismatchCount;
		cr;
		tab;
		tab;
		nextPutAll: #maxMismatchRatio asMutator;
		space;
		store: maxMismatchRatio
]
