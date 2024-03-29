"
An AeCairoMatrixTest is a test class for testing the behavior of AeCairoMatrix
"
Class {
	#name : #AeCairoMatrixTest,
	#superclass : #TestCase,
	#instVars : [
		'matrix'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoMatrixTest >> testBeMultiplicationOfBy [

	| x y |
	x := AeCairoMatrix newScalingByX: 2 y: 3.
	y := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	matrix := AeCairoMatrix new.

	matrix beMultiplicationOf: x by: y.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.6 sy: 1.2 shx: 1.5 shy: 1.2).

	matrix beMultiplicationOf: matrix by: y.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: 0.23 y: 0.34 sx: 0.78 sy: 1.38 shx: 1.05 shy: 0.84).

	matrix beMultiplicationOf: x by: matrix.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: 0.23 y: 0.34 sx: 1.56 sy: 4.14 shx: 3.15 shy: 1.68).

	matrix beMultiplicationOf: y by: x.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: 0.2 y: 0.6 sx: 0.6 sy: 1.2 shx: 1.0 shy: 1.8)
]

{ #category : #tests }
AeCairoMatrixTest >> testCopy [

	| aCopy |
	matrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	aCopy := matrix copy.

	"Check independent change"
	matrix x: 17.
	aCopy  x: 23.
	self assert: matrix x equals: 17.
	self assert: aCopy x  equals: 23.

	"Other factors match"
	self assert: matrix sx  equals: 0.3.
	self assert: matrix sy  equals: 0.4.
	self assert: matrix shx equals: 0.5.
	self assert: matrix shy equals: 0.6
]

{ #category : #tests }
AeCairoMatrixTest >> testCreation [ 

	matrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.

	"Translation factors"
	self assert: matrix x   equals: 0.1.
	self assert: matrix y   equals: 0.2.

	"Scale factors"
	self assert: matrix sx  equals: 0.3.
	self assert: matrix sy  equals: 0.4.

	"Shear factors"
	self assert: matrix shx equals: 0.5.
	self assert: matrix shy equals: 0.6.

]

{ #category : #tests }
AeCairoMatrixTest >> testInverted [

	| aMatrix invertedMatrix |
	"The inverse of identity matrix is an identity matrix, but different handle."
	aMatrix := AeCairoMatrix newIdentity.
	invertedMatrix := aMatrix inverted.
	self deny: aMatrix getHandle equals: invertedMatrix getHandle.
	self assert: invertedMatrix isIdentity.

	"Test with a non trivial matrix. Assert on String as simplification."
	aMatrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	invertedMatrix := aMatrix inverted.
	self
		assert: invertedMatrix asString
		equals: 'an AeCairoMatrix(-2.2222 3.3333 | 2.7778 -1.6667 | -0.3333 0.0000)'.

	"Not all matrices have inverse"
	self
		should: [ AeCairoMatrix new inverted ]
		raise: AeCairoStatusError
]

{ #category : #tests }
AeCairoMatrixTest >> testIsIdentity [

	matrix := AeCairoMatrix newIdentity.
	
	self assert: matrix isIdentity.
	
	matrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	
	self deny: matrix isIdentity.

]

{ #category : #tests }
AeCairoMatrixTest >> testNewFrom [

	| aCopy |
	matrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	aCopy := AeCairoMatrix newFrom: matrix.

	"Check independent change"
	matrix x: 17.
	aCopy  x: 23.
	self assert: matrix x equals: 17.
	self assert: aCopy x  equals: 23.

	"Other factors match"
	self assert: matrix sx  equals: 0.3.
	self assert: matrix sy  equals: 0.4.
	self assert: matrix shx equals: 0.5.
	self assert: matrix shy equals: 0.6
]

{ #category : #test }
AeCairoMatrixTest >> testNewRotationByRadians [

	| radians |
	radians := 45 degreesToRadians.
	matrix := AeCairoMatrix newRotationByRadians: radians.
	
	self assert: matrix x   equals: 0.
	self assert: matrix y   equals: 0.
	self assert: matrix sx  equals: radians cos.
	self assert: matrix sy  equals: radians cos.
	self assert: matrix shx equals: radians sin negated.
	self assert: matrix shy equals: radians sin.

]

{ #category : #tests }
AeCairoMatrixTest >> testNewScalingBy [

	matrix := AeCairoMatrix newScalingBy: 2@3.
	
	self assert: matrix x   equals: 0.0.
	self assert: matrix y   equals: 0.0.
	self assert: matrix sx  equals: 2.0.
	self assert: matrix sy  equals: 3.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #tests }
AeCairoMatrixTest >> testNewTranslationBy [

	matrix := AeCairoMatrix newTranslationBy: 2@3.
	
	self assert: matrix x   equals: 2.0.
	self assert: matrix y   equals: 3.0.
	self assert: matrix sx  equals: 1.0.
	self assert: matrix sy  equals: 1.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #tests }
AeCairoMatrixTest >> testPostMultiply [

	| y |
	y := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	matrix := AeCairoMatrix newRotationByRadians: 1.

	matrix postMultiply: y.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: 0.1000 y: 0.2000 sx: 0.5828 sy: -0.2888 shx: 0.0177 shy: 0.6608)
]

{ #category : #tests }
AeCairoMatrixTest >> testPreMultiply [

	| y |
	y := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	matrix := AeCairoMatrix newRotationByRadians: 1.

	matrix preMultiply: y.
	self
		assert: matrix
		closeTo: (AeCairoMatrix newX: -0.1143 y: 0.1922 sx: -0.3428 sy: 0.6369 shx: -0.0664 shy: 0.5766)
]

{ #category : #test }
AeCairoMatrixTest >> testRotateByRadians [

	| radians |
	matrix := AeCairoMatrix newIdentity.
	radians := 45 degreesToRadians.
	matrix rotateByRadians: radians.
	
	self assert: matrix x   equals: 0.
	self assert: matrix y   equals: 0.
	self assert: matrix sx  equals: radians cos.
	self assert: matrix sy  equals: radians cos.
	self assert: matrix shx equals: radians sin negated.
	self assert: matrix shy equals: radians sin.

]

{ #category : #test }
AeCairoMatrixTest >> testRotateTwice [

	| radians |
	radians := 5 degreesToRadians.
	matrix := AeCairoMatrix newRotationByRadians: radians.
	matrix rotateByRadians: radians.

	self assert: matrix x   equals: 0.
	self assert: matrix y   equals: 0.
	self assert: matrix sx 	closeTo: (2 * radians) cos.
	self assert: matrix sy  closeTo: (2 * radians) cos.
	self assert: matrix shx equals: (2 * radians) sin negated.
	self assert: matrix shy equals: (2 * radians) sin.

]

{ #category : #tests }
AeCairoMatrixTest >> testScaleBy [

	matrix := AeCairoMatrix newIdentity.
	matrix scaleBy: 2 @ 3.
	
	self assert: matrix x   equals: 0.0.
	self assert: matrix y   equals: 0.0.
	self assert: matrix sx  equals: 2.0.
	self assert: matrix sy  equals: 3.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #test }
AeCairoMatrixTest >> testScaleTwice [

	matrix := AeCairoMatrix newScalingBy: 2@3.
	matrix scaleBy: 10 @ 100.
	
	self assert: matrix x   equals: 0.0.
	self assert: matrix y   equals: 0.0.
	self assert: matrix sx  equals: 20.0.
	self assert: matrix sy  equals: 300.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #test }
AeCairoMatrixTest >> testTranslateBy [

	matrix := AeCairoMatrix newIdentity.
	matrix translateBy: 2 @ 3.
	
	self assert: matrix x   equals: 2.0.
	self assert: matrix y   equals: 3.0.
	self assert: matrix sx  equals: 1.0.
	self assert: matrix sy  equals: 1.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #test }
AeCairoMatrixTest >> testTranslateTwice [

	matrix := AeCairoMatrix newTranslationBy: 2@3.
	matrix translateBy: 10 @ 100.
	
	self assert: matrix x   equals: 12.0.
	self assert: matrix y   equals: 103.0.
	self assert: matrix sx  equals: 1.0.
	self assert: matrix sy  equals: 1.0.
	self assert: matrix shx equals: 0.0.
	self assert: matrix shy equals: 0.0.

]

{ #category : #test }
AeCairoMatrixTest >> testValue [
	"Formulas adapted from documentation.
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html"

	| input expectedX expectedY |
	matrix := AeCairoMatrix newX: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.

	input := 2@3.
	expectedX := (matrix sx * input x) + (matrix shx * input y) + matrix x.
	expectedY := (matrix sy * input y) + (matrix shy * input x) + matrix y.

	self assert: (matrix value: input) equals: expectedX @ expectedY

]
