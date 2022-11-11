"
I represent FFI bindings to `hb_buffer_cluster_level_t` enum: Data type for holding HarfBuzz's clustering behavior options. 

The cluster level dictates one aspect of how HarfBuzz will treat non-base characters during shaping.

In `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES`, non-base characters are merged into the cluster of the base character that precedes them.

In `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS`, non-base characters are initially assigned their own cluster values, which are not merged into preceding base clusters. This allows HarfBuzz to perform additional operations like reorder sequences of adjacent marks.

`HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES` is the default, because it maintains backward compatibility with older versions of HarfBuzz. New client programs that do not need to maintain such backward compatibility are recommended to use `HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS` instead of the default.

See: https://harfbuzz.github.io/harfbuzz-hb-buffer.html#hb-buffer-cluster-level-t
"
Class {
	#name : #AeHbBufferClusterLevel,
	#superclass : #AeEnumeration,
	#classVars : [
		'HB_BUFFER_CLUSTER_LEVEL_CHARACTERS',
		'HB_BUFFER_CLUSTER_LEVEL_DEFAULT',
		'HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS',
		'HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES'
	],
	#category : #'Alexandrie-Harfbuzz-Enumerations'
}

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> HB_BUFFER_CLUSTER_LEVEL_CHARACTERS [
	"This method was automatically generated"
	^ HB_BUFFER_CLUSTER_LEVEL_CHARACTERS
]

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> HB_BUFFER_CLUSTER_LEVEL_DEFAULT [
	"This method was automatically generated"
	^ HB_BUFFER_CLUSTER_LEVEL_DEFAULT
]

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS [
	"This method was automatically generated"
	^ HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS
]

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES [
	"This method was automatically generated"
	^ HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES
]

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> default [

	^ HB_BUFFER_CLUSTER_LEVEL_DEFAULT
]

{ #category : #'enum declaration' }
AeHbBufferClusterLevel class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
	  HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES 0
	  HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS 1
	  HB_BUFFER_CLUSTER_LEVEL_CHARACTERS 2
	  HB_BUFFER_CLUSTER_LEVEL_DEFAULT 0
	)
]

{ #category : #'accessing enum' }
AeHbBufferClusterLevel class >> recommended [
	"Answer the recommended value. Harfbuzz documentation says:

	`HB_BUFFER_CLUSTER_LEVEL_MONOTONE_GRAPHEMES` is the default, because it maintains
	backward compatibility with older versions of HarfBuzz. New client programs that
	do not need to maintain such backward compatibility are recommended to use
	`HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS` instead of the default."

	^ HB_BUFFER_CLUSTER_LEVEL_MONOTONE_CHARACTERS
]

{ #category : #hook }
AeHbBufferClusterLevel class >> underlinedNamePrefix [
	
	^ 'HB_BUFFER_CLUSTER_LEVEL_'
]
