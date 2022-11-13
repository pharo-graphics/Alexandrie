Class {
	#name : #AePixelMatchTest,
	#superclass : #TestCase,
	#instVars : [
		'formSelector'
	],
	#category : #'Alexandrie-Base-Tests'
}

{ #category : #'building suites' }
AePixelMatchTest class >> buildSuite [

	| suite formSelectors |
	
	suite := self suiteClass named: self name.
	
	formSelectors := self new allFormSelectors.
	
	formSelectors do: [ :each |
		| internalSuite |
		internalSuite := self buildSuiteFromSelectors.
		internalSuite tests do: [ :aTest | aTest formSelector: each ].
		suite addTests: internalSuite tests. ].

	^ suite
]

{ #category : #testing }
AePixelMatchTest class >> isAbstract [
		
	^ self == AePixelMatchTest
]

{ #category : #hooks }
AePixelMatchTest >> actualFormFor: aSymbol [

	^ self subclassResponsibility
]

{ #category : #hooks }
AePixelMatchTest >> allFormSelectors [

	^ self subclassResponsibility
]

{ #category : #convenience }
AePixelMatchTest >> deleteAllExports [

	self expectedFormsDirectory deleteAllChildren.
	
	self inform: 'Delete finished: ', self expectedFormsDirectory pathString


]

{ #category : #private }
AePixelMatchTest >> expectedFormFor: aSymbol [

	| fileReferenceToForm |
	fileReferenceToForm := self fileReferenceFor: aSymbol.
	
	^ fileReferenceToForm exists
		ifFalse: [ Form extent: 1 asPoint depth: 32 ]
		ifTrue: [ Form fromFileNamed: fileReferenceToForm ]
]

{ #category : #hooks }
AePixelMatchTest >> expectedFormsDirectory [

	^ self subclassResponsibility
]

{ #category : #private }
AePixelMatchTest >> export: aSymbol form: aForm [ 

	| pngFileReference |
	pngFileReference := self fileReferenceFor: aSymbol.
	pngFileReference ensureDelete.
	pngFileReference parent exists ifFalse: [ 
		pngFileReference parent ensureCreateDirectory ].
	aForm writePNGFileNamed: pngFileReference
]

{ #category : #convenience }
AePixelMatchTest >> exportAll [
	"Export each Form to disk, to be used as the expected result in the future test runs."

	self allFormSelectors do: [ :each |
		self
			export: each
			form: (self actualFormFor: each) ].
	
	Clipboard clipboardText: self expectedFormsDirectory pathString.
	self inform: 'Export finished (Path copied to clipboard)'

]

{ #category : #private }
AePixelMatchTest >> fileReferenceFor: aSymbol [

	^ self expectedFormsDirectory / (aSymbol asString, '.png')

]

{ #category : #accessing }
AePixelMatchTest >> formSelector: aString [

	formSelector := aString
]

{ #category : #private }
AePixelMatchTest >> instanceVariablesToKeep [

	^ super instanceVariablesToKeep, #(formSelector)
]

{ #category : #tests }
AePixelMatchTest >> performTest [

	formSelector ifNil: [
		self error: 'formSelector is nil. Please, run this suite from Test Runner.' ].

	^ super performTest
]

{ #category : #private }
AePixelMatchTest >> pixelComparisonFor: aSymbol [

	^ AePixelComparison
		expectedForm: (self expectedFormFor: aSymbol)
		actualForm: (self actualFormFor: aSymbol)
		label: aSymbol
]

{ #category : #tests }
AePixelMatchTest >> printOn: aStream [

	super printOn: aStream.
	aStream
		space;
		nextPut: $(;
		print: formSelector;
		nextPut: $)

]

{ #category : #tests }
AePixelMatchTest >> testFormSelectorMatches [

	| result |
	result := self pixelComparisonFor: formSelector.
	self assert: result isMatch description: 'Pixel mismatch in ', formSelector.
	
"	INSPECT MISMATCH WITH:

		result inspect.
"

]
