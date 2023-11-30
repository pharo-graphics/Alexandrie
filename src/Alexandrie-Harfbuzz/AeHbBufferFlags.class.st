"
I represent FFI bindings to `hb_buffer_flags_t` enum: Flags for `hb_buffer_t`.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-flags-t
"
Class {
	#name : 'AeHbBufferFlags',
	#superclass : 'AeEnumeration',
	#classVars : [
		'HB_BUFFER_FLAG_BOT',
		'HB_BUFFER_FLAG_DEFAULT',
		'HB_BUFFER_FLAG_DEFINED',
		'HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE',
		'HB_BUFFER_FLAG_EOT',
		'HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES',
		'HB_BUFFER_FLAG_PRODUCE_SAFE_TO_INSERT_TATWEEL',
		'HB_BUFFER_FLAG_PRODUCE_UNSAFE_TO_CONCAT',
		'HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES',
		'HB_BUFFER_FLAG_VERIFY'
	],
	#category : 'Alexandrie-Harfbuzz-Enumerations',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Enumerations'
}

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_BOT [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_BOT
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_DEFAULT [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_DEFAULT
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_DEFINED [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_DEFINED
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_EOT [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_EOT
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_PRODUCE_SAFE_TO_INSERT_TATWEEL [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_PRODUCE_SAFE_TO_INSERT_TATWEEL
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_PRODUCE_UNSAFE_TO_CONCAT [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_PRODUCE_UNSAFE_TO_CONCAT
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> HB_BUFFER_FLAG_VERIFY [
	"This method was automatically generated"
	^ HB_BUFFER_FLAG_VERIFY
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> beginningOfText [

	^ HB_BUFFER_FLAG_BOT
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> beginningOrEndingOfText [
	"Pango sets this value by default
	See: shape.c"

	^ HB_BUFFER_FLAG_BOT value bitOr: HB_BUFFER_FLAG_EOT value
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> bot [

	^ HB_BUFFER_FLAG_BOT
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> default [

	^ HB_BUFFER_FLAG_DEFAULT
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> defined [

	^ HB_BUFFER_FLAG_DEFINED
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> doNotInsertDottedCircle [

	^ HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE
]

{ #category : 'accessing enum' }
AeHbBufferFlags class >> endingOfText [

	^ HB_BUFFER_FLAG_EOT
]

{ #category : 'enum declaration' }
AeHbBufferFlags class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
  HB_BUFFER_FLAG_DEFAULT 16r00
  HB_BUFFER_FLAG_BOT 16r01 "/* Beginning-of-text */"
  HB_BUFFER_FLAG_EOT 16r02 "/* End-of-text */"
  HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES 16r04
  HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES 	16r08
  HB_BUFFER_FLAG_DO_NOT_INSERT_DOTTED_CIRCLE 16r10
  HB_BUFFER_FLAG_VERIFY 							16r20
  HB_BUFFER_FLAG_PRODUCE_UNSAFE_TO_CONCAT		16r40
  HB_BUFFER_FLAG_PRODUCE_SAFE_TO_INSERT_TATWEEL	16r80

  HB_BUFFER_FLAG_DEFINED 16rFF
	)
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> eot [

	^ HB_BUFFER_FLAG_EOT
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> preserveDefaultIgnorables [

	^ HB_BUFFER_FLAG_PRESERVE_DEFAULT_IGNORABLES
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> produceSafeToInsertTatweel [

	^ HB_BUFFER_FLAG_PRODUCE_SAFE_TO_INSERT_TATWEEL
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> produceUnsafeToConcat [

	^ HB_BUFFER_FLAG_PRODUCE_UNSAFE_TO_CONCAT
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> removeDefaultIgnorables [

	^ HB_BUFFER_FLAG_REMOVE_DEFAULT_IGNORABLES
]

{ #category : 'hook' }
AeHbBufferFlags class >> underlinedNamePrefix [
	
	^ 'HB_BUFFER_FLAG_'
]

{ #category : 'accessing enum camelcased' }
AeHbBufferFlags class >> verify [

	^ HB_BUFFER_FLAG_VERIFY
]
