"
I represent a font weight to categorize and query font faces. 

A `AeFileManager` uses me to categorize the scanned font faces.
The users of the manager use me to query for a particular member of a font family.

Access the singleton instances at class-side.
"
Class {
	#name : #AeFontWeight,
	#superclass : #AeFontCategory,
	#classVars : [
		'Black',
		'Bold',
		'ExtraBlack',
		'ExtraBold',
		'ExtraLight',
		'Light',
		'Medium',
		'Normal',
		'SemiBold',
		'SemiLight',
		'Thin'
	],
	#category : #'Alexandrie-FreeType-Manager'
}

{ #category : #accessing }
AeFontWeight class >> black [
	^ Black
]

{ #category : #accessing }
AeFontWeight class >> bold [
	^ Bold
]

{ #category : #accessing }
AeFontWeight class >> extraBlack [
	^ ExtraBlack
]

{ #category : #accessing }
AeFontWeight class >> extraBold [
	^ ExtraBold
]

{ #category : #accessing }
AeFontWeight class >> extraLight [
	^ ExtraLight
]

{ #category : #'class initialization' }
AeFontWeight class >> initialize [
	Thin := self weight: 100 name: #thin.
	ExtraLight := self weight: 200 name: #extraLight.
	Light := self weight: 300 name: #light.
	SemiLight := self weight: 350 name: #semiLight.
	Normal := self weight: 400 name: #normal.
	Medium := self weight: 500 name: #medium.
	SemiBold := self weight: 600 name: #semiBold.
	Bold := self weight: 700 name: #bold.
	ExtraBold := self weight: 800 name: #extraBold.
	Black := self weight: 900 name: #black.
	ExtraBlack := self weight: 1000 name: #extraBlack.
]

{ #category : #accessing }
AeFontWeight class >> light [
	^ Light
]

{ #category : #accessing }
AeFontWeight class >> medium [
	^ Medium
]

{ #category : #accessing }
AeFontWeight class >> normal [
	^ Normal
]

{ #category : #accessing }
AeFontWeight class >> semiBold [
	^ SemiBold
]

{ #category : #accessing }
AeFontWeight class >> semiLight [
	^ SemiLight
]

{ #category : #accessing }
AeFontWeight class >> thin [
	^ Thin
]

{ #category : #'instance creation' }
AeFontWeight class >> weight: aWeightValue name: aWeightName [

	^ self value: aWeightValue name: aWeightName
]
