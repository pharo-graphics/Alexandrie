"
I have common type substitutions for Harfbuzz FFI bindings.
"
Class {
	#name : #AeHbTypes,
	#superclass : #SharedPool,
	#classVars : [
		'hb_blob_t',
		'hb_bool_t',
		'hb_buffer_cluster_level_t',
		'hb_buffer_flags_t',
		'hb_buffer_t',
		'hb_codepoint_t',
		'hb_direction_t',
		'hb_face_t',
		'hb_font_t',
		'hb_glyph_info_t',
		'hb_glyph_position_t',
		'hb_language_t',
		'hb_mask_t',
		'hb_position_t',
		'hb_script_t',
		'hb_segment_properties_t',
		'hb_tag_t',
		'hb_var_int_t',
		'int32_t',
		'uint32_t'
	],
	#category : #'Alexandrie-Harfbuzz-Library'
}

{ #category : #initialization }
AeHbTypes class >> initialize [

	hb_bool_t := 'bool'.
	
	uint32_t := 'uint32'.
	hb_codepoint_t := uint32_t.
	hb_mask_t := uint32_t.
	hb_tag_t := uint32_t.
	hb_var_int_t := uint32_t.

	int32_t := 'int32'.
	hb_position_t := int32_t.

	hb_buffer_t := AeHbBuffer.
	hb_direction_t := AeHbDirection.
	hb_script_t := AeHbScript.
	hb_blob_t := AeHbBlob.
	hb_face_t := AeHbFace.
	hb_font_t := AeHbFont.
	hb_language_t := AeHbLanguage.
	hb_glyph_info_t := AeHbGlyphInfo.
	hb_glyph_position_t := AeHbGlyphPosition.
	hb_buffer_cluster_level_t := AeHbBufferClusterLevel.
	hb_buffer_flags_t := AeHbBufferFlags.
	hb_segment_properties_t := AeHbSegmentProperties
]
