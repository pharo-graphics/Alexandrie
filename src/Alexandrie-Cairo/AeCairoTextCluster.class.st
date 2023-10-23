"
I am a Cairo FFI binding for `cairo_text_cluster_t`.

This structure holds information about a single text cluster. A text cluster is a minimal mapping of some glyphs corresponding to some UTF-8 text.

For a cluster to be valid, both byteCount and glyphCount should be non-negative, and at least one should be non-zero. Note that clusters with zero glyphs are not as well supported as normal clusters. For example, PDF rendering applications typically ignore those clusters when PDF text is being selected.

See: https://www.cairographics.org/manual/cairo-text.html#cairo-text-cluster-t
"
Class {
	#name : #AeCairoTextCluster,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_BYTECOUNT',
		'OFFSET_GLYPHCOUNT'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #'field definition' }
AeCairoTextCluster class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		int byteCount
		int glyphCount
		)
]

{ #category : #'accessing - structure variables' }
AeCairoTextCluster >> byteCount [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_BYTECOUNT
]

{ #category : #'accessing - structure variables' }
AeCairoTextCluster >> byteCount: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_BYTECOUNT put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoTextCluster >> glyphCount [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_GLYPHCOUNT
]

{ #category : #'accessing - structure variables' }
AeCairoTextCluster >> glyphCount: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_GLYPHCOUNT put: anObject
]
