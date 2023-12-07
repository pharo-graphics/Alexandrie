"
I am a Harfbuzz FFI binding for `hb_ot_var_axis_info_t`, a data type for holding variation-axis values.

The minimum, default, and maximum values are in un-normalized, user scales.

See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-axis-info-t
"
Class {
	#name : #AeHbVariableFontAxisInfo,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_AXISINDEX',
		'OFFSET_DEFAULTVALUE',
		'OFFSET_FLAGS',
		'OFFSET_MAXVALUE',
		'OFFSET_MINVALUE',
		'OFFSET_NAMEID',
		'OFFSET_TAG'
	],
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-HarfbuzzVariableFonts'
}

{ #category : #'field definition' }
AeHbVariableFontAxisInfo class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		uint										axisIndex;    "axis_index"
		hb_tag_t									tag;
		uint   "hb_ot_name_id_t"          nameId;       "name_id"
		uint32 "hb_ot_var_axis_flags_t" 	flags;
		float										minValue;     "min_value"
		float										defaultValue; "default_value"
		float										maxValue;     "max_value"
		)
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> axisIndex [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_AXISINDEX
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> axisIndex: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_AXISINDEX put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> defaultValue [
	"This method was automatically generated"
	^handle floatAt: OFFSET_DEFAULTVALUE
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> defaultValue: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_DEFAULTVALUE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> flags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> flags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #testing }
AeHbVariableFontAxisInfo >> isHidden [
	"Test whether this axis should not be exposed directly in user interfaces.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-axis-flags-t"

	^ self flags = 1 "HB_OT_VAR_AXIS_FLAG_HIDDEN"
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> maxValue [
	"This method was automatically generated"
	^handle floatAt: OFFSET_MAXVALUE
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> maxValue: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_MAXVALUE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> minValue [
	"This method was automatically generated"
	^handle floatAt: OFFSET_MINVALUE
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> minValue: anObject [
	"This method was automatically generated"
	handle floatAt: OFFSET_MINVALUE put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> nameId [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_NAMEID
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> nameId: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_NAMEID put: anObject
]

{ #category : #printing }
AeHbVariableFontAxisInfo >> printOn: aStream [

	super printOn: aStream.
	#(axisIndex tagString nameId minValue defaultValue maxValue) do: [ :each |
		aStream
			space;
			nextPutAll: each;
			nextPutAll: ': ';
			print: (self perform: each) ]

]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> tag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_TAG
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> tag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_TAG put: anObject
]

{ #category : #'accessing - structure variables' }
AeHbVariableFontAxisInfo >> tagString [

	^ self tag asHbTagString
]
