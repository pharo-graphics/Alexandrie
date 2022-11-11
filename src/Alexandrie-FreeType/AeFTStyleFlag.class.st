"
I am a FreeType FFI binding to `FT_STYLE_FLAG_XXX` bit flags.

These bit flags indicate the style of a given face. These are used in the `style_flags` field of `FT_FaceRec`.

See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_style_flag_xxx
"
Class {
	#name : #AeFTStyleFlag,
	#superclass : #AeEnumeration,
	#classVars : [
		'FT_STYLE_FLAG_BOLD',
		'FT_STYLE_FLAG_ITALIC'
	],
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #'accessing enum' }
AeFTStyleFlag class >> FT_STYLE_FLAG_BOLD [
	"This method was automatically generated"
	^ FT_STYLE_FLAG_BOLD
]

{ #category : #'accessing enum' }
AeFTStyleFlag class >> FT_STYLE_FLAG_ITALIC [
	"This method was automatically generated"
	^ FT_STYLE_FLAG_ITALIC
]

{ #category : #'enum declaration' }
AeFTStyleFlag class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		FT_STYLE_FLAG_ITALIC 1 "The face style is italic or oblique."
		FT_STYLE_FLAG_BOLD   2 "The face is bold."
		)
]

{ #category : #'enum declaration' }
AeFTStyleFlag class >> initialize [

	self initializeEnumeration
]
