"
I am a FreeType FFI binding to the `FT_Sfnt_Tag` enum.

An enumeration to specify indices of SFNT tables loaded and parsed by FreeType during initialization of an SFNT font. Used in the `FT_Get_Sfnt_Table` API function.

See: https://freetype.org/freetype2/docs/reference/ft2-truetype_tables.html#ft_sfnt_tag
"
Class {
	#name : #AeFTSfntTag,
	#superclass : #AeEnumeration,
	#classVars : [
		'FT_SFNT_HEAD',
		'FT_SFNT_HHEA',
		'FT_SFNT_MAXP',
		'FT_SFNT_OS2',
		'FT_SFNT_PCLT',
		'FT_SFNT_POST',
		'FT_SFNT_VHEA'
	],
	#category : #'Alexandrie-FreeType'
}

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_HEAD [
	"This method was automatically generated"
	^ FT_SFNT_HEAD
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_HHEA [
	"This method was automatically generated"
	^ FT_SFNT_HHEA
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_MAXP [
	"This method was automatically generated"
	^ FT_SFNT_MAXP
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_OS2 [
	"This method was automatically generated"

	^ FT_SFNT_OS2
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_PCLT [
	"This method was automatically generated"

	^ FT_SFNT_PCLT
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_POST [
	"This method was automatically generated"
	^ FT_SFNT_POST
]

{ #category : #'accessing enum' }
AeFTSfntTag class >> FT_SFNT_VHEA [
	"This method was automatically generated"

	^ FT_SFNT_VHEA
]

{ #category : #'enum declaration' }
AeFTSfntTag class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		FT_SFNT_HEAD 0
		FT_SFNT_MAXP 1
		FT_SFNT_OS2  2
		FT_SFNT_HHEA 3
		FT_SFNT_VHEA 4
		FT_SFNT_POST 5
		FT_SFNT_PCLT 6)
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> head [

	^ self FT_SFNT_HEAD
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> hhea [

	^ self FT_SFNT_HHEA
]

{ #category : #initialization }
AeFTSfntTag class >> initialize [

	self initializeEnumeration
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> maxp [

	^ self FT_SFNT_MAXP
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> os2 [

	^ self FT_SFNT_OS2
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> pclt [

	^ self FT_SFNT_PCLT
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> post [

	^ self FT_SFNT_POST
]

{ #category : #hook }
AeFTSfntTag class >> underlinedNamePrefix [
	
	^ 'FT_SFNT_'
]

{ #category : #'accessing enum camelcased' }
AeFTSfntTag class >> vhea [

	^ self FT_SFNT_VHEA
]
