Class {
	#name : #AeCairoPatternSourceConvertedTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'context'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoPatternSourceConvertedTest >> testLinearGradient [

	| aLinearGradient |
	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	aLinearGradient :=
		AeCairoLinearGradientPattern
			from: 0 @ 0
			to: 1 @ 1.
	context source: aLinearGradient.
	
	self
		assert: context sourceConverted class
		equals: AeCairoLinearGradientPattern
]

{ #category : #tests }
AeCairoPatternSourceConvertedTest >> testMesh [

	| meshPattern |
	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	meshPattern := AeCairoMeshPattern newEmpty.
	context source: meshPattern.
	
	self
		assert: context sourceConverted class
		equals: AeCairoMeshPattern
]

{ #category : #tests }
AeCairoPatternSourceConvertedTest >> testRadialGradient [

	| aRadialGradient |
	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	aRadialGradient :=
		AeCairoRadialGradientPattern 
			innerCenter: 0@0
			innerRadius: 0
			outerCenter: 1@1
			outerRadius: 1.
	context source: aRadialGradient.
	
	self
		assert: context sourceConverted class
		equals: AeCairoRadialGradientPattern
]

{ #category : #tests }
AeCairoPatternSourceConvertedTest >> testSolid [

	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	self
		assert: context sourceConverted class
		equals: AeCairoColorPattern
]

{ #category : #tests }
AeCairoPatternSourceConvertedTest >> testSurface [

	| tmpSurface |
	surface := AeCairoImageSurface extent: 100 @ 100.
	context := surface newContext.
	
	tmpSurface := AeCairoImageSurface extent: 100 @ 100.
	context sourceSurface: tmpSurface x: 0 y: 0.
	
	self
		assert: context sourceConverted class
		equals: AeCairoSurfacePattern.

]
