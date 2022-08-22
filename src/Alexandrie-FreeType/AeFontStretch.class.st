"
I represent a stretch type to categorize and query font faces. 

A `AeFileManager` uses me to categorize the scanned font faces.
The users of the manager use me to query for a particular member of a font family.

Access the singleton instances at class-side.
"
Class {
	#name : #AeFontStretch,
	#superclass : #AeFontCategory,
	#classVars : [
		'Condensed',
		'Expanded',
		'ExtraCondensed',
		'ExtraExpanded',
		'Normal',
		'SemiCondensed',
		'SemiExpanded',
		'UltraCondensed',
		'UltraExpanded'
	],
	#category : #'Alexandrie-FreeType-Manager'
}

{ #category : #accessing }
AeFontStretch class >> condensed [
	^ Condensed
]

{ #category : #accessing }
AeFontStretch class >> expanded [
	^ Expanded
]

{ #category : #accessing }
AeFontStretch class >> extraCondensed [
	^ ExtraCondensed
]

{ #category : #accessing }
AeFontStretch class >> extraExpanded [
	^ ExtraExpanded
]

{ #category : #'class initialization' }
AeFontStretch class >> initialize [
	UltraCondensed := self stretch: 0 name: #ultraCondensed.
	ExtraCondensed := self stretch: 1 name: #extraCondensed.
	Condensed := self stretch: 2 name: #condensed.
	SemiCondensed := self stretch: 3 name: #semiCondensed.
	Normal := self stretch: 4 name: #normal.
	SemiExpanded := self stretch: 5 name: #semiExpanded.
	Expanded := self stretch: 6 name: #expanded.
	ExtraExpanded := self stretch: 7 name: #extraExpanded.
	UltraExpanded := self stretch: 8 name: #ultraExpanded.
]

{ #category : #accessing }
AeFontStretch class >> normal [
	^ Normal
]

{ #category : #accessing }
AeFontStretch class >> semiCondensed [
	^ SemiCondensed
]

{ #category : #accessing }
AeFontStretch class >> semiExpanded [
	^ SemiExpanded
]

{ #category : #'instance creation' }
AeFontStretch class >> stretch: aStretchValue name: aStretchName [

	^ self value: aStretchValue name: aStretchName
]

{ #category : #accessing }
AeFontStretch class >> ultraCondensed [
	^ UltraCondensed
]

{ #category : #accessing }
AeFontStretch class >> ultraExpanded [
	^ UltraExpanded
]
