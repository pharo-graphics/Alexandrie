Class {
	#name : #AeFontManager,
	#superclass : #Object,
	#instVars : [
		'session',
		'faceEntriesByFamilyName',
		'freetypeLibrary',
		'faceByEntryCache',
		'defaultFace'
	],
	#classInstVars : [
		'globalInstance'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFontManager class >> globalInstance [
	
	^ globalInstance ifNil: [
		| aFace |
		globalInstance := self new
			scanEmbeddedFonts;
			yourself.
			
		aFace := globalInstance
			detectFamilyName: AeSourceSansProRegular familyName
			slant: AeFontSlant normal
			weight: AeFontWeight normal
			stretch: AeFontStretch normal
			ifNone: [ self error: 'Shouldn''t happen' ].
		
		globalInstance defaultFace: aFace.
		
		globalInstance ]
]

{ #category : #'system startup' }
AeFontManager class >> initialize [

	SessionManager default registerGuiClassNamed: self name
]

{ #category : #accessing }
AeFontManager class >> resetGlobalInstance [

	globalInstance := nil
]

{ #category : #'system startup' }
AeFontManager class >> shutDown: isQuitting [

	isQuitting ifFalse: [ ^ self ].
	self resetGlobalInstance.
]

{ #category : #initialization }
AeFontManager >> checkSession [

	session == Smalltalk session ifFalse: [ self reset ]
]

{ #category : #accessing }
AeFontManager >> defaultFace [
	
	self checkSession.
	^ defaultFace
]

{ #category : #accessing }
AeFontManager >> defaultFace: aFTFace [

	defaultFace := aFTFace
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

{ #category : #testing }
AeFontManager >> includesFamilyName: aString [

	^ faceEntriesByFamilyName includesKey: aString asLowercase
]

{ #category : #initialization }
AeFontManager >> initialize [

	super initialize.

	self reset
]

{ #category : #registering }
AeFontManager >> registerFace: aFace entry: aFaceEntry [

	aFaceEntry 
		familyName: aFace familyName;
		styleName: aFace styleName.
	aFaceEntry weight: 
		(aFace isBold
			ifTrue: [ AeFontWeight bold ]
			ifFalse: [ AeFontWeight normal ]).
	aFaceEntry slant: 
		(aFace isItalic
			ifTrue: [ AeFontSlant italic ]
			ifFalse: [ AeFontSlant normal ]).
	aFaceEntry stretch: AeFontStretch normal.

	(faceEntriesByFamilyName
		at: aFaceEntry familyName asLowercase
		ifAbsentPut: [ Set new ])
		add: aFaceEntry

]

{ #category : #registering }
AeFontManager >> registerFacesOnFile: aFileReference [

	self freetypeLibrary
		fastReadFacesOn: aFileReference
		do: [ :aFace :index |
			self registerFace: aFace entry: 
				(AeFileFaceEntry new
					location: aFileReference;
					index: index;
					yourself) ]
]

{ #category : #registering }
AeFontManager >> registerFacesOnMemory: aByteArray [ 

	self freetypeLibrary
		fastReadFacesOnMemory: aByteArray
		do: [ :aFace :index |
			self registerFace: aFace entry: 
				(AeMemoryFaceEntry new
					bytes: aByteArray;
					index: index;
					yourself) ]
]

{ #category : #initialization }
AeFontManager >> reset [

	"Filesystem dependent"
	faceEntriesByFamilyName := Dictionary new.

	"Session dependents"
	session := Smalltalk session.
	defaultFace := nil.
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

{ #category : #scanning }
AeFontManager >> scanEmbeddedFonts [

	AeEmbeddedFontFile allSubclassesDo: [ :each |
		self registerFacesOnMemory: each fontContentsData ]
]
