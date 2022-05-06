Class {
	#name : #BARenderingTest,
	#superclass : #TestCase,
	#instVars : [
		'spaceFixture'
	],
	#category : #'Alexandrie-Canvas-Tests-Base'
}

{ #category : #exporting }
BARenderingTest class >> exportAllFilesUsingAeCanvas [
	<script>

	| spaceFixture |
	spaceFixture := BlSpaceFixture new.
	spaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := spaceFixture perform: each.
		self exportFileNamed: each with: aSpace root aeAsForm ].
	
	self inform: ('Exported files using AeCanvas ', Bloc preferableSpartaCanvas label)

]

{ #category : #exporting }
BARenderingTest class >> exportAllFilesUsingCurrentSpartaCanvas [
	<script>

	| spaceFixture |
	spaceFixture := BlSpaceFixture new.
	spaceFixture allFixtureSelectors do: [ :each |
		| aSpace |
		aSpace := spaceFixture perform: each.
		self exportFileNamed: each with: aSpace root asSpartaForm ].
	
	self inform: ('Exported files using Sparta ', Bloc preferableSpartaCanvas label)

]

{ #category : #exporting }
BARenderingTest class >> exportFileNamed: aSymbol with: aForm [ 

	| aFileName aPCRenderingTest |
	aPCRenderingTest := self new.
	aFileName := aPCRenderingTest fileNameFor: aSymbol.
	aFileName asFileReference ensureDelete.

	aForm writePNGFileNamed: aFileName
]

{ #category : #tests }
BARenderingTest >> fileNameFor: aSymbol [

	^ self filesystemResourcesDirectory / ('expected-', aSymbol asString, '.png')

]

{ #category : #tests }
BARenderingTest >> filesystemResourcesDirectory [

	| repo |
	repo := IceRepository registry detect: [ :each | each name asLowercase = 'alexandrie' ].
	^ repo location / 'tests' 
]

{ #category : #tests }
BARenderingTest >> pixelComparisonFor: aSymbol [
	
	| aSpace expectedForm actualForm |
	aSpace := spaceFixture perform: aSymbol.
	expectedForm := Form fromFileNamed: (self fileNameFor: aSymbol).
	actualForm := aSpace root aeAsForm.

	^ BlPixelComparison
		expectedForm: expectedForm
		actualForm: actualForm
		label: aSymbol
]

{ #category : #running }
BARenderingTest >> setUp [
	super setUp.
	
	spaceFixture := BlSpaceFixture new.
]

{ #category : #tests }
BARenderingTest >> testAllFixtures [

	| results mismatchingResults |
	results := spaceFixture allFixtureSelectors
		collect: [ :each | self pixelComparisonFor: each ].

	mismatchingResults := results reject: [ :each | each isMatch ].

"	DEBUG WITH: mismatchingResults do: [ :each | each inspect ]."

	self assertEmpty: mismatchingResults
]
