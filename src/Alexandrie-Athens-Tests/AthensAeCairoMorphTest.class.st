Class {
	#name : #AthensAeCairoMorphTest,
	#superclass : #AeCairoRenderTest,
	#category : #'Alexandrie-Athens-Tests'
}

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
AthensAeCairoMorphTest >> surfaceWith01PlainMorph [

	^ self newSurfaceForMorph:
		(Morph new
			color: Color orange;
			extent: 10 @ 20;
			yourself)
]

{ #category : #tests }
AthensAeCairoMorphTest >> surfaceWith02StringMorph [

	^ self newSurfaceForMorph: 'Hola' asStringMorph
]

{ #category : #tests }
AthensAeCairoMorphTest >> surfaceWith03EllipseMorph [

	^ self newSurfaceForMorph:
		(EllipseMorph new
			color: Color green;
			extent: 30 @ 20;
			yourself)
]
