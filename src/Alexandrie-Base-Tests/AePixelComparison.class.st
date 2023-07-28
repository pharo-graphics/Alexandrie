"
I am a comparison between Forms that should match.

See #isMatch, my main testing method.

My NewTools inspections help humans to understand what's different between two bitmaps that should be equal.

My colaborators are two instances of Form (the expected and the actual bitmap) and a String that serves as label for the comparison.
"
Class {
	#name : #AePixelComparison,
	#superclass : #Object,
	#instVars : [
		'actualForm',
		'expectedForm',
		'label'
	],
	#category : #'Alexandrie-Base-Tests'
}

{ #category : #'instance creation' }
AePixelComparison class >> expectedForm: aForm actualForm: anotherForm label: aString [

	^ self new
		  expectedForm: aForm;
		  actualForm: anotherForm;
		  label: aString;
		  yourself
]

{ #category : #accessing }
AePixelComparison >> actualForm [

	^ actualForm
]

{ #category : #accessing }
AePixelComparison >> actualForm: aForm [

	actualForm := aForm
]

{ #category : #'accessing diff' }
AePixelComparison >> actualVsExpectedMergedDiffForm [
	
	| actualDiffForm expectedDiffForm |
	actualDiffForm := Form extent: actualForm extent depth: actualForm depth.
	expectedDiffForm := Form extent: expectedForm extent depth: expectedForm depth.
	
	self mismatchingPixelsDo: [ :currentPoint :actualColor :expectedColor |
		actualDiffForm colorAt: currentPoint put: actualColor.
		expectedDiffForm colorAt: currentPoint put: expectedColor ].
	
	^ self concatenatedForm: actualDiffForm and: expectedDiffForm
]

{ #category : #'accessing diff' }
AePixelComparison >> actualVsExpectedMergedForm [

	^ self concatenatedForm: actualForm and: expectedForm
]

{ #category : #private }
AePixelComparison >> concatenatedForm: aForm and: anotherForm [
	"Answer a Form with both forms separated by a transparent vertical 1-pixel line."

	| mergedForm |
	mergedForm := Form extent: (aForm width + anotherForm width + 1) @ (anotherForm height max: aForm height) depth: 32.
	mergedForm := mergedForm mergeWith: aForm at: 0@0.
	mergedForm := mergedForm mergeWith: anotherForm at: (aForm width + 1) @ 0.
	
	^ mergedForm

]

{ #category : #accessing }
AePixelComparison >> expectedForm [

	^ expectedForm
]

{ #category : #accessing }
AePixelComparison >> expectedForm: aForm [

	expectedForm := aForm
]

{ #category : #'accessing diff' }
AePixelComparison >> intersectionHeight [

	^ actualForm height min: expectedForm height
]

{ #category : #'accessing diff' }
AePixelComparison >> intersectionWidth [

	^ actualForm width min: expectedForm width
]

{ #category : #testing }
AePixelComparison >> isMatch [

	actualForm extent = expectedForm extent
		ifFalse: [ ^ false ].
	
	self numberOfMismatchingPixels > 0
		ifTrue: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
AePixelComparison >> label [
	
	^ label
]

{ #category : #accessing }
AePixelComparison >> label: aString [ 
	
	label := aString
]

{ #category : #'accessing diff' }
AePixelComparison >> mismatchingAverage [
	"Answer a positive number that indicates the average mismatching level."

	| sum numberOfPixels |
	sum := 0.0.
	numberOfPixels := 0.
	self mismatchingPixelsDo: [ :_ :actual :expected |
		numberOfPixels := numberOfPixels + 1.
		sum := sum + (#(red green blue alpha) sum: [ :eachAccessor |
			((expected perform: eachAccessor) -
				(actual perform: eachAccessor)) abs ]) ].
	^ sum / numberOfPixels
]

{ #category : #'accessing diff' }
AePixelComparison >> mismatchingPixelRatio [

	^ self numberOfMismatchingPixels /
		(self intersectionWidth * self intersectionHeight)
]

{ #category : #'accessing diff' }
AePixelComparison >> mismatchingPixels [
	"Answer {zeroIndexedPoint. actualColor. expectedColor } for each mismatching pixel (in the intersecting area)."

	^ Array streamContents: [ :stream |
		  self mismatchingPixelsDo: [
			  :zeroIndexedPoint
			  :actualColor
			  :expectedColor |
					stream nextPut: {
						zeroIndexedPoint.
						actualColor.
						expectedColor } ] ]
]

{ #category : #'accessing diff' }
AePixelComparison >> mismatchingPixelsDo: aBlock [
	"For each mismatching pixel (in the intersecting area), evaluate a block with the following arguments:
		* 0-indexed points Note: forms are 0-indexed
		* the actual color
		* the expected color" 
	
	0 to: self intersectionWidth - 1 do: [ :x |
		0 to: self intersectionHeight - 1 do: [ :y |

			| currentPoint actualColor expectedColor |
			currentPoint := x@y. 
			actualColor := actualForm colorAt: currentPoint.
			expectedColor := expectedForm colorAt: currentPoint.

			actualColor = expectedColor ifFalse: [
				aBlock
					cull: currentPoint
					cull: actualColor
					cull: expectedColor ] ] ]
]

{ #category : #'accessing diff' }
AePixelComparison >> numberOfMismatchingPixels [

	| count |
	count := 0.
	self mismatchingPixelsDo: [
		count := count + 1 ].
	^ count
]

{ #category : #printing }
AePixelComparison >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: label;
		space;
		nextPutAll: (self isMatch
			ifTrue: [ 'match' ]
			ifFalse: [ 'mismatch: {1}%'
				format: { (self mismatchingPixelRatio * 100) asInteger } ]);
		nextPut: $)
]
