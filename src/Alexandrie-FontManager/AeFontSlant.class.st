"
I represent a slant type to categorize and query font faces. 

A `AeFileManager` uses me to categorize the scanned font faces.
The users of the manager use me to query for a particular member of a font family.

Access the singleton instances at class-side.
"
Class {
	#name : #AeFontSlant,
	#superclass : #AeFontCategory,
	#classVars : [
		'Italic',
		'Normal',
		'Oblique'
	],
	#category : #'Alexandrie-FontManager'
}

{ #category : #'class initialization' }
AeFontSlant class >> initialize [
	Normal := self slant: 0 name: #normal.
	Italic := self slant: 1 name: #italic.
	Oblique := self slant: 2 name: #oblique
]

{ #category : #accessing }
AeFontSlant class >> italic [
	^ Italic
]

{ #category : #'known names' }
AeFontSlant class >> italicTags [

	^ #( 'ita' 'ital' 'italic' 'cursive' 'kursiv' )
]

{ #category : #accessing }
AeFontSlant class >> normal [
	^ Normal
]

{ #category : #'known names' }
AeFontSlant class >> normalTags [

	^ #( 'book' 'normal' 'regular' 'roman' 'upright' )
]

{ #category : #accessing }
AeFontSlant class >> oblique [
	^ Oblique
]

{ #category : #'known names' }
AeFontSlant class >> obliqueTags [

	^ #( 'inclined' 'oblique' 'backslanted' 'backslant' 'slanted' )
]

{ #category : #'instance creation' }
AeFontSlant class >> slant: aSlantValue name: aSlantName [

	^ self value: aSlantValue name: aSlantName
]
