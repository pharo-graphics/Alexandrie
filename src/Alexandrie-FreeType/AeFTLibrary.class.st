"
I am a FreeType FFI binding to `FT_Library`.

A `FT_Library` is a handle to a FreeType library instance. Each ‘library’ is completely independent from the others; it is the ‘root’ of a set of objects like fonts, faces, sizes, etc.

See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_library
"
Class {
	#name : #AeFTLibrary,
	#superclass : #FFIExternalObject,
	#traits : 'AeTFreeTypeLibrary',
	#classTraits : 'AeTFreeTypeLibrary classTrait',
	#category : #'Alexandrie-FreeType'
}

{ #category : #'as yet unclassified' }
AeFTLibrary class >> finalizeResourceData: aHandle [

	aHandle isNull ifTrue: [ ^ self ].
	self primDoneFreeType: aHandle.
	aHandle beNull

]

{ #category : #'instance creation' }
AeFTLibrary class >> newInitialized [

	| aPointer returnCode |
	aPointer := ExternalAddress new.

	returnCode := self primInitFreeType: aPointer.

	returnCode = 0 ifFalse: [ AeFreeTypeError signalForCode: returnCode ].

	^ (self fromHandle: aPointer)
		  autoRelease;
		  yourself
]

{ #category : #'as yet unclassified' }
AeFTLibrary class >> primDoneFreeType: aHandle [
	"Destroy a given FreeType library object and all of its children, including resources, drivers, faces, sizes, etc.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_done_freetype"

	^ self ffiCall: #(
		int 
		FT_Done_FreeType (
			void * aHandle ))

]

{ #category : #'as yet unclassified' }
AeFTLibrary class >> primInitFreeType: aPointer [
	"Initialize a new FreeType library object.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_init_freetype"

	^ self ffiCall: #(
		int
		FT_Init_FreeType (
			void ** aPointer ))
]

{ #category : #'private - ffi' }
AeFTLibrary >> facesOn: aFileReference [
	"Answer all the faces in a file path."

	^ Array streamContents: [ :aStream |
		self
			facesOn: aFileReference
			do: [ :each | aStream nextPut: each ]]

]

{ #category : #'private - ffi' }
AeFTLibrary >> facesOn: aFileReference do: aBlock [
	"Iterate over the faces in a file path.
	The official documentation recommends this implementation with an invalid index.
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| faceIndex numberOfFaces |
	faceIndex := 0.
	
	[	| aPointer returnCode aFace |
		aPointer := ExternalAddress new.
		returnCode := self 
			primNewFace: aPointer 
			path: aFileReference pathString 
			index: faceIndex.

		returnCode = 0 ifFalse: [ ^ self ].

		aFace := (AeFTFace fromHandle: aPointer)
			autoRelease;
			yourself.			
		aBlock value: aFace.

		faceIndex = 0 ifTrue: [
			numberOfFaces := aFace numberOfFaces ].
			
		faceIndex := faceIndex + 1 ] doWhileTrue: [ faceIndex < numberOfFaces ]
]

{ #category : #'private - ffi' }
AeFTLibrary >> newFile: aFileReference index: anInteger [

	| aPointer returnCode |

	aPointer := ExternalAddress new.
	
	returnCode := self primNewFace: aPointer path: aFileReference pathString index: anInteger.

	returnCode = 0 ifFalse: [
		AeFreeTypeError signalForCode: returnCode ].
		
	^ (AeFTFace fromHandle: aPointer)
		autoRelease;
		yourself
]

{ #category : #'private - ffi' }
AeFTLibrary >> numberOfFacesOn: aFileReference [
	"Answer the number of faces in a file path.
	The official documentation recommends this implementation with an invalid index.
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| aFaceRec |
	aFaceRec := self newFile: aFileReference index: -1.
	^ aFaceRec numberOfFaces

]

{ #category : #'private - ffi' }
AeFTLibrary >> primNewFace: aFaceAddress path: filepathname index: face_index [
	"Create a new FT_Face object, answered in the pointer. Use FT_Done_Face to destroy it. 
	Return a FreeType error code. 0 means success.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_new_face"

	^ self ffiCall: #(
		int
		FT_New_Face(
			self,
			String filepathname,
			"FT_Long" long face_index,
			"FT_Face" void ** aFaceAddress ))

]
