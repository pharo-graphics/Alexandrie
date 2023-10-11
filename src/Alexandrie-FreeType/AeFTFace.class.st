"
I am a FreeType FFI binding to `FT_Face`.

A `FT_Face` is a typographic face object. A face object models a given typeface, in a given style.

Instances of this class are created by `AeFTLibrary`.

See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_face
"
Class {
	#name : #AeFTFace,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTFreeTypeLibrary + AeTExternalFree',
	#classTraits : 'AeTFreeTypeLibrary classTrait + AeTExternalFree classTrait',
	#instVars : [
		'library'
	],
	#classVars : [
		'OFFSET_FACEFLAGS',
		'OFFSET_FACEINDEX',
		'OFFSET_FAMILYNAMEADDRESS',
		'OFFSET_NUMBEROFFACES',
		'OFFSET_NUMBEROFGLYPHS',
		'OFFSET_STYLEFLAGS',
		'OFFSET_STYLENAMEADDRESS'
	],
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #finalization }
AeFTFace class >> externallyFree: aHandle [
	"Discard a given face object.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_done_face"

	self ffiCall: #( int FT_Done_Face ( void * aHandle ) )
]

{ #category : #'field definition' }
AeFTFace class >> fieldsDesc [
	"See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_facerec
	
	self rebuildFieldAccessors
	"

	^ #(
    "FT_Long num_faces;"       long numberOfFaces
    "FT_Long face_index;"      long faceIndex

    "FT_Long face_flags;"      long faceFlags
    "FT_Long style_flags;"     long styleFlags

    "FT_Long num_glyphs;"      long numberOfGlyphs

    "FT_String* family_name;"  String familyNameAddress
    "FT_String* style_name;"   String styleNameAddress
	)
	"... we ignore remaining fields"
]

{ #category : #finalization }
AeFTFace class >> finalizeResourceData: anArray [
	"Free a face, with an exception: If library was already freed, then all faces were already freed."

	| libraryHandle aHandle |
	aHandle := anArray first.
	libraryHandle := anArray second.
	libraryHandle isNull ifFalse: [
		aHandle isNull ifTrue: [ ^ self ].
		self externallyFree: aHandle ].
	aHandle beNull
]

{ #category : #accessing }
AeFTFace >> charHeight: aNumber [
	"Request nominal height, taking resolution of 72 dpi."

	^ self
		  charSizeWidth: 0
		  height: aNumber as26Dot6FractionalPoint
		  horizontalResolution: 0
		  verticalResolution: 0
]

{ #category : #accessing }
AeFTFace >> charSizeWidth: aWidth height: aHeight [
	"Request nominal size, taking resolution of 72 dpi."

	^ self
		  charSizeWidth: aWidth as26Dot6FractionalPoint
		  height: aHeight as26Dot6FractionalPoint
		  horizontalResolution: 0
		  verticalResolution: 0
]

{ #category : #accessing }
AeFTFace >> charSizeWidth: char_width height: char_height horizontalResolution: horz_resolution verticalResolution: vert_resolution [
	"Request nominal size.

	The nominal width and height are 26.6 fractional points.
	
	The resolution is represented in dpi.

	While this function allows fractional points as input values, the resulting ppem value for the given resolution is always rounded to the nearest integer.

	If either the character width or height is zero, it is set equal to the other value.

	If either the horizontal or vertical resolution is zero, it is set equal to the other value.

	A character width or height smaller than 1pt is set to 1pt; if both resolution values are zero, they are set to 72dpi.

	Don't use this function if you are using the FreeType cache API.
	
	See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_set_char_size"

	^ self ffiCall: #(
		long
		FT_Set_Char_Size(
			self,
			long char_width,
			long char_height,
			uint horz_resolution,
			uint vert_resolution )
		)
]

{ #category : #'accessing - structure variables' }
AeFTFace >> faceFlags [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_FACEFLAGS
]

{ #category : #'accessing - structure variables' }
AeFTFace >> faceFlags: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_FACEFLAGS put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTFace >> faceIndex [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_FACEINDEX
]

{ #category : #'accessing - structure variables' }
AeFTFace >> faceIndex: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_FACEINDEX put: anObject
]

{ #category : #accessing }
AeFTFace >> familyName [

	^ self familyNameAddress utf8StringFromCString
]

{ #category : #'accessing - structure variables' }
AeFTFace >> familyNameAddress [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_FAMILYNAMEADDRESS) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
AeFTFace >> familyNameAddress: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_FAMILYNAMEADDRESS put: anObject getHandle.
]

{ #category : #accessing }
AeFTFace >> flags [

	^ AeFTFaceFlag bitFlagsAt: self faceFlags
]

{ #category : #testing }
AeFTFace >> isBold [

	^ self styleFlags allMask: AeFTStyleFlag bold value
]

{ #category : #testing }
AeFTFace >> isFixedSize [
	"The face contains bitmap strikes. See also the `num_fixed_sizes` and `available_sizes` fields of `FT_FaceRec`.
	
	Source: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_face_flag_fixed_sizes"

	^ self styleFlags allMask: AeFTFaceFlag fixedSizes value
]

{ #category : #testing }
AeFTFace >> isFixedWidth [

	^ self faceFlags allMask: AeFTFaceFlag fixedWidth value
]

{ #category : #testing }
AeFTFace >> isItalic [

	^ self styleFlags allMask: AeFTStyleFlag italic value
]

{ #category : #testing }
AeFTFace >> isSfnt [

	^ self faceFlags allMask: AeFTFaceFlag sfnt value
]

{ #category : #accessing }
AeFTFace >> library [

	^ library
]

{ #category : #accessing }
AeFTFace >> library: aeFTLibrary [
	"Set the library that created this font face. This avoids garbage collection of the library before of me."

	library := aeFTLibrary
]

{ #category : #'accessing - structure variables' }
AeFTFace >> numberOfFaces [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_NUMBEROFFACES
]

{ #category : #'accessing - structure variables' }
AeFTFace >> numberOfFaces: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_NUMBEROFFACES put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTFace >> numberOfGlyphs [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_NUMBEROFGLYPHS
]

{ #category : #'accessing - structure variables' }
AeFTFace >> numberOfGlyphs: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_NUMBEROFGLYPHS put: anObject
]

{ #category : #accessing }
AeFTFace >> postscriptName [
	"See: https://freetype.org/freetype2/docs/reference/ft2-information_retrieval.html#ft_get_postscript_name"

	^ self ffiCall: #(String FT_Get_Postscript_Name (self))
]

{ #category : #printing }
AeFTFace >> printFaceFlagsOn: aStream [

	(AeFTFaceFlag bitFlagNamesAt: self faceFlags) sorted
		do: [ :each | aStream nextPutAll: each ]
		separatedBy: [ aStream nextPutAll: ', ' ]

]

{ #category : #printing }
AeFTFace >> printOn: aStream [

	super printOn: aStream.
	handle isNull ifTrue: [ ^self ].
	aStream
		nextPutAll: ' family: ';
		print: self familyName;
		nextPutAll: ' style: ';
		print: self styleName;
		nextPutAll: ' flags: '.
	self printFaceFlagsOn: aStream
]

{ #category : #finalization }
AeFTFace >> resourceData [
	"Answer an object that doesn't point to self and that is used in `resourceDataFrom:` to obtain the handle at freeing time."

	^ { self getHandle. library getHandle }
]

{ #category : #accessing }
AeFTFace >> sfntOS2Table [

	^ self sfntOS2TableIfNone: [ NotFound signal ]
]

{ #category : #accessing }
AeFTFace >> sfntOS2TableIfNone: noneBlock [
	
	| tableAddressOrNull |
	self isSfnt ifFalse: [ ^ noneBlock value ].
	
	tableAddressOrNull := self sfntTableAddressAt: AeFTSfntTag os2.
	tableAddressOrNull isNull ifTrue: [ ^ noneBlock value ].

	^ AeFTSfntOS2Table fromHandle: tableAddressOrNull
]

{ #category : #accessing }
AeFTFace >> sfntTableAddressAt: tag [
	"Return a pointer to the specified table. This will be NULL in case of error, or if the corresponding table was not found OR loaded from the file.

	Note: The table is owned by the face object and disappears with it.

	Note: This function is only useful to access SFNT tables that are loaded by the sfnt, truetype, and opentype drivers.

	See: https://freetype.org/freetype2/docs/reference/ft2-truetype_tables.html#ft_get_sfnt_table"
	
	^ self ffiCall: #(
		void *
		FT_Get_Sfnt_Table (
			self,
			AeFTSfntTag tag ) )
]

{ #category : #'accessing - structure variables' }
AeFTFace >> styleFlags [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_STYLEFLAGS
]

{ #category : #'accessing - structure variables' }
AeFTFace >> styleFlags: anObject [
	"This method was automatically generated"
	^handle platformLongAt: OFFSET_STYLEFLAGS put: anObject
]

{ #category : #accessing }
AeFTFace >> styleName [

	^ self styleNameAddress utf8StringFromCString
]

{ #category : #'accessing - structure variables' }
AeFTFace >> styleNameAddress [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_STYLENAMEADDRESS) type: ExternalType char asPointerType
]

{ #category : #'accessing - structure variables' }
AeFTFace >> styleNameAddress: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_STYLENAMEADDRESS put: anObject getHandle.
]
