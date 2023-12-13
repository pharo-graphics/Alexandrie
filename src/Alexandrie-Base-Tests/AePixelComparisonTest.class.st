"
An AePixelComparisonTest is a test class for testing the behavior of AePixelComparison
"
Class {
	#name : #AePixelComparisonTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Base-Tests'
}

{ #category : #tests }
AePixelComparisonTest >> testEmptyExpectedForm [
	"This happens when the pixel match tests doesn't find the file."

	| actual expected aPixelComparison |
	actual := Form extent: 10 @ 10 depth: 32.
	expected := Form extent: 0 @ 0 depth: 32.
	aPixelComparison := AePixelComparison
		expectedForm: expected
		actualForm: actual
		label: 'test'.

	self
		assert: aPixelComparison numberOfMismatchingPixels
		equals: 100.

	self
		assert: aPixelComparison mismatchingPixelRatio
		closeTo: 1.0
]

{ #category : #tests }
AePixelComparisonTest >> testIsMatch [
	
	| commonExtent actual expected aPixelComparison |
	commonExtent := 5 @ 10.
	actual := Form extent: commonExtent depth: 32.
	expected := Form extent: commonExtent depth: 32.
	actual fillWhite.
	expected fillWhite.
	aPixelComparison := AePixelComparison
		expectedForm: expected
		actualForm: actual
		label: 'test'.

	expected colorAt: 0@0 put: Color blue.
	
	self deny: aPixelComparison isMatch
]

{ #category : #tests }
AePixelComparisonTest >> testMismatchingPixelRatio [
	
	| commonExtent actual expected aPixelComparison |
	commonExtent := 10 @ 10.
	actual := Form extent: commonExtent depth: 32.
	expected := Form extent: commonExtent depth: 32.
	actual fillWhite.
	expected fillWhite.
	aPixelComparison := AePixelComparison
		expectedForm: expected
		actualForm: actual
		label: 'test'.

	expected colorAt: 1@2 put: Color blue.
	actual colorAt: 3@4 put: Color red.
	
	self
		assert: aPixelComparison mismatchingPixelRatio
		closeTo: 0.02
]

{ #category : #tests }
AePixelComparisonTest >> testMismatchingPixels [
	
	| commonExtent actual expected aPixelComparison |
	commonExtent := 5 @ 10.
	actual := Form extent: commonExtent depth: 32.
	expected := Form extent: commonExtent depth: 32.
	actual fillWhite.
	expected fillWhite.	
	aPixelComparison := AePixelComparison
		expectedForm: expected
		actualForm: actual
		label: 'test'.

	expected colorAt: 1@2 put: Color blue.
	expected colorAt: 3@4 put: Color green.
	
	self
		assert: aPixelComparison mismatchingPixels
		equals: {
			{ 1@2. Color white. Color blue }.
			{ 3@4. Color white. Color green } }
]

{ #category : #tests }
AePixelComparisonTest >> testNumberOfMismatchingPixels [
	
	| commonExtent actual expected aPixelComparison |
	commonExtent := 5 @ 10.
	actual := Form extent: commonExtent depth: 32.
	expected := Form extent: commonExtent depth: 32.
	aPixelComparison := AePixelComparison
		expectedForm: expected
		actualForm: actual
		label: 'test'.

	actual colorAt: 1@2 put: Color blue.
	expected colorAt: 3@4 put: Color green.
	
	self
		assert: aPixelComparison numberOfMismatchingPixels
		equals: 2
]
