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
	#category : #'Alexandrie-FreeType-FFI'
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

{ #category : #iteration }
AeFTLibrary >> facesOn: aFileReference [
	"Answer all the faces in a file path."

	^ Array streamContents: [ :aStream |
		self
			lowLevelFacesOn: aFileReference
			withIndexDo: [ :eachFace :index |
				eachFace autoRelease.
				aStream nextPut: eachFace ] ]
]

{ #category : #iteration }
AeFTLibrary >> fastReadFacesOn: aFileReference do: aBlock [
	"Iterate over all the faces in a file path. 
	IMPORTANT: The Face will be freed (done) after each iteration."

	self
		lowLevelFacesOn: aFileReference
		withIndexDo: [ :eachFace :index |
			aBlock value: eachFace value: index.
			eachFace free. ]
]

{ #category : #iteration }
AeFTLibrary >> fastReadFacesOnMemory: aByteArray do: aBlock [
	"Iterate over all the faces in a given ByteArray.
	IMPORTANT: The Face will be freed (done) after each iteration."

	self
		lowLevelFacesOnMemory: aByteArray
		withIndexDo: [ :eachFace :index |
			aBlock value: eachFace value: index.
			eachFace free. ]
]

{ #category : #iteration }
AeFTLibrary >> lowLevelFacesOn: aFileReference withIndexDo: aBlock [
	"Iterate over the faces in a file path. NOTE: Sender is responsible to RELEASE.

	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| faceIndex numberOfFaces |
	"If there is any face on this file, there will be a face with 0 index."
	faceIndex := 0.
	
	[	| aPointer returnCode aFace |
		aPointer := ExternalAddress new.
		returnCode := self 
			primNewFace: aPointer 
			path: aFileReference pathString 
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
AeFTLibrary >> lowLevelFacesOnMemory: aByteArray withIndexDo: aBlock [
	"Iterate over the faces in a ByteArray. NOTE: Sender is responsible to RELEASE.

	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec"

	| faceIndex numberOfFaces |
	"If there is any face on this file, there will be a face with 0 index."
	faceIndex := 0.
	
	[	| aPointer returnCode aFace |
		aPointer := ExternalAddress new.
		returnCode := self 
			primNewMemoryFace: aPointer 
			buffer: aByteArray
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

{ #category : #'instance creation' }
AeFTLibrary >> newFaceFromFile: aFileReference index: aZeroBasedIndex [

	| aPointer returnCode |
	aPointer := ExternalAddress new.
	
	returnCode := self
		primNewFace: aPointer
		path: aFileReference pathString
		index: aZeroBasedIndex.

	returnCode = 0 ifFalse: [
		AeFreeTypeError signalForCode: returnCode ].
		
	^ (AeFTFace fromHandle: aPointer)
		autoRelease;
		yourself
]

{ #category : #'instance creation' }
AeFTLibrary >> newFaceFromMemory: aByteArray index: aZeroBasedIndex [

	| aPointer returnCode |
	aPointer := ExternalAddress new.
	
	returnCode := self
		primNewMemoryFace: aPointer
		buffer: aByteArray
		size: aByteArray size 
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

{ #category : #'private - ffi' }
AeFTLibrary >> primNewMemoryFace: aFaceAddress buffer: fileBase size: fileSize index: faceIndex [
	"Create a new FT_Face object, answered in the pointer. Use FT_Done_Face to destroy it. 
	Return a FreeType error code. 0 means success.
	
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
AeFTLibrary >> primVersionMajor: major minor: minor patch: patch [
	"See: https://freetype.org/freetype2/docs/reference/ft2-version.html#ft_library_version"

	self ffiCall: #(
		void
		FT_Library_Version (
			self,
			int * major,
			int * minor,
			int * patch)
		)

]

{ #category : #accessing }
AeFTLibrary >> versionString [

	| major minor patch|
	major := FFIInt32 newBuffer.
	minor := FFIInt32 newBuffer.
	patch := FFIInt32 newBuffer.
	
	self primVersionMajor: major minor: minor patch: patch. 
	
	^ '{1}.{2}.{3}' format: { 
		major signedLongAt: 1.
		minor signedLongAt: 1.
		patch signedLongAt: 1.
		}
]
