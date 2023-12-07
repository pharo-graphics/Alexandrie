"
An AeHbFeatureTest is a test class for testing the behavior of AeHbFeature
"
Class {
	#name : #AeHbFeatureTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Harfbuzz-Tests'
}

{ #category : #tests }
AeHbFeatureTest >> testAccessors [

	| aFeature |
	aFeature := AeHbFeature new.

	aFeature tagString: 'aalt'.
	self assert: aFeature tagString equals: 'aalt'.

	aFeature value: 3.
	self assert: aFeature value equals: 3.

	aFeature setGlobalStart.
	self assert: aFeature start equals: AeHbFeature globalStart.
	self assert: aFeature startsAtGlobalStart.

	aFeature start: 17.
	self assert: aFeature start equals: 17.
	self deny: aFeature startsAtGlobalStart.

	aFeature setGlobalEnd.
	self assert: aFeature end equals: AeHbFeature globalEnd.
	self assert: aFeature endsAtGlobalEnd.
	
	aFeature end: 23.
	self assert: aFeature end equals: 23.
	self deny: aFeature endsAtGlobalEnd.

]

{ #category : #tests }
AeHbFeatureTest >> testParseAfterInstanceCreation [

	| aFeature |
	aFeature := AeHbFeature new.
	aFeature start: 5.
	self assert: aFeature start equals: 5.
	aFeature readIntoSelf: 'liga[3]'.
	self assert: aFeature zeroBasedStart equals: 3.
	self assert: aFeature start equals: 4
]

{ #category : #tests }
AeHbFeatureTest >> testParseInstanceInArray [
	"This is the most convenient use for the Harfbuzz shaping API."

	| featuresArray aFeature |
	featuresArray := AeHbFeatureArray newOf: 3.
	featuresArray first  readIntoSelf: '+kern[1:7]'.
	featuresArray second readIntoSelf: '+smcp[5:11]'.
	featuresArray third  readIntoSelf: '-liga[:17]'.
	
	aFeature := featuresArray first.
	self assert: aFeature tagString equals: 'kern'.
	self assert: aFeature value equals: 1.
	self assert: aFeature zeroBasedStart equals: 1.
	self assert: aFeature zeroBasedEnd equals: 7.

	aFeature := featuresArray second.
	self assert: aFeature tagString equals: 'smcp'.
	self assert: aFeature value equals: 1.
	self assert: aFeature zeroBasedStart equals: 5.
	self assert: aFeature zeroBasedEnd equals: 11.

	aFeature := featuresArray third.
	self assert: aFeature tagString equals: 'liga'.
	self assert: aFeature value equals: 0.
	self assert: aFeature zeroBasedStart equals: 0.
	self assert: aFeature zeroBasedEnd equals: 17.
]

{ #category : #tests }
AeHbFeatureTest >> testParseSecondAlternativeInRange [

	| aFeature |
	aFeature := AeHbFeature readFrom: 'aalt[3:5]=2'.
	self assert: aFeature tagString equals: 'aalt'.
	self assert: aFeature value equals: 2.
	self assert: aFeature zeroBasedStart equals: 3.
	self assert: aFeature zeroBasedEnd equals: 5.
	self assert: aFeature start equals: 4.
	self assert: aFeature end equals: 6
]

{ #category : #tests }
AeHbFeatureTest >> testParseTurnFeatureOn [

	| aFeature |
	aFeature := AeHbFeature readFrom: 'kern'.
	self assert: aFeature tagString equals: 'kern'.
	self assert: aFeature value equals: 1.
	self assert: aFeature startsAtGlobalStart.
	self assert: aFeature endsAtGlobalEnd
]

{ #category : #tests }
AeHbFeatureTest >> testParseTurnFeatureOnEndingAt [

	| aFeature |
	aFeature := AeHbFeature readFrom: 'kern[:5]'.
	self assert: aFeature zeroBasedStart equals: 0.
	self assert: aFeature zeroBasedEnd equals: 5
]

{ #category : #tests }
AeHbFeatureTest >> testParseTurnFeatureOnSingleCharacter [

	| aFeature |
	aFeature := AeHbFeature readFrom: 'kern[5]'.
	self assert: aFeature zeroBasedStart equals: 5.
	self assert: aFeature zeroBasedEnd equals: 6 "end index is exclusive"
]

{ #category : #tests }
AeHbFeatureTest >> testParseTurnFeatureOnStartingAt [

	| aFeature |
	aFeature := AeHbFeature readFrom: 'kern[5:]'.
	self assert: aFeature zeroBasedStart equals: 5.
	self assert: aFeature endsAtGlobalEnd.
]
