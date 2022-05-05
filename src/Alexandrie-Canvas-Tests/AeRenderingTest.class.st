Class {
	#name : #AeRenderingTest,
	#superclass : #TestCase,
	#instVars : [
		'spaceFixture'
	],
	#category : #'Alexandrie-Canvas-Tests'
}

{ #category : #exporting }
AeRenderingTest class >> exportAllFilesUsingAeCanvas [
	<script>

	| spaceFixture |
	spaceFixture := AeSpaceFixture new.
	spaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := spaceFixture perform: each.
		self exportFileNamed: each with: aSpace root aeAsForm ].
	
	self inform: ('Exported files using AeCanvas ', Bloc preferableSpartaCanvas label)

]

{ #category : #exporting }
AeRenderingTest class >> exportAllFilesUsingCurrentSpartaCanvas [
	<script>

	| spaceFixture |
	spaceFixture := AeSpaceFixture new.
	spaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := spaceFixture perform: each.
		self exportFileNamed: each with: aSpace root asSpartaForm ].
	
	self inform: ('Exported files using Sparta ', Bloc preferableSpartaCanvas label)

]

{ #category : #exporting }
AeRenderingTest class >> exportFileNamed: aSymbol with: aForm [ 

	| aFileName aPCRenderingTest |
	aPCRenderingTest := self new.
	aFileName := aPCRenderingTest fileNameFor: aSymbol.
	aFileName asFileReference ensureDelete.

	aForm writePNGFileNamed: aFileName
]

{ #category : #tests }
AeRenderingTest >> fileNameFor: aSymbol [

	^ self filesystemResourcesDirectory / ('expected-', aSymbol asString, '.png')

]

{ #category : #tests }
AeRenderingTest >> filesystemResourcesDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'blocbenchs' ].
	^ repo location / 'tests' 
]

{ #category : #tests }
AeRenderingTest >> pixelComparisonFor: aSymbol [
	
	| aSpace expectedForm actualForm |
	aSpace := spaceFixture perform: aSymbol.
	expectedForm := Form fromFileNamed: (self fileNameFor: aSymbol).
	actualForm := aSpace root aeAsForm.

	^ AePixelComparison
		expectedForm: expectedForm
		actualForm: actualForm
		label: aSymbol
]

{ #category : #running }
AeRenderingTest >> setUp [
	super setUp.
	
	spaceFixture := AeSpaceFixture new.
]

{ #category : #tests }
AeRenderingTest >> testAllFixtures [

	| results mismatchingResults |
	results := spaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ].

	mismatchingResults := results reject: [ :each | each isMatch ].

"	DEBUG WITH: mismatchingResults do: [ :each | each inspect ]."

	self assertEmpty: mismatchingResults
]
