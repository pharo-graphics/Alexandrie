Class {
	#name : #AeHbScript,
	#superclass : #FFIEnumeration,
	#classVars : [
		'HB_SCRIPT_LATIN'
	],
	#category : #'Alexandrie-Harfbuzz-Enumerations'
}

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LATIN [
	"This method was automatically generated"
	^ HB_SCRIPT_LATIN
]

{ #category : #'enum declaration' }
AeHbScript class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

"result of asbyteArray asInteger"
	^ #(
	HB_SCRIPT_LATIN 1281455214
	)
]

{ #category : #'enum declaration' }
AeHbScript class >> initialize [

	self initializeEnumeration
]
