Class {
	#name : #AeFontManager,
	#superclass : #Object,
	#instVars : [
		'library',
		'facesByFamily',
		'session'
	],
	#category : #'Alexandrie-FreeType'
}

{ #category : #initialization }
AeFontManager >> checkSession [

	session == Smalltalk session ifFalse: [ self reset ]
]

{ #category : #accessing }
AeFontManager >> facesByFamily [

	^ facesByFamily
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
AeFontManager >> registerAllFacesOnFile: aFileReference [

	| newFaces |
	newFaces := library facesOn: aFileReference.
	
	newFaces do: [ :each | self registerFace: each ]
]

{ #category : #registering }
AeFontManager >> registerFace: aFace [ 

	(facesByFamily
		at: aFace familyName
		ifAbsentPut: [ Set new ])
		add: aFace
]

{ #category : #initialization }
AeFontManager >> reset [

	session := Smalltalk session.
	library := AeFTLibrary newInitialized.
	facesByFamily := Dictionary new
]

{ #category : #scanning }
AeFontManager >> scanDefaultDirectories [

	AeFontScanner new
		addDefaultDirectories;
		manager: self;
		scan

]
