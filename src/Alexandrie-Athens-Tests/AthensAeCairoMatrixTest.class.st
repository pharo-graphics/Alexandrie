Class {
	#name : #AthensAeCairoMatrixTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoMatrixTest >> testComponents [

	| matrix |
	matrix := AthensAeCairoMatrix new.
	matrix
		sx: 2.0;
		sy: 3.0;
		shx: 0.5;
		shy: 0.25;
		x: 10.0;
		y: 20.0.
	self assert: matrix sx equals: 2.0.
	self assert: matrix sy equals: 3.0.
	self assert: matrix shx equals: 0.5.
	self assert: matrix shy equals: 0.25.
	self assert: matrix x equals: 10.0.
	self assert: matrix y equals: 20.0
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testCopy [

	| matrix copiedMatrix |
	matrix := AthensAeCairoMatrix new.
	matrix translateX: 10 Y: 20.
	copiedMatrix := matrix copy.
	copiedMatrix translateX: 5 Y: 5.
	self assert: matrix x equals: 10.
	self assert: copiedMatrix x equals: 15
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testIdentity [

	| matrix |
	matrix := AthensAeCairoMatrix new.
	self assert: matrix isIdentity.
	matrix translateX: 10 Y: 20.
	self deny: matrix isIdentity.
	matrix loadIdentity.
	self assert: matrix isIdentity
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testInverseTransform [

	| matrix point transformed originalPoint |
	matrix := AthensAeCairoMatrix new.
	matrix translateX: 10 Y: 20.
	point := 5 @ 5.
	transformed := matrix transform: point.
	originalPoint := matrix inverseTransform: transformed.
	self assert: (originalPoint closeTo: point)
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testInverted [

	| matrix invertedMatrix point transformed originalPoint |
	matrix := AthensAeCairoMatrix new.
	matrix translateX: 10 Y: 20.
	invertedMatrix := matrix inverted.
	point := 5 @ 5.
	transformed := matrix transform: point.
	originalPoint := invertedMatrix transform: transformed.
	self assert: (originalPoint closeTo: point)
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testMultiply [

	| firstMatrix secondMatrix result point |
	firstMatrix := AthensAeCairoMatrix new.
	firstMatrix translateX: 10 Y: 0.
	secondMatrix := AthensAeCairoMatrix new.
	secondMatrix scaleBy: 2.
	firstMatrix multiplyBy: secondMatrix.
	point := 5 @ 5.
	result := firstMatrix transform: point.
	self assert: result equals: 20 @ 10
]

{ #category : #tests }
AthensAeCairoMatrixTest >> testMultiplyAffineTransform [

	| firstMatrix affineTransform result point |
	firstMatrix := AthensAeCairoMatrix new.
	firstMatrix translateX: 10 Y: 0.
	affineTransform := AthensAffineTransform new.
	affineTransform scaleBy: 2.
	firstMatrix multiplyBy: affineTransform.
	point := 5 @ 5.
	result := firstMatrix transform: point.
	self assert: result equals: 20 @ 10
]
