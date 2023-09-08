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
		| aTest |
		aTest := self new formSelector: each; yourself.
		aTest setUp.
		[ aTest newPixelComparison ]
			ensure: [ aTest tearDown ] ]
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
AePixelMatchTest class >> fuelOutMismatchesTo: aFileReference [

	self allMismatches
		ifEmpty: [
			Stdio stdout << 'No mismatches found'; lf ]
		ifNotEmpty: [ :mismatches |
			| path |
			path := aFileReference pathString.
			mismatches serializeToFileNamed: path.
			Stdio stdout
				<< 'Serialized ';
				<< mismatches size;
				<< ' mismatches to: ';
				<< path; lf ]
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

{ #category : #tests }
AePixelMatchTest >> fuelOutMismatch: aPixelComparison [

	aPixelComparison
		serializeToFileNamed: ('pixel_mismatch_{1}_{2}_{3}_{4}.fuel'
		format: {
			OSPlatform current family.
			Time primMillisecondClock printStringHex.
			self className.
			formSelector })
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
	
	aPixelComparison isMatch ifFalse: [
		self fuelOutMismatch: aPixelComparison ].
	
	self
		assert: aPixelComparison isMatch
		description: 'Pixel mismatch: #', formSelector.
	
"DEBUG?

		aPixelComparison inspect.

		self formMethod browse.
		
		self exportAsExpected.
"

]
