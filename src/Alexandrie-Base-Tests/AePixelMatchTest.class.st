Class {
	#name : #AePixelMatchTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Base-Tests'
}

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

{ #category : #private }
AePixelMatchTest >> pixelComparisonFor: aSymbol [

	^ AePixelComparison
		expectedForm: (self expectedFormFor: aSymbol)
		actualForm: (self actualFormFor: aSymbol)
		label: aSymbol
]

{ #category : #tests }
AePixelMatchTest >> testAllForms [

	| results mismatchingResults |
	results := self allFormSelectors collect: [ :each |
		self pixelComparisonFor: each ].

	mismatchingResults := results reject: [ :each | each isMatch ].

"	INSPECT MISMATCHES WITH:

		mismatchingResults inspect.
"

	self
		assert: mismatchingResults isEmpty
		description: (String streamContents: [ :stream |
			stream << 'Pixel mismatch on selectors: '.
			mismatchingResults
				do: [ :each | stream << each label ]
				separatedBy: [ stream << ', ' ] ])
]
