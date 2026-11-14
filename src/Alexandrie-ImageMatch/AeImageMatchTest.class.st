"
I am an abstract TestCase for visual regression testing.

I execute visual comparisons for parameterized image fixtures discovered via my class-side #allImageSelectors.

Subclasses provide:
- #actual: the actual image or surface under test.
- #expected: the golden/expected image or surface.
- #expectedImagesDirectory: file reference to the directory containing golden PNG fixtures.
- #settings (optional): tolerance settings overriding the default antialiasing tolerance.
"
Class {
	#name : #AeImageMatchTest,
	#superclass : #TestCase,
	#instVars : [
		'imageSelector'
	],
	#category : #'Alexandrie-ImageMatch'
}

{ #category : #comparisons }
AeImageMatchTest class >> allImageComparisons [

	^ self allImageSelectors collect: [ :each |
		| aTest |
		aTest := self new
			imageSelector: each;
			yourself.
		aTest setUp.
		[ aTest newComparison ] ensure: [ aTest tearDown ] ]
]

{ #category : #accessing }
AeImageMatchTest class >> allImageSelectors [

	^ self subclassResponsibility
]

{ #category : #comparisons }
AeImageMatchTest class >> allMismatches [

	^ self allImageComparisons reject: [ :each | each isMatch ]
]

{ #category : #'building suites' }
AeImageMatchTest class >> buildSuite [

	^ self buildSuiteForAll: self allImageSelectors
]

{ #category : #'suite building' }
AeImageMatchTest class >> buildSuiteFor: anImageSelector [

	^ self buildSuiteForAll: { anImageSelector }
]

{ #category : #'suite building' }
AeImageMatchTest class >> buildSuiteForAll: imageSelectors [

	| suite |
	suite := self suiteClass named: self name.
	imageSelectors do: [ :each |
		| tmpSuite |
		tmpSuite := self buildSuiteFromSelectors.
		tmpSuite tests do: [ :aTest | aTest imageSelector: each ].
		suite addTests: tmpSuite tests ].
	^ suite
]

{ #category : #actions }
AeImageMatchTest class >> exportAll [
	"Export each image to disk, to be used as the expected result in future test runs."

	| directory |
	directory := self new expectedImagesDirectory.
	directory ensureCreateDirectory.
	directory deleteAllChildren.
	self allImageSelectors do: [ :each | (self new imageSelector: each) exportAsExpected ].

	Clipboard clipboardText: directory pathString.
	self inform: 'Export finished (Path copied to clipboard)'
]

{ #category : #actions }
AeImageMatchTest class >> fuelOutMismatchesTo: aFileReference [

	self allMismatches
		ifEmpty: [
			Stdio stdout
				<< 'No mismatches found';
				lf ]
		ifNotEmpty: [ :mismatches |
			| path |
			path := aFileReference pathString.
			mismatches serializeToFileNamed: path.
			Stdio stdout
				<< 'Serialized ';
				<< mismatches size;
				<< ' mismatches to: ';
				<< path;
				lf ]
]

{ #category : #actions }
AeImageMatchTest class >> inspectAll [

	^ self allImageComparisons inspect
]

{ #category : #actions }
AeImageMatchTest class >> inspectMismatches [

	self allMismatches ifEmpty: [ self inform: 'No mismatches found' ] ifNotEmpty: [ :mismatches | mismatches inspect ]
]

{ #category : #testing }
AeImageMatchTest class >> isAbstract [

	^ self == AeImageMatchTest
]

{ #category : #accessing }
AeImageMatchTest >> actual [
	"Build and answer the actual image or surface that corresponds to current imageSelector parameter."

	^ self imageBehavior perform: imageSelector
]

{ #category : #hooks }
AeImageMatchTest >> comparisonClass [

	^ AeImageComparison
]

{ #category : #accessing }
AeImageMatchTest >> expected [
	"Answer the expected image or surface, typically reading it from disk."

	^ self comparisonClass readFrom: self fileReferenceToExpectedPNG
]

{ #category : #hooks }
AeImageMatchTest >> expectedImagesDirectory [

	^ self subclassResponsibility
]

{ #category : #actions }
AeImageMatchTest >> exportAsExpected [

	| aFileReference |
	aFileReference := self fileReferenceToExpectedPNG.
	aFileReference ensureDelete.
	aFileReference parent ensureCreateDirectory.
	self newComparison exportActualTo: aFileReference
]

{ #category : #accessing }
AeImageMatchTest >> fileReferenceToExpectedPNG [

	^ self expectedImagesDirectory / (imageSelector asString, '.png')
]

{ #category : #actions }
AeImageMatchTest >> fuelOutMismatch: anAeImageComparison [

	| baseFilename |
	baseFilename := 'image_mismatch_{1}_{2}_{3}_{4}' format: {
		OSPlatform current family.
		Time millisecondClockValue printStringHex.
		self className.
		imageSelector }.

	anAeImageComparison serializeToFileNamed: baseFilename, '.fuel'.
	anAeImageComparison exportActualTo: (baseFilename, '.actual.png') asFileReference
]

{ #category : #accessing }
AeImageMatchTest >> imageBehavior [
	"Answer the class or trait that defines the imageSelector."

	^ self
]

{ #category : #accessing }
AeImageMatchTest >> imageMethod [
	"Answer the CompiledMethod corresponding to imageSelector."

	^ self imageBehavior class >> imageSelector
]

{ #category : #accessing }
AeImageMatchTest >> imageSelector [

	^ imageSelector
]

{ #category : #accessing }
AeImageMatchTest >> imageSelector: aSymbol [

	imageSelector := aSymbol
]

{ #category : #private }
AeImageMatchTest >> instanceVariablesToKeep [

	^ super instanceVariablesToKeep, #(imageSelector)
]

{ #category : #accessing }
AeImageMatchTest >> nameForReport [

	^ imageSelector
		ifNil: [ super nameForReport ]
		ifNotNil: [ :selector | selector asString ]
]

{ #category : #running }
AeImageMatchTest >> newComparison [

	^ self comparisonClass
		expected: self expected
		actual: self actual
		label: imageSelector asString
		settings: self settings
]

{ #category : #private }
AeImageMatchTest >> performTest [

	imageSelector ifNil: [ self error: 'imageSelector is nil. Please, run this suite from Test Runner.' ].
	^ super performTest
]

{ #category : #printing }
AeImageMatchTest >> printOn: aStream [

	aStream
		print: imageSelector;
		nextPutAll: ' @ '.
	super printOn: aStream
]

{ #category : #hooks }
AeImageMatchTest >> settings [
	"Answer settings and tolerances for the comparison. Subclasses may override.
	Allow 1% color delta and up to 5 edge pixels for sub-pixel geometry rounding."

	^ AeImageMatchSettings colorTolerance: 0.01 maxMismatchCount: 5 maxMismatchRatio: 0.0
]

{ #category : #running }
AeImageMatchTest >> testImageSelector [

	| aComparison |
	aComparison := self newComparison.
	aComparison isMatch ifFalse: [ self fuelOutMismatch: aComparison ].
	self assert: aComparison isMatch description: [ aComparison diagnosisString ]
]
