Class {
	#name : #AeFontSlant,
	#superclass : #AeFontNameValuePool,
	#classVars : [
		'Italic',
		'Normal',
		'Oblique'
	],
	#category : #'Alexandrie-FreeType-Core'
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
