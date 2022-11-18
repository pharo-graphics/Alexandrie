"
I am a FreeType FFI binding to `FT_Library`.

A `FT_Library` is a handle to a FreeType library instance. Each ‘library’ is completely independent from the others; it is the ‘root’ of a set of objects like fonts, faces, sizes, etc.

See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_library
"
Class {
	#name : #AeFTLibrary,
	#superclass : #FFIExternalObject,
	#traits : 'AeTFreeTypeLibrary + AeTExternalFree',
	#classTraits : 'AeTFreeTypeLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #finalization }
AeFTLibrary class >> externallyFree: aHandle [
	"Destroy a given FreeType library object and all of its children, including resources, drivers, faces, sizes, etc.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_done_freetype"

	^ self ffiCall: #(
		int 
		FT_Done_FreeType (
			void * aHandle ) )

]

{ #category : #'instance creation' }
AeFTLibrary class >> newInitialized [

	| aPointer errorCode |
	aPointer := ExternalAddress new.

	errorCode := self unownedNewInitializedOn: aPointer.

	errorCode = 0 ifFalse: [ AeFreeTypeError signalForCode: errorCode ].

	^ (self fromHandle: aPointer)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeFTLibrary class >> unownedNewInitializedOn: aPointer [
	"Initialize a new FreeType library object. Answer an error code.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_init_freetype"

	^ self ffiCall: #(
		int
		FT_Init_FreeType (
			void ** aPointer ))
]

{ #category : #iteration }
AeFTLibrary >> facesOn: aFileReference [
	"Answer all the faces in a file path."

	^ Array streamContents: [ :aStream |
		self
			unownedNewFacesFromFile: aFileReference
			withIndexDo: [ :eachFace :index |
				eachFace autoRelease.
				aStream nextPut: eachFace ] ]
]

{ #category : #iteration }
AeFTLibrary >> fastReadFacesOn: aFileReference do: aBlock [
	"Iterate over all the faces in a file path. 
	IMPORTANT: The Face will be freed (done) after each iteration."

	self
		unownedNewFacesFromFile: aFileReference
		withIndexDo: [ :eachFace :index |
			aBlock value: eachFace value: index.
			eachFace externallyFree ]
]

{ #category : #iteration }
AeFTLibrary >> fastReadFacesOnMemory: aByteArray do: aBlock [
	"Iterate over all the faces in a given ByteArray.
	IMPORTANT: The Face will be freed (done) after each iteration."

	self
		unownedNewFacesFromBytes: aByteArray
		withIndexDo: [ :eachFace :index |
			aBlock value: eachFace value: index.
			eachFace externallyFree ]
]

{ #category : #'private - ffi' }
AeFTLibrary >> getVersionOnMajor: majorPointer minor: minorPointer patch: patchPointer [
	"See: https://freetype.org/freetype2/docs/reference/ft2-version.html#ft_library_version"

	self ffiCall: #(
		void
		FT_Library_Version (
			self,
			int * majorPointer,
			int * minorPointer,
			int * patchPointer ) )

]

{ #category : #'instance creation' }
AeFTLibrary >> newFaceFromBytes: aByteArray index: aZeroBasedIndex [

	| aPointer returnCode |
	aPointer := ExternalAddress new.
	
	returnCode := self
		unownedNewFaceOn: aPointer
		fromBytes: aByteArray
		size: aByteArray size 
		index: aZeroBasedIndex.

	returnCode = 0 ifFalse: [
		AeFreeTypeError signalForCode: returnCode ].
		
	^ (AeFTFace fromHandle: aPointer)
		autoRelease;
		yourself
]

{ #category : #'instance creation' }
AeFTLibrary >> newFaceFromFile: aFileReference index: aZeroBasedIndex [

	| aPointer returnCode |
	aPointer := ExternalAddress new.
	
	returnCode := self
		unownedNewFaceOn: aPointer
		fromPath: aFileReference pathString
		index: aZeroBasedIndex.

	returnCode = 0 ifFalse: [
		AeFreeTypeError signalForCode: returnCode ].
		
	^ (AeFTFace fromHandle: aPointer)
		autoRelease;
		yourself
]

{ #category : #accessing }
AeFTLibrary >> numberOfFacesOn: aFileReference [
	"Answer the number of faces in a file path.
	The official documentation recommends this implementation with an invalid index.
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| aFaceRec |
	aFaceRec := self newFaceFromFile: aFileReference index: -1.
	^ aFaceRec numberOfFaces

]

{ #category : #'private - ffi' }
AeFTLibrary >> unownedNewFaceOn: aFaceAddress fromBytes: fileBase size: fileSize index: faceIndex [
	"Create a new FT_Face object, answered in the pointer. Sender must free.
	Return an error code. 0 means success.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_new_memory_face"

	^ self ffiCall: #(
		int
		FT_New_Memory_Face(
			self,
			"FT_Byte" void * fileBase,
			"FT_Long" long fileSize,
			"FT_Long" long faceIndex,
			"FT_Face" void ** aFaceAddress ))

]

{ #category : #'private - ffi' }
AeFTLibrary >> unownedNewFaceOn: aFaceAddress fromPath: filepathname index: face_index [
	"Create a new FT_Face object, answered in the pointer. Use FT_Done_Face to destroy it. 
	Return an error code. 0 means success.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_new_face"

	^ self ffiCall: #(
		int
		FT_New_Face(
			self,
			String filepathname,
			"FT_Long" long face_index,
			"FT_Face" void ** aFaceAddress ))

]

{ #category : #iteration }
AeFTLibrary >> unownedNewFacesFromBytes: aByteArray withIndexDo: aBlock [
	"Iterate over the faces in a ByteArray. IMPORTANT: The block must free each face.

	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| faceIndex numberOfFaces |
	"If there is any face on this file, there will be a face with 0 index."
	faceIndex := 0.
	
	[	| aPointer returnCode aFace |
		aPointer := ExternalAddress new.
		returnCode := self 
			unownedNewFaceOn: aPointer 
			fromBytes: aByteArray
			size: aByteArray size
			index: faceIndex.

		returnCode = 0 ifFalse: [ ^ self ].

		aFace := AeFTFace fromHandle: aPointer.

		faceIndex = 0 ifTrue: [
			numberOfFaces := aFace numberOfFaces ].

		aBlock value: aFace value: faceIndex.
			
		faceIndex := faceIndex + 1 ]
			doWhileTrue: [ faceIndex < numberOfFaces ]
]

{ #category : #iteration }
AeFTLibrary >> unownedNewFacesFromFile: aFileReference withIndexDo: aBlock [
	"Iterate over the faces in a file path. IMPORTANT: The block must free each face.

	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| faceIndex numberOfFaces |
	"If there is any face on this file, there will be a face with 0 index."
	faceIndex := 0.
	
	[	| aPointer returnCode aFace |
		aPointer := ExternalAddress new.
		returnCode := self 
			unownedNewFaceOn: aPointer 
			fromPath: aFileReference pathString 
			index: faceIndex.

		returnCode = 0 ifFalse: [ ^ self ].

		aFace := AeFTFace fromHandle: aPointer.

		faceIndex = 0 ifTrue: [
			numberOfFaces := aFace numberOfFaces ].

		aBlock value: aFace value: faceIndex.
			
		faceIndex := faceIndex + 1 ]
			doWhileTrue: [ faceIndex < numberOfFaces ]
]

{ #category : #accessing }
AeFTLibrary >> versionString [

	| majorPointer minorPointer patchPointer|
	majorPointer := FFIInt32 newBuffer.
	minorPointer := FFIInt32 newBuffer.
	patchPointer := FFIInt32 newBuffer.
	
	self getVersionOnMajor: majorPointer minor: minorPointer patch: patchPointer. 
	
	^ '{1}.{2}.{3}' format: { 
		majorPointer signedLongAt: 1.
		minorPointer signedLongAt: 1.
		patchPointer signedLongAt: 1.
		}
]
