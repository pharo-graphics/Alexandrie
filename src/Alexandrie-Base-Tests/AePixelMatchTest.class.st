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

{ #category : #convenience }
AePixelMatchTest class >> allMismatches [

	^ self allPixelComparisons reject: [ :each | each isMatch ]
]

{ #category : #convenience }
AePixelMatchTest class >> allPixelComparisons [

	^ self allFormSelectors collect: [ :each |
		(self new formSelector: each) newPixelComparison ]
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
AePixelMatchTest class >> exportAll [
	"Export each Form to disk, to be used as the expected result in the future test runs."

	| directory |
	directory := self new expectedFormsDirectory.
	directory deleteAllChildren.

	self allFormSelectors do: [ :each |
		(self new formSelector: each) exportAsExpected ].
	
	Clipboard clipboardText: directory pathString.
	self inform: 'Export finished (Path copied to clipboard)'

]

{ #category : #convenience }
AePixelMatchTest class >> inspectAll [

	self allPixelComparisons inspect
]

{ #category : #convenience }
AePixelMatchTest class >> inspectMismatches [

	self allMismatches
		ifEmpty: [ self inform: 'No mismatches found' ]
		ifNotEmpty: [ :mismatches | mismatches inspect ]
]

{ #category : #testing }
AePixelMatchTest class >> isAbstract [
		
	^ self == AePixelMatchTest
]

{ #category : #hooks }
AePixelMatchTest >> actualForm [
	"Build and answer a Form that corresponds to current formSelector parameter."

	^ (self formBehavior perform: formSelector) asForm
]

{ #category : #private }
AePixelMatchTest >> expectedForm [
	"Answer the expected Form, reading it from a file."

	| aFileReference |
	aFileReference := self fileReferenceToExpectedPNG.
	
	^ aFileReference exists
		ifFalse: [ Form extent: 0 asPoint depth: 32 ]
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
	"Answer the class or trait that defines the `formSelector`."

	^ self subclassResponsibility
]

{ #category : #debugging }
AePixelMatchTest >> formMethod [
	"Answer the `CompiledMethod` corresponding to `formSelector`."

	^ self formBehavior class >> formSelector
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
AePixelMatchTest >> testFormSelector [

	| aPixelComparison |
	aPixelComparison := self newPixelComparison.
	self
		assert: aPixelComparison isMatch
		description: 'Pixel mismatch: #', formSelector.
	
"DEBUG?

		aPixelComparison inspect.

		self formMethod browse.
		
		self exportAsExpected.
"

]
