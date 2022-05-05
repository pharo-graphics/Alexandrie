"
An AeCairoMatrixTest is a test class for testing the behavior of AeCairoMatrix
"
Class {
	#name : #AeCairoMatrixTest,
	#superclass : #TestCase,
	#instVars : [
		'matrix'
	],
	#category : #'Alexandrie-FFI-Tests'
}

{ #category : #tests }
AeCairoMatrixTest >> testCreation [ 

	matrix := AeCairoMatrix x: 0 y: 0 sx: 1 sy: 1 shx: 0 shy: 0.

	self assert: matrix isIdentity.
	
	matrix := AeCairoMatrix x: 0.1 y: 0 sx: 1 sy: 1 shx: 0 shy: 0.
	
	self deny: matrix isIdentity.

]

{ #category : #tests }
AeCairoMatrixTest >> testIsIdentity [

	matrix := AeCairoMatrix new loadIdentity; yourself.
	
	self assert: matrix isIdentity.
	
	matrix scaleBy: 2 @ 1.
	
	self deny: matrix isIdentity.

]
