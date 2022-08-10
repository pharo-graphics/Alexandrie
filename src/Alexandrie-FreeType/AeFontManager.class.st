Class {
	#name : #AeFontManager,
	#superclass : #Object,
	#instVars : [
		'session',
		'faceEntriesByFamilyName',
		'faceByEntryCache',
		'freetypeLibrary'
	],
	#classInstVars : [
		'globalInstance'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFontManager class >> globalInstance [

	^ globalInstance ifNil: [ globalInstance := self new ]
]

{ #category : #accessing }
AeFontManager class >> resetGlobalInstance [

	globalInstance := nil
]

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

	^ self faceByEntryCache at: aFaceEntry
]

{ #category : #accessing }
AeFontManager >> faceByEntryCache [

	self checkSession. "Cache may be invalid after session change"
	^ faceByEntryCache
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

{ #category : #accessing }
AeFontManager >> freetypeLibrary [

	self checkSession.
	^ freetypeLibrary
]

{ #category : #initialization }
AeFontManager >> initialize [

	super initialize.

	self reset
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

	self freetypeLibrary fastReadFacesOn: aFileReference do: [ :aFace :index | 
		self registerFace: aFace onFile: aFileReference index: index ]
]

{ #category : #initialization }
AeFontManager >> reset [

	"Filesystem dependent"
	faceEntriesByFamilyName := Dictionary new.

	"Session dependents"
	session := Smalltalk session.
	freetypeLibrary := AeFTLibrary newInitialized.
	faceByEntryCache := LRUCache new
		maximumWeight: 20;
		factory: [ :anEntry | anEntry newFaceWith: freetypeLibrary ];
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
