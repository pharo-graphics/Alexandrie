Class {
	#name : #AeFontWeight,
	#superclass : #AeFontNameValuePool,
	#classVars : [
		'Black',
		'Bold',
		'ExtraBold',
		'ExtraLight',
		'Light',
		'Medium',
		'Normal',
		'SemiBold',
		'SemiLight',
		'Thin'
	],
	#category : #'Alexandrie-FreeType-Core'
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
