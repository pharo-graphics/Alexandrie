Class {
	#name : #AeFontManager,
	#superclass : #Object,
	#instVars : [
		'library',
		'session',
		'faceEntriesByFamilyName',
		'faceByEntryCache'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #initialization }
AeFontManager >> checkSession [

	session == Smalltalk session ifFalse: [ self reset ]
]

{ #category : #accessing }
AeFontManager >> detectFamilyName: aFamilyName slant: aSlant weight: aWeight stretch: aStretch ifNone: absentBlock [

	| faces attributes entry |
	faces := faceEntriesByFamilyName
		at: aFamilyName asLowercase
		ifAbsent: [ ^ absentBlock value ].
	
	attributes := { aSlant. aWeight. aStretch }.

	entry := faces
			detect: [ :each | each slantWeightStretch = attributes ]
			ifNone: [ ^ absentBlock value ].

	^ self faceAt: entry
]

{ #category : #accessing }
AeFontManager >> faceAt: aFaceEntry [ 

	^ faceByEntryCache at: aFaceEntry
]

{ #category : #accessing }
AeFontManager >> faceEntries [

	| result |
	result := Set new.
	self faceEntriesByFamilyName valuesDo: [ :each |
		result addAll: each ].
	^ result
]

{ #category : #accessing }
AeFontManager >> faceEntriesByFamilyName [

	^ faceEntriesByFamilyName
]

{ #category : #accessing }
AeFontManager >> familyNames [

	| result |
	result := SortedCollection new.
	self faceEntriesByFamilyName valuesDo: [ :each |
		result add: each anyOne familyName ].
	^ result
]

{ #category : #initialization }
AeFontManager >> initialize [

	super initialize.

	self reset
]

{ #category : #accessing }
AeFontManager >> library [

	^ library
]

{ #category : #registering }
AeFontManager >> registerFace: aFace onFile: aFileReference index: index [

	| anEntry |
	anEntry :=
		AeFileFaceEntry new
			location: aFileReference;
			index: index;
			familyName: aFace familyName;
			styleName: aFace styleName;
			yourself.
	
	(faceEntriesByFamilyName
		at: aFace familyName asLowercase
		ifAbsentPut: [ Set new ])
		add: anEntry

]

{ #category : #registering }
AeFontManager >> registerFacesOnFile: aFileReference [

	library fastReadFacesOn: aFileReference do: [ :aFace :index | 
		self registerFace: aFace onFile: aFileReference index: index ]
]

{ #category : #initialization }
AeFontManager >> reset [

	session := Smalltalk session.
	library := AeFTLibrary newInitialized.
	faceEntriesByFamilyName := Dictionary new.
	faceByEntryCache := LRUCache new
		maximumWeight: 20;
		factory: [ :anEntry | anEntry newFaceWith: library ];
		yourself.
]

{ #category : #scanning }
AeFontManager >> scanDefaultDirectories [

	AeFontScanner new
		addDefaultDirectories;
		manager: self;
		scan

]

{ #category : #scanning }
AeFontManager >> scanDirectory: aFileReference [ 

	AeFontScanner new
		addDirectory: aFileReference;
		manager: self;
		scan

]
