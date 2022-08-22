"
I am a Cairo FFI binding for `cairo_status_t`.

It is used to indicate errors that can occur when using Cairo. In some cases it is returned directly by functions. but when using `cairo_t`, the last error, if any, is stored in the context and can be retrieved with `cairo_status()`.

New entries may be added in future versions. Use `cairo_status_to_string()` to get a human-readable representation of an error message.

See: https://www.cairographics.org/manual/cairo-Error-handling.html#cairo-status-t
"
Class {
	#name : #AeCairoStatus,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_STATUS_CLIP_NOT_REPRESENTABLE',
		'CAIRO_STATUS_DEVICE_ERROR',
		'CAIRO_STATUS_DEVICE_FINISHED',
		'CAIRO_STATUS_DEVICE_TYPE_MISMATCH',
		'CAIRO_STATUS_FILE_NOT_FOUND',
		'CAIRO_STATUS_FONT_TYPE_MISMATCH',
		'CAIRO_STATUS_INVALID_CLUSTERS',
		'CAIRO_STATUS_INVALID_CONTENT',
		'CAIRO_STATUS_INVALID_DASH',
		'CAIRO_STATUS_INVALID_DSC_COMMENT',
		'CAIRO_STATUS_INVALID_FORMAT',
		'CAIRO_STATUS_INVALID_INDEX',
		'CAIRO_STATUS_INVALID_MATRIX',
		'CAIRO_STATUS_INVALID_MESH_CONSTRUCTION',
		'CAIRO_STATUS_INVALID_PATH_DATA',
		'CAIRO_STATUS_INVALID_POP_GROUP',
		'CAIRO_STATUS_INVALID_RESTORE',
		'CAIRO_STATUS_INVALID_SIZE',
		'CAIRO_STATUS_INVALID_SLANT',
		'CAIRO_STATUS_INVALID_STATUS',
		'CAIRO_STATUS_INVALID_STRIDE',
		'CAIRO_STATUS_INVALID_STRING',
		'CAIRO_STATUS_INVALID_VISUAL',
		'CAIRO_STATUS_INVALID_WEIGHT',
		'CAIRO_STATUS_JBIG2_GLOBAL_MISSING',
		'CAIRO_STATUS_NEGATIVE_COUNT',
		'CAIRO_STATUS_NO_CURRENT_POINT',
		'CAIRO_STATUS_NO_MEMORY',
		'CAIRO_STATUS_NULL_POINTER',
		'CAIRO_STATUS_PATTERN_TYPE_MISMATCH',
		'CAIRO_STATUS_READ_ERROR',
		'CAIRO_STATUS_SUCCESS',
		'CAIRO_STATUS_SURFACE_FINISHED',
		'CAIRO_STATUS_SURFACE_TYPE_MISMATCH',
		'CAIRO_STATUS_TEMP_FILE_ERROR',
		'CAIRO_STATUS_USER_FONT_ERROR',
		'CAIRO_STATUS_USER_FONT_IMMUTABLE',
		'CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED',
		'CAIRO_STATUS_WRITE_ERROR'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_CLIP_NOT_REPRESENTABLE [
	"This method was automatically generated"
	^ CAIRO_STATUS_CLIP_NOT_REPRESENTABLE
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_DEVICE_ERROR [
	"This method was automatically generated"
	^ CAIRO_STATUS_DEVICE_ERROR
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_DEVICE_FINISHED [
	"This method was automatically generated"
	^ CAIRO_STATUS_DEVICE_FINISHED
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_DEVICE_TYPE_MISMATCH [
	"This method was automatically generated"
	^ CAIRO_STATUS_DEVICE_TYPE_MISMATCH
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_FILE_NOT_FOUND [
	"This method was automatically generated"
	^ CAIRO_STATUS_FILE_NOT_FOUND
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_FONT_TYPE_MISMATCH [
	"This method was automatically generated"
	^ CAIRO_STATUS_FONT_TYPE_MISMATCH
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_CLUSTERS [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_CLUSTERS
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_CONTENT [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_CONTENT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_DASH [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_DASH
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_DSC_COMMENT [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_DSC_COMMENT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_FORMAT [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_FORMAT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_INDEX [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_INDEX
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_MATRIX [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_MATRIX
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_MESH_CONSTRUCTION [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_MESH_CONSTRUCTION
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_PATH_DATA [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_PATH_DATA
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_POP_GROUP [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_POP_GROUP
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_RESTORE [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_RESTORE
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_SIZE [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_SIZE
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_SLANT [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_SLANT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_STATUS [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_STATUS
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_STRIDE [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_STRIDE
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_STRING [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_STRING
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_VISUAL [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_VISUAL
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_INVALID_WEIGHT [
	"This method was automatically generated"
	^ CAIRO_STATUS_INVALID_WEIGHT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_JBIG2_GLOBAL_MISSING [
	"This method was automatically generated"
	^ CAIRO_STATUS_JBIG2_GLOBAL_MISSING
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_NEGATIVE_COUNT [
	"This method was automatically generated"
	^ CAIRO_STATUS_NEGATIVE_COUNT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_NO_CURRENT_POINT [
	"This method was automatically generated"
	^ CAIRO_STATUS_NO_CURRENT_POINT
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_NO_MEMORY [
	"This method was automatically generated"
	^ CAIRO_STATUS_NO_MEMORY
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_NULL_POINTER [
	"This method was automatically generated"
	^ CAIRO_STATUS_NULL_POINTER
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_PATTERN_TYPE_MISMATCH [
	"This method was automatically generated"
	^ CAIRO_STATUS_PATTERN_TYPE_MISMATCH
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_READ_ERROR [
	"This method was automatically generated"
	^ CAIRO_STATUS_READ_ERROR
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_SUCCESS [
	"This method was automatically generated"
	^ CAIRO_STATUS_SUCCESS
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_SURFACE_FINISHED [
	"This method was automatically generated"
	^ CAIRO_STATUS_SURFACE_FINISHED
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_SURFACE_TYPE_MISMATCH [
	"This method was automatically generated"
	^ CAIRO_STATUS_SURFACE_TYPE_MISMATCH
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_TEMP_FILE_ERROR [
	"This method was automatically generated"
	^ CAIRO_STATUS_TEMP_FILE_ERROR
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_USER_FONT_ERROR [
	"This method was automatically generated"
	^ CAIRO_STATUS_USER_FONT_ERROR
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_USER_FONT_IMMUTABLE [
	"This method was automatically generated"
	^ CAIRO_STATUS_USER_FONT_IMMUTABLE
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED [
	"This method was automatically generated"
	^ CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED
]

{ #category : #'accessing enum' }
AeCairoStatus class >> CAIRO_STATUS_WRITE_ERROR [
	"This method was automatically generated"
	^ CAIRO_STATUS_WRITE_ERROR
]

{ #category : #'enum declaration' }
AeCairoStatus class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_STATUS_SUCCESS 0

		CAIRO_STATUS_NO_MEMORY 1
		CAIRO_STATUS_INVALID_RESTORE 2
		CAIRO_STATUS_INVALID_POP_GROUP 3
		CAIRO_STATUS_NO_CURRENT_POINT 4
		CAIRO_STATUS_INVALID_MATRIX 5
		CAIRO_STATUS_INVALID_STATUS 6
		CAIRO_STATUS_NULL_POINTER 7
		CAIRO_STATUS_INVALID_STRING 8
		CAIRO_STATUS_INVALID_PATH_DATA 9
		CAIRO_STATUS_READ_ERROR 10
		CAIRO_STATUS_WRITE_ERROR 11
		CAIRO_STATUS_SURFACE_FINISHED 12
		CAIRO_STATUS_SURFACE_TYPE_MISMATCH 13
		CAIRO_STATUS_PATTERN_TYPE_MISMATCH 14
		CAIRO_STATUS_INVALID_CONTENT 15
		CAIRO_STATUS_INVALID_FORMAT 16
		CAIRO_STATUS_INVALID_VISUAL 17
		CAIRO_STATUS_FILE_NOT_FOUND 18
		CAIRO_STATUS_INVALID_DASH 19
		CAIRO_STATUS_INVALID_DSC_COMMENT 20
		CAIRO_STATUS_INVALID_INDEX 21
		CAIRO_STATUS_CLIP_NOT_REPRESENTABLE 22
		CAIRO_STATUS_TEMP_FILE_ERROR 23
		CAIRO_STATUS_INVALID_STRIDE 24
		CAIRO_STATUS_FONT_TYPE_MISMATCH 25
		CAIRO_STATUS_USER_FONT_IMMUTABLE 26
		CAIRO_STATUS_USER_FONT_ERROR 27
		CAIRO_STATUS_NEGATIVE_COUNT 28
		CAIRO_STATUS_INVALID_CLUSTERS 29
		CAIRO_STATUS_INVALID_SLANT 30
		CAIRO_STATUS_INVALID_WEIGHT 31
		CAIRO_STATUS_INVALID_SIZE 32
		CAIRO_STATUS_USER_FONT_NOT_IMPLEMENTED 33
		CAIRO_STATUS_DEVICE_TYPE_MISMATCH 34
		CAIRO_STATUS_DEVICE_ERROR 35
		CAIRO_STATUS_INVALID_MESH_CONSTRUCTION 36
		CAIRO_STATUS_DEVICE_FINISHED 37
		CAIRO_STATUS_JBIG2_GLOBAL_MISSING 38
	)
]

{ #category : #testing }
AeCairoStatus >> isSuccess [

	^ self = self class CAIRO_STATUS_SUCCESS
]
