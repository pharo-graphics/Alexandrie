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

{ #category : #finalization }
AeHbBlob class >> externallyFree: aHandle [
	"Decreases the reference count on blob, and if it reaches zero, destroys blob, freeing all memory, possibly calling the destroy-callback the blob was created for if it has not been called already.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-destroy"

	self ffiCall: #( void hb_blob_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbBlob class >> newEmpty [
	"Answer a new Pharo object whose handle is the singleton empty blob.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-get-empty"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_get_empty (void)
	)
]

{ #category : #'instance creation' }
AeHbBlob class >> newFrom: aByteArray [

	^ self
		unownedNewFrom: aByteArray
		ifSuccess: [ :b | b autoRelease; yourself ]
		ifFail: [ self error: 'Harfbuzz failed to read data' ]
]

{ #category : #'instance creation' }
AeHbBlob class >> newLocatedAt: aFileReference [

	^ self
		unownedNewLocatedAt: aFileReference
		ifSuccess: [ :b | b autoRelease; yourself ]
		ifFail: [
			self error: 'Harfbuzz failed to read: ',
							aFileReference pathString ]
]

{ #category : #'instance creation' }
AeHbBlob class >> unownedNewFrom: aByteArray ifSuccess: successBlock ifFail: failedBlock [

	| blob |
	blob := self unownedNewFrom: aByteArray size: aByteArray size.

	^ blob isEmpty
		ifFalse: [ successBlock value: blob ]
		ifTrue: [ failedBlock value ]
]

{ #category : #'instance creation' }
AeHbBlob class >> unownedNewFrom: data size: dataSize [
	"Answer a new object wrapping data, or the empty singleton if failed. User must destroy the answer in former case.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-create"

	^ self
		ffiCall: #(
			hb_blob_t *
			hb_blob_create (
				const char *data,
				int dataSize,
				1, "HB_MEMORY_MODE_READONLY"
				nil,
				nil ) )
		options: #( - optStrict )
]

{ #category : #'instance creation' }
AeHbBlob class >> unownedNewLocatedAt: aPathString [
	"Creates a new blob containing the data from the specified binary font file.
	Returns: An hb_blob_t pointer with the content of the file, or hb_blob_get_empty() if failed.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-create-from-file"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_create_from_file (const char *aPathString)
	)
]

{ #category : #'instance creation' }
AeHbBlob class >> unownedNewLocatedAt: aFileReference ifSuccess: successBlock ifFail: failedBlock [

	| blob |
	blob := self unownedNewLocatedAtOrFail: aFileReference pathString.

	^ blob getHandle isNull
		ifFalse: [ successBlock value: blob ]
		ifTrue: [ failedBlock value ]
]

{ #category : #'instance creation' }
AeHbBlob class >> unownedNewLocatedAtOrFail: aPathString [
	"Answer the address of a new blob containing the data from the specified binary font file.
	Return NULL if failed.

	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-create-from-file-or-fail"

	^ self ffiCall: #(
		hb_blob_t *
		hb_blob_create_from_file_or_fail (const char *aPathString)
	)
]

{ #category : #accessing }
AeHbBlob >> faceCount [
	"Answer the number of faces in this bloc.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-get-length"

	^ self ffiCall: #(
		uint
		hb_face_count ( self ) )
]

{ #category : #testing }
AeHbBlob >> isEmpty [
	
	^ self faceCount isZero
]

{ #category : #accessing }
AeHbBlob >> length [
	"See: https://harfbuzz.github.io/harfbuzz-hb-blob.html#hb-blob-get-length"

	^ self ffiCall: #(
		uint
		hb_blob_get_length ( self ) )
]

{ #category : #'instance creation' }
AeHbBlob >> newHbFaceAtIndex: zeroBasedIndex [ 

	^ AeHbFace newForBlob: self index: zeroBasedIndex
]

{ #category : #'instance creation' }
AeHbBlob >> newHbFaces [

	^ (0 to: self faceCount - 1)
			collect: [ :i | self newHbFaceAtIndex: i ]
]

{ #category : #printing }
AeHbBlob >> printOn: aStream [

	self isNull ifTrue: [ ^ super printOn: aStream ].

	aStream
		nextPutAll: 'an ';
		nextPutAll: self className;
		nextPutAll: '(';
		print: self faceCount;
		nextPutAll: ' faces)'
]
