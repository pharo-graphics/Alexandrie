"
I represent FFI bindings to `hb_buffer_t`: Input and output buffers.

Buffers serve a dual role in HarfBuzz; before shaping, they hold the input characters that are passed to `hb_shape()`, and after shaping they hold the output glyphs.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html
"
Class {
	#name : #AeHbBuffer,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #convenience }
AeHbBuffer class >> defaultCairoGlyphArrayFor: aString face: aeFTFace size: fontSize [ 
	"Answer a Cairo glyph array for a String, with the following parameters: 
	* left-to-right direction
	* latin script
	* English language
	* HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS cluster level (recommended by lib's documentation)
	"

	^ self new
		direction: AeHbDirection leftToRight;
		script: AeHbScript latin;
		language: AeHbLanguage en;
		clusterLevel: AeHbBufferClusterLevel recommended;
		addUtf8String: aString;
		cairoGlyphArrayForFace: aeFTFace size: fontSize
]

{ #category : #finalization }
AeHbBuffer class >> externallyFree: aHandle [

	self ffiCall: #( void hb_buffer_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbBuffer class >> new [

	^ self unboundedNew
		autoRelease;
		yourself

]

{ #category : #'instance creation' }
AeHbBuffer class >> unboundedNew [

	^ self ffiCall: #(
		hb_buffer_t *
		hb_buffer_create (void)
	)
]

{ #category : #'accessing - input' }
AeHbBuffer >> addUTF8ByteArray: text length: text_length itemOffset: item_offset itemLength: item_length [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-add-utf8"

	self ffiCall: #(
		void
		hb_buffer_add_utf8 (
			self,
			char *text,
			int text_length,
			uint item_offset,
			int item_length)
	)
]

{ #category : #'accessing - input' }
AeHbBuffer >> addUtf8String: aString [

	| encoded |
	encoded := aString utf8Encoded.
	self addUTF8ByteArray: encoded length: encoded size itemOffset: 0 itemLength: encoded size

]

{ #category : #'accessing - output' }
AeHbBuffer >> clearContents [
	"Similar to `hb_buffer_reset()`, but does not clear the Unicode functions and the replacement code point.

	See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-clear-contents"

	self ffiCall: #(
		void
		hb_buffer_clear_contents ( self )
		)
]

{ #category : #'accessing - input' }
AeHbBuffer >> clusterLevel: cluster_level [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-cluster-level"

	self ffiCall: #(
		void
		hb_buffer_set_cluster_level (
			self,
			hb_buffer_cluster_level_t cluster_level)
	)
]

{ #category : #'accessing - input' }
AeHbBuffer >> direction: direction [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-direction"

	self ffiCall: #(
		void
		hb_buffer_set_direction (
			self,
			hb_direction_t direction)
	)
]

{ #category : #'accessing - input' }
AeHbBuffer >> flags: flags [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-flags"

	self ffiCall: #(
		void
		hb_buffer_set_flags (
			self,
			"hb_buffer_flags_t" uint flags)
	)
]

{ #category : #'accessing - output' }
AeHbBuffer >> getGlyphInfosOn: aPointer [
	"Returns a collection of `AeHbGlyphInfo` with glyph information. Returned pointer is valid as long as buffer contents are not modified.

	See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-get-glyph-infos"

	^ self ffiCall: #(
		"hb_glyph_info_t" void *
		hb_buffer_get_glyph_infos (
			self,
			uint * aPointer)
		)
]

{ #category : #'accessing - output' }
AeHbBuffer >> getGlyphPositionsOn: aPointer [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-get-glyph-positions"

	^ self ffiCall: #(
		"hb_glyph_position_t" void *
		hb_buffer_get_glyph_positions (
			self,
			uint * aPointer)
		)
]

{ #category : #'accessing - output' }
AeHbBuffer >> glyphInfos [
	"Answer an array of `AeHbGlyphInfo` that indicate information of each glyph of this buffer."

	| lengthPointer aHandle |
	lengthPointer := FFIUInt32 newBuffer.
	aHandle := self getGlyphInfosOn: lengthPointer.
	"Library has responsability to free it."
	
	^ FFIExternalArray
		  fromHandle: aHandle
		  type: AeHbGlyphInfo
		  size: (lengthPointer unsignedLongAt: 1)

]

{ #category : #'accessing - output' }
AeHbBuffer >> glyphPositions [
	"Answer an array of `AeHbGlyphPosition` that indicate the position of each glyph of this buffer."

	| lengthPointer aHandle |
	lengthPointer := FFIUInt32 newBuffer.
	aHandle := self getGlyphPositionsOn: lengthPointer.
	"Library has responsability to free."

	^ FFIExternalArray
		  fromHandle: aHandle
		  type: AeHbGlyphPosition
		  size: (lengthPointer unsignedLongAt: 1)

]

{ #category : #'accessing - input' }
AeHbBuffer >> guessSegmentProperties [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-guess-segment-properties"

	^ self ffiCall: #(
		void
		hb_buffer_guess_segment_properties ( self )
		)
]

{ #category : #'accessing - input' }
AeHbBuffer >> invisibleGlyph: invisible [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-invisible-glyph"

	self ffiCall: #(
		void
		hb_buffer_set_invisible_glyph (
			self,
			hb_codepoint_t invisible)
	)
]

{ #category : #'accessing - input' }
AeHbBuffer >> language: aHbLanguage [
	"Establish the received `AeHbLanguage` as language.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-language"

	self ffiCall: #(
		void
		hb_buffer_set_language (
			self,
			hb_language_t aHbLanguage)
	)
]

{ #category : #'accessing - output' }
AeHbBuffer >> length [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-get-length"

	^ self ffiCall: #(
		uint
		hb_buffer_get_length ( self )
		)
]

{ #category : #'shaping text' }
AeHbBuffer >> primShapeWithFont: font features: features numFeatures: num_features [
	"Shapes buffer using font turning its Unicode characters content to positioned glyphs. If features is not NULL, it will be used to control the features applied during shaping. If two features have the same tag but overlapping ranges the value of the feature with the higher index takes precedence.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-shape.html#hb-shape"

	^ self ffiCall: #(
		void
		hb_shape (
			hb_font_t font,
			self,
			"hb_feature_t" void *features,
			uint num_features)
		)
]

{ #category : #'accessing - output' }
AeHbBuffer >> reset [
	"Resets the buffer to its initial status, as if it was just newly created with `hb_buffer_create()`.

	See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-reset"

	self ffiCall: #(
		void
		hb_buffer_reset ( self )
		)
]

{ #category : #'accessing - input' }
AeHbBuffer >> script: script [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-script"

	self ffiCall: #(
		void
		hb_buffer_set_script (
			self,
			hb_script_t script)
	)
]

{ #category : #'shaping text' }
AeHbBuffer >> shapeWithFont: font [

	^ self
		  primShapeWithFont: font
		  features: ExternalAddress null
		  numFeatures: 0
]
