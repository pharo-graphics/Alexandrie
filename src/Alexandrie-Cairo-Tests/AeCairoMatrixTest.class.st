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
AeCairoMatrixTest >> testCreation [ 

	matrix := AeCairoMatrix x: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.

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
AeCairoMatrixTest >> testIsIdentity [

	matrix := AeCairoMatrix newIdentity.
	
	self assert: matrix isIdentity.
	
	matrix := AeCairoMatrix x: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.
	
	self deny: matrix isIdentity.

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
AeCairoMatrixTest >> testValue [
	"Formulas adapted from documentation.
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html"

	| input expectedX expectedY |
	matrix := AeCairoMatrix x: 0.1 y: 0.2 sx: 0.3 sy: 0.4 shx: 0.5 shy: 0.6.

	input := 2@3.
	expectedX := (matrix sx * input x) + (matrix shx * input y) + matrix x.
	expectedY := (matrix sy * input y) + (matrix shy * input x) + matrix y.

	self assert: (matrix value: input) equals: expectedX @ expectedY

]
