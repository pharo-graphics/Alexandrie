"
I represent FFI bindings to `hb_face_t`: Font face objects.

A font face is an object that represents a single face from within a font family.

More precisely, a font face represents a single face in a binary font file. Font faces are typically built from a binary blob and a face index. Font faces are used to create fonts.

See: https://harfbuzz.github.io/harfbuzz-hb-face.html
"
Class {
	#name : #AeHbFace,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFace class >> externallyFree: aHandle [

	self ffiCall: #( void hb_face_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbFace class >> newForBlob: blob index: index [

	^ (self unownedNewForBlob: blob index: index)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> newForFTFaceCached: ft_face [

	^ (self unownedNewForFTFaceCached: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> newForFTFaceReferenced: ft_face [

	^ (self unownedNewForFTFaceReferenced: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForBlob: blob index: index [
	"Constructs a new face object from the specified blob and a face index into that blob.

	The face index is used for blobs of file formats such as TTC and and DFont that can contain more than one face. Face indices within such collections are zero-based.

	See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-create"

	^ self ffiCall: #(
		hb_face_t *
		hb_face_create (
			hb_blob_t blob,
			uint index)
		)
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForFTFaceCached: ft_face [
	"Creates an `hb_face_t` face object from the specified `FT_Face`.

	This variant of the function caches the newly created `hb_face_t` face object, using the generic pointer of `ft_face`.
	Subsequent function calls that are passed the same `ft_face` parameter will have the same `hb_face_t` returned to them, and that `hb_face_t` will be correctly reference counted.

	However, client programs are still responsible for destroying `ft_face` after the last `hb_face_t` face object has been destroyed.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-face-create-cached"

	^ self ffiCall: #(
		hb_face_t
		hb_ft_face_create_cached (AeFTFace * ft_face)
		)
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForFTFaceReferenced: ft_face [
	"Creates an `hb_face_t` face object from the specified `FT_Face`.

	This is the preferred variant of the `hb_ft_font_create`* function family, because it calls `FT_Reference_Face()` on ft_face , ensuring that ft_face remains alive as long as the resulting `hb_font_t` font object remains alive.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-create-referenced"

	^ self ffiCall: #(
		hb_face_t
		hb_ft_face_create_referenced (AeFTFace * ft_face)
		)
]

{ #category : #accessing }
AeHbFace >> allOpenTypePredefinedNamesAsDictionary [

	| result |
	result := OrderedDictionary new.
	
	AeHbOpenTypePredefinedNameId allValues do: [ :each |
		result at: each item put: (self openTypeName: each) ].

	^ result 
]

{ #category : #accessing }
AeHbFace >> getOpenTypeFeatureTagsAt: tag offset: offset into: featuresAddress size: featureSizeAddress [
	"Fetches a list of all feature tags in the given face's GSUB or GPOS table. Note that there might be duplicate feature tags, belonging to different script/language-system pairs of the table.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-layout.html#hb-ot-layout-table-get-feature-tags"

	^ self ffiCall: #(
		uint
		hb_ot_layout_table_get_feature_tags (
			self,
			hb_tag_t tag,
			uint offset,
			uint * featureSizeAddress,
			void * featuresAddress )
		)
]

{ #category : #accessing }
AeHbFace >> getOpenTypeUtf8Name: nameId into: text num: textSize language: language [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ot-name.html#hb-ot-name-get-utf8"

	^ self ffiCall: #(
		uint
		hb_ot_name_get_utf8 (
			self,
			"hb_ot_name_id_t" uint nameId,
			hb_language_t language,
			uint *textSize,
			char *text) )
]

{ #category : #accessing }
AeHbFace >> glyphCount [
	"See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-get-glyph-count"

	^ self ffiCall: #(
		uint
		hb_face_get_glyph_count ( self ) )
]

{ #category : #testing }
AeHbFace >> hasColor [
	"Answer whether this font can have colors.
	
	Based on helper_cairo_scaled_font_has_color function in harfbuzz/util/helper-cairo.hh"

	^ self hasPng or: [ self hasLayers or: [ self hasPaint ] ]
]

{ #category : #testing }
AeHbFace >> hasLayers [
	"Answer whether this face includes a COLR table with data according to COLRv0.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-layers"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_layers ( self ) )
]

{ #category : #testing }
AeHbFace >> hasPaint [
	"Answer whether this face includes a COLR table with data according to COLRv1.
	
	Introduced in Harfbuzz v7.0.0.

	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-paint"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_paint ( self ) )
]

{ #category : #testing }
AeHbFace >> hasPng [
	"Answer whether this face has PNG glyph images (either in CBDT or sbix tables).
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-png"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_png ( self ) )
]

{ #category : #'instance creation' }
AeHbFace >> newHbFont [
	"Answer a new `AeHbFont` from me"

	^ AeHbFont newForHbFace: self
]

{ #category : #accessing }
AeHbFace >> openTypeFeatureTags [

	| featureTags featureTagsSize features |
	self flag: #todo. "Iteration does not work well (try reducing the array's size)"
	featureTags := FFIExternalArray newType: FFIUInt32 size: 5000.
	featureTagsSize := FFIUInt32 newBuffer.
	featureTagsSize unsignedLongAt: 1 put: featureTags size.
	features := OrderedCollection new.
	
	#('GSUB' 'GPOS') do: [ :eachTag |
		| actualSize offset atEnd |
		offset := 0.
		[	actualSize :=
				self
					getOpenTypeFeatureTagsAt: eachTag asHbTagInteger
					offset: offset
					into: featureTags getHandle
					size: featureTagsSize.

			featureTags size + offset >= actualSize
				ifTrue: [
					atEnd := true.
					1 to: actualSize - offset do: [ :i |
						features add: (featureTags at: i) ] ]
				ifFalse: [ 
					atEnd := false.
					features addAll: featureTags.
					offset := offset + featureTags size ]

		] doWhileFalse: [ atEnd ] ].

	^ features collect: #asHbTagString
]

{ #category : #accessing }
AeHbFace >> openTypeFontFamily [

	^ self openTypeName: AeHbOpenTypePredefinedNameId fontFamily
]

{ #category : #accessing }
AeHbFace >> openTypeFontSubfamily [

	^ self openTypeName: AeHbOpenTypePredefinedNameId fontSubfamily
]

{ #category : #accessing }
AeHbFace >> openTypeFullName [
	
	^ self openTypeName: AeHbOpenTypePredefinedNameId fullName
]

{ #category : #accessing }
AeHbFace >> openTypeName: nameId [

	| textAddress textSizeAddress result len |
	len := 64.
	textAddress := ExternalAddress allocate: len.
	textSizeAddress := FFIUInt32 newBuffer.
	textSizeAddress uint32AtOffset: 0 put: len.

	self
		getOpenTypeUtf8Name: nameId
		into: textAddress
		num: textSizeAddress
		language: AeHbLanguage en.
	
	result := textAddress utf8StringFromCString.
	textAddress free.
	^ result
]

{ #category : #printing }
AeHbFace >> printOn: aStream [

	self isNull ifTrue: [ ^ super printOn: aStream ].

	aStream
		nextPutAll: 'an ';
		nextPutAll: self className;
		nextPutAll: '(';
		nextPutAll: self openTypeFontFamily;
		nextPutAll: ', ';
		nextPutAll: self openTypeFontSubfamily;
		nextPutAll: ')'
]

{ #category : #accessing }
AeHbFace >> unitsPerEm [
	"Answer my units-per-em (UPEM) value.

	Typical UPEM values for fonts are 1000, or 2048, but any value in between 16 and 16,384 is allowed for OpenType fonts.

	See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-get-upem"

	^ self ffiCall: #(
		uint
		hb_face_get_upem ( self ) )
]
