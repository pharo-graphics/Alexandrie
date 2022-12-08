Class {
	#name : #AePixelMatchTest,
	#superclass : #TestCase,
	#instVars : [
		'formSelector'
	],
	#category : #'Alexandrie-Base-Tests'
}

{ #category : #hooks }
AePixelMatchTest class >> allFormSelectors [

	^ self subclassResponsibility
]

{ #category : #'building suites' }
AePixelMatchTest class >> buildSuite [

	| suite |
	suite := self suiteClass named: self name.
	
	self allFormSelectors do: [ :each |
		| tmpSuite |
		tmpSuite := self buildSuiteFromSelectors.
		tmpSuite tests do: [ :aTest | aTest formSelector: each ].
		suite addTests: tmpSuite tests ].

	^ suite
]

{ #category : #convenience }
AePixelMatchTest class >> deleteAllExports [

	self new expectedFormsDirectory deleteAllChildren.
	
	self inform: 'Delete finished: ', self new expectedFormsDirectory pathString


]

{ #category : #'building suites' }
AePixelMatchTest class >> exportAll [
	"Export each Form to disk, to be used as the expected result in the future test runs."

	self allFormSelectors do: [ :each |
		(self new formSelector: each) exportAsExpected ].
	
	Clipboard clipboardText: self new expectedFormsDirectory pathString.
	self inform: 'Export finished (Path copied to clipboard)'

]

{ #category : #testing }
AePixelMatchTest class >> isAbstract [
		
	^ self == AePixelMatchTest
]

{ #category : #hooks }
AePixelMatchTest >> actualForm [

	^ self subclassResponsibility
]

{ #category : #private }
AePixelMatchTest >> expectedForm [

	| aFileReference |
	aFileReference := self fileReferenceToExpectedPNG.
	
	^ aFileReference exists
		ifFalse: [ Form extent: 1 asPoint depth: 32 ]
		ifTrue: [ Form fromFileNamed: aFileReference ]
]

{ #category : #hooks }
AePixelMatchTest >> expectedFormsDirectory [

	^ self subclassResponsibility
]

{ #category : #private }
AePixelMatchTest >> exportAsExpected [

	| aFileReference |
	aFileReference := self fileReferenceToExpectedPNG.
	aFileReference ensureDelete.
	aFileReference parent exists ifFalse: [ 
		aFileReference parent ensureCreateDirectory ].
	self actualForm writePNGFileNamed: aFileReference
]

{ #category : #private }
AePixelMatchTest >> fileReferenceToExpectedPNG [

	^ self expectedFormsDirectory / (formSelector asString, '.png')

]

{ #category : #hooks }
AePixelMatchTest >> formBehavior [

	^ self subclassResponsibility
]

{ #category : #accessing }
AePixelMatchTest >> formSelector: aSymbol [

	formSelector := aSymbol
]

{ #category : #private }
AePixelMatchTest >> instanceVariablesToKeep [

	^ super instanceVariablesToKeep, #(formSelector)
]

{ #category : #private }
AePixelMatchTest >> newPixelComparison [

	^ AePixelComparison
		expectedForm: self expectedForm
		actualForm: self actualForm
		label: formSelector
]

{ #category : #tests }
AePixelMatchTest >> performTest [

	formSelector ifNil: [
		self error: 'formSelector is nil. Please, run this suite from Test Runner.' ].

	^ super performTest
]

{ #category : #tests }
AePixelMatchTest >> printOn: aStream [

	aStream
		print: formSelector;
		nextPutAll: ' @ '.
	super printOn: aStream.

]

{ #category : #tests }
AePixelMatchTest >> testFormSelectorMatches [

	| result |
	result := self newPixelComparison.
	self assert: result isMatch description: 'Pixel mismatch in ', formSelector.
	
"	TO DEBUG:

		result inspect.

		(self formBehavior >> formSelector) browse.

"

]
