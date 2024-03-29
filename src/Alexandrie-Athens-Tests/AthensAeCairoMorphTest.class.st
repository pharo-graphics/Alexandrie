Class {
	#name : #AthensAeCairoMorphTest,
	#superclass : #AePixelMatchTest,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #hooks }
AthensAeCairoMorphTest class >> allFormSelectors [

	^ self selectors select: [ :each | each beginsWith: 'surface' ]
]

{ #category : #convenience }
AthensAeCairoMorphTest class >> exportAll [
	<script: 'self exportAll' >

	super exportAll
]

{ #category : #convenience }
AthensAeCairoMorphTest class >> inspectAll [
	<script: 'super inspectAll'>
	
	super inspectAll
]

{ #category : #convenience }
AthensAeCairoMorphTest class >> inspectMismatches [
	<script: 'super inspectMismatches'>
	
	super inspectMismatches
]

{ #category : #hooks }
AthensAeCairoMorphTest >> expectedFormsDirectory [

	^ AeFilesystemResources testsDirectory / 'athens' / 'morphic'
]

{ #category : #private }
AthensAeCairoMorphTest >> newSurfaceForMorph: aMorph [

	| surface |
	surface := AthensAeCairoSurface extent: aMorph extent.
	surface drawDuring: [ :canvas |
		canvas pathTransform translateBy: aMorph position negated.
		aMorph drawOnAthensCanvas: canvas ].
	^ surface
]

{ #category : #tests }
AthensAeCairoMorphTest >> surface01PlainMorph [

	^ self newSurfaceForMorph:
		(Morph new
			color: Color orange;
			extent: 10 @ 20;
			yourself)
]

{ #category : #tests }
AthensAeCairoMorphTest >> surface02StringMorph [

	^ self newSurfaceForMorph: 'Hola' asStringMorph
]

{ #category : #tests }
AthensAeCairoMorphTest >> surface03EllipseMorph [

	^ self newSurfaceForMorph:
		(EllipseMorph new
			color: Color green;
			extent: 30 @ 20;
			yourself)
]
