"
I test NewTools inspection on Cairo binding objects.
"
Class {
	#name : #AeCairoInspectionTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-NewTools-Tests'
}

{ #category : #tests }
AeCairoInspectionTest >> assertCanInspectImageSurfaceWithFormat: aFormat [

	| anExtent aSurface aPresenter aForm aPixelComparison |
	anExtent := 200@100.
	aSurface := AeCairoImageSurface
		  extent: anExtent
		  format: aFormat.

	aPresenter := aSurface inspectionAsForm: SpPresenter new.
	self assert: aPresenter class equals: SpMorphPresenter. 

	aForm := aPresenter morph asForm.
	aPixelComparison := AePixelComparison 
		expectedForm: aSurface asForm
		actualForm: aForm
		label: ''.
		
	self assert: aPixelComparison isMatch.
]

{ #category : #tests }
AeCairoInspectionTest >> testInspectContext [

	| aSurface aContext aPresenter aForm aPixelComparison |
	aSurface := AeCairoExamplesRenderTest new surfaceWithText.
	aContext := aSurface newContext.

	aPresenter := aContext inspectionOfSurfaceAsForm: SpPresenter new.
	self assert: aPresenter class equals: SpMorphPresenter. 

	aForm := aPresenter morph asForm.
	aPixelComparison := AePixelComparison 
		expectedForm: aSurface asForm
		actualForm: aForm
		label: ''.
		
	self assert: aPixelComparison isMatch.
]

{ #category : #tests }
AeCairoInspectionTest >> testInspectImageSurfaceA8 [

	self assertCanInspectImageSurfaceWithFormat:
		AeCairoSurfaceFormat a8
]

{ #category : #tests }
AeCairoInspectionTest >> testInspectImageSurfaceARGB32 [

	self assertCanInspectImageSurfaceWithFormat:
		AeCairoSurfaceFormat argb32
]

{ #category : #tests }
AeCairoInspectionTest >> testInspectImageSurfaceRGB24 [

	self assertCanInspectImageSurfaceWithFormat:
		AeCairoSurfaceFormat rgb24
]

{ #category : #tests }
AeCairoInspectionTest >> testInspectImageSurfaceSomeNotYetImplemented [
	"Document in a test that some formats are not supported yet."

	| anExtent aSurface |
	anExtent := 200@100.
	aSurface := AeCairoImageSurface
		  extent: anExtent
		  format: AeCairoSurfaceFormat a1.

	self
		should: [ aSurface inspectionAsForm: SpPresenter new ]
		raise: NotYetImplemented.

]

{ #category : #tests }
AeCairoInspectionTest >> testToleratesNullContext [

	| aSurface aContext aPresenter |
	aSurface := AeCairoExamplesRenderTest new surfaceWithText.
	aContext := aSurface newContext.

	aPresenter := aSurface inspectionAsForm: SpPresenter new.

	aContext externallyFree.
	aSurface externallyFree.
	aPresenter morph refreshForm.

	self assert: aPresenter morph extent equals: 0@0.

]

{ #category : #tests }
AeCairoInspectionTest >> testToleratesNullImage [

	| aSurface aPresenter |
	aSurface := AeCairoExamplesRenderTest new surfaceWithText.

	aPresenter := aSurface inspectionAsForm: SpPresenter new.

	aSurface externallyFree.
	aPresenter morph refreshForm.

	self assert: aPresenter morph extent equals: 0@0.

]
