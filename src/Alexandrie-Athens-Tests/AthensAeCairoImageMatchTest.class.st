"
I am an abstract test case for Athens Cairo visual regression tests.
"
Class {
	#name : #AthensAeCairoImageMatchTest,
	#superclass : #AeImageMatchTest,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #testing }
AthensAeCairoImageMatchTest class >> isAbstract [

	^ self == AthensAeCairoImageMatchTest
]

{ #category : #accessing }
AthensAeCairoImageMatchTest >> actual [
	"Build and answer an AeCairoImageSurface that corresponds to current imageSelector parameter."

	^ (self imageBehavior perform: imageSelector) cairoSurface
]
