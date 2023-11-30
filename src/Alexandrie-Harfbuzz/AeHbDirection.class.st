"
I represent FFI bindings to `hb_direction_t` enum: The direction of a text segment or buffer.

Members:
	* `HB_DIRECTION_INVALID`: Initial, unset direction.
	* `HB_DIRECTION_LTR`: Text is set horizontally from left to right.
	* `HB_DIRECTION_RTL`: Text is set horizontally from right to left.
	* `HB_DIRECTION_TTB`: Text is set vertically from top to bottom.
	* `HB_DIRECTION_BTT`: Text is set vertically from bottom to top.

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-direction-t
"
Class {
	#name : 'AeHbDirection',
	#superclass : 'AeEnumeration',
	#classVars : [
		'HB_DIRECTION_BTT',
		'HB_DIRECTION_INVALID',
		'HB_DIRECTION_LTR',
		'HB_DIRECTION_RTL',
		'HB_DIRECTION_TTB'
	],
	#category : 'Alexandrie-Harfbuzz-Enumerations',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Enumerations'
}

{ #category : 'accessing enum' }
AeHbDirection class >> HB_DIRECTION_BTT [
	"This method was automatically generated"
	^ HB_DIRECTION_BTT
]

{ #category : 'accessing enum' }
AeHbDirection class >> HB_DIRECTION_INVALID [
	"This method was automatically generated"
	^ HB_DIRECTION_INVALID
]

{ #category : 'accessing enum' }
AeHbDirection class >> HB_DIRECTION_LTR [
	"This method was automatically generated"
	^ HB_DIRECTION_LTR
]

{ #category : 'accessing enum' }
AeHbDirection class >> HB_DIRECTION_RTL [
	"This method was automatically generated"
	^ HB_DIRECTION_RTL
]

{ #category : 'accessing enum' }
AeHbDirection class >> HB_DIRECTION_TTB [
	"This method was automatically generated"
	^ HB_DIRECTION_TTB
]

{ #category : 'accessing enum' }
AeHbDirection class >> bottomToTop [

	^ self HB_DIRECTION_BTT
]

{ #category : 'enum declaration' }
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

{ #category : 'accessing enum' }
AeHbDirection class >> invalid [

	^ self HB_DIRECTION_INVALID
]

{ #category : 'accessing enum' }
AeHbDirection class >> leftToRight [

	^ self HB_DIRECTION_LTR
]

{ #category : 'accessing enum' }
AeHbDirection class >> rightToLeft [

	^ self HB_DIRECTION_RTL
]

{ #category : 'accessing enum' }
AeHbDirection class >> topToBottom [

	^ self HB_DIRECTION_TTB
]

{ #category : 'hook' }
AeHbDirection class >> underlinedNamePrefix [
	
	^ 'HB_DIRECTION_'
]
