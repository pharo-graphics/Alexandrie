"
I represent FFI bindings to `hb_face_t`: Font face objects.

A font face is an object that represents a single face from within a font family.

More precisely, a font face represents a single face in a binary font file. Font faces are typically built from a binary blob and a face index. Font faces are used to create fonts.

See: https://harfbuzz.github.io/harfbuzz-hb-face.html
"
Class {
	#name : #AeHbFace,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeHbTDestroy',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeHbTDestroy classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFace class >> destroyHandle: aHandle [

	self ffiCall: #( void hb_face_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbFace class >> primFaceCreateInBlob: blob index: index [
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
