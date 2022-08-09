Class {
	#name : #AeFontManager,
	#superclass : #Object,
	#instVars : [
		'library',
		'facesByFamily'
	],
	#category : #'Alexandrie-FreeType'
}

{ #category : #accessing }
AeFontManager >> facesByFamily [

	^ facesByFamily
]

{ #category : #initialization }
AeFontManager >> initialize [

	super initialize.

	facesByFamily := Dictionary new
]

{ #category : #accessing }
AeFontManager >> library [

	^ library
]

{ #category : #accessing }
AeFontManager >> library: anObject [

	library := anObject
]

{ #category : #'as yet unclassified' }
AeFontManager >> registerAllFaces: aCollection [ 
	
	aCollection do: [ :each |
		self registerFace: each ]
	
]

{ #category : #'as yet unclassified' }
AeFontManager >> registerFace: aFace [ 

	(facesByFamily
		at: aFace familyName
		ifAbsentPut: [ Set new ])
		add: aFace
]
