"
I represent FFI bindings to `hb_blob_t`: Binary data containers.

Blobs wrap a chunk of binary data to handle lifecycle management of data while it is passed between client and HarfBuzz. Blobs are primarily used to create font faces, but also to access font face tables, as well as pass around other binary data.

See: https://harfbuzz.github.io/harfbuzz-hb-blob.html
"
Class {
	#name : #AeHbBlob,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #'instance creation' }
AeHbBlob class >> blobCreate: aFileReference [

	| pathString blob |
	pathString := aFileReference pathString "utf8Encoded".

	blob := self primBlobCreateOrFail: pathString.

	blob getHandle isNull ifTrue: [
		self error: 'Failed to open file: ', aFileReference pathString ].
	
	^ blob
		  autoRelease;
		  yourself
]

{ #category : #finalization }
AeHbBlob class >> externallyFree: aHandle [
	"Decreases the reference count on blob, and if it reaches zero, destroys blob, freeing all memory, possibly calling the destroy-callback the blob was created for if it has not been called already.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-destroy"

	self ffiCall: #( void hb_blob_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbBlob class >> primBlobCreate: file_name [
	"Creates a new blob containing the data from the specified binary font file.
	Returns: An hb_blob_t pointer with the content of the file, or hb_blob_get_empty() if failed.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-create-from-file"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_create_from_file (const char *file_name)
	)
]

{ #category : #'instance creation' }
AeHbBlob class >> primBlobCreateOrFail: file_name [
	"Creates a new blob containing the data from the specified binary font file.
	Returns: An hb_blob_t pointer with the content of the file, or NULL if failed.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-create-from-file-or-fail"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_create_from_file_or_fail (const char *file_name)
	)
]

{ #category : #'instance creation' }
AeHbBlob class >> primBlobGetEmpty [
	"Returns the singleton empty blob.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-get-empty"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_get_empty (void)
	)
]

{ #category : #accessing }
AeHbBlob >> primGetLength [
	"See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-get-length"

	^ self ffiCall: #(
		uint
			hb_blob_get_length (self)
		)
]
