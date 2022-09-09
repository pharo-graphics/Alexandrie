Class {
	#name : #AeHbDirection,
	#superclass : #FFIEnumeration,
	#classVars : [
		'HB_DIRECTION_BTT',
		'HB_DIRECTION_INVALID',
		'HB_DIRECTION_LTR',
		'HB_DIRECTION_RTL',
		'HB_DIRECTION_TTB'
	],
	#category : #'Alexandrie-Harfbuzz-Enumerations'
}

{ #category : #'accessing enum' }
AeHbDirection class >> HB_DIRECTION_BTT [
	"This method was automatically generated"
	^ HB_DIRECTION_BTT
]

{ #category : #'accessing enum' }
AeHbDirection class >> HB_DIRECTION_INVALID [
	"This method was automatically generated"
	^ HB_DIRECTION_INVALID
]

{ #category : #'accessing enum' }
AeHbDirection class >> HB_DIRECTION_LTR [
	"This method was automatically generated"
	^ HB_DIRECTION_LTR
]

{ #category : #'accessing enum' }
AeHbDirection class >> HB_DIRECTION_RTL [
	"This method was automatically generated"
	^ HB_DIRECTION_RTL
]

{ #category : #'accessing enum' }
AeHbDirection class >> HB_DIRECTION_TTB [
	"This method was automatically generated"
	^ HB_DIRECTION_TTB
]

{ #category : #'enum declaration' }
AeHbDirection class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
  HB_DIRECTION_INVALID 0
  HB_DIRECTION_LTR 4
  HB_DIRECTION_RTL 5
  HB_DIRECTION_TTB 6
  HB_DIRECTION_BTT 7
	)
]

{ #category : #initialization }
AeHbDirection class >> initialize [

	self initializeEnumeration
]
