"
I represent FFI bindings to `hb_buffer_t`: Input and output buffers.

Buffers serve a dual role in HarfBuzz; before shaping, they hold the input characters that are passed to `hb_shape()`, and after shaping they hold the output glyphs.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html
"
Class {
	#name : #AeHbBuffer,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeHbTDestroy',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeHbTDestroy classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #'instance creation' }
AeHbBuffer class >> bufferCreate [

	^ self primBufferCreate
		autoRelease;
		yourself

]

{ #category : #'instance creation' }
AeHbBuffer class >> new [

	^ self shouldNotImplement
]

{ #category : #'instance creation' }
AeHbBuffer class >> primBufferCreate [

	^ self ffiCall: #(
		hb_buffer_t *
		hb_buffer_create (void)
	)
]

{ #category : #finalization }
AeHbBuffer class >> primDestroy: aHandle [

	self ffiCall: #(
		void
		hb_buffer_destroy (void *aHandle)
		)
]

{ #category : #accessing }
AeHbBuffer >> addUtf8String: aString [

	| encoded |
	encoded := aString utf8Encoded.
	self primBufferAddUtf8: encoded length: encoded size itemOffset: 0 itemLength: encoded size

]

{ #category : #'instance creation' }
AeHbBuffer >> glyphInfos [

	| lengthPointer aHandle |
	lengthPointer := FFIUInt32 newBuffer.
	aHandle := self primGetGlyphInfos: lengthPointer.
	"Library has responsability to free."
	
	^ FFIExternalArray
		  fromHandle: aHandle
		  type: AeHbGlyphInfo
		  size: (lengthPointer unsignedLongAt: 1)

]

{ #category : #'instance creation' }
AeHbBuffer >> glyphPositions [

	| lengthPointer aHandle |
	lengthPointer := FFIUInt32 newBuffer.
	aHandle := self primGetGlyphPositions: lengthPointer.
	"Library has responsability to free."

	^ FFIExternalArray
		  fromHandle: aHandle
		  type: AeHbGlyphPosition
		  size: (lengthPointer unsignedLongAt: 1)

]

{ #category : #accessing }
AeHbBuffer >> primBufferAddUtf8: text length: text_length itemOffset: item_offset itemLength: item_length [
	"See https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-add-utf8"

	^ self ffiCall: #(
		void
		hb_buffer_add_utf8 (
			self,
			char *text,
			int text_length,
			uint item_offset,
			int item_length)
	)
]

{ #category : #accessing }
AeHbBuffer >> primBufferSetDirection: direction [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-direction"

	^ self ffiCall: #(
		void
		hb_buffer_set_direction (
			self,
			hb_direction_t direction)
	)
]

{ #category : #accessing }
AeHbBuffer >> primBufferSetLanguage: language [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-language"

	^ self ffiCall: #(
		void
		hb_buffer_set_language (
			self,
			hb_language_t language)
	)
]

{ #category : #accessing }
AeHbBuffer >> primBufferSetScript: script [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-set-script"

	^ self ffiCall: #(
		void
		hb_buffer_set_script (
			self,
			hb_script_t script)
	)
]

{ #category : #'instance creation' }
AeHbBuffer >> primGetGlyphInfos: length [
	"Returns buffer glyph information array. Returned pointer is valid as long as buffer contents are not modified.

	See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-get-glyph-infos"

	^ self ffiCall: #(
		"hb_glyph_info_t" void *
		hb_buffer_get_glyph_infos (
			self,
			uint *length)
		)
]

{ #category : #'instance creation' }
AeHbBuffer >> primGetGlyphPositions: length [
	"See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-get-glyph-positions"

	^ self ffiCall: #(
		"hb_glyph_position_t" void *
		hb_buffer_get_glyph_positions (
			self,
			uint *length)
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

{ #category : #'shaping text' }
AeHbBuffer >> shapeWithFont: font [

	^ self
		  primShapeWithFont: font
		  features: ExternalAddress null
		  numFeatures: 0
]
