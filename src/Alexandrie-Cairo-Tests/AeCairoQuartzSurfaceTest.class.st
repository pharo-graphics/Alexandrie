"
An AeCairoQuartzSurfaceTest is a test class for testing the behavior of AeCairoQuartzSurface
"
Class {
	#name : #AeCairoQuartzSurfaceTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoQuartzSurfaceTest >> testItIsNotCurrentlySupported [

	| aSurface |
	Smalltalk os isMacOSX ifFalse: [ ^ self skip ].
	
	aSurface := AeCairoQuartzSurface
						extent: 100 @ 100
						format: AeCairoSurfaceFormat rgb24.

	self assert: aSurface status isSuccess. "Confusingly: it says it was a success".
	self assert: aSurface extent equals: 0 @ 0 "But the width and height is zero."
]
