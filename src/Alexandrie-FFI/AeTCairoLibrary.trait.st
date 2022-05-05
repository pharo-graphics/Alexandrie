Trait {
	#name : #AeTCairoLibrary,
	#category : #'Alexandrie-FFI-Library'
}

{ #category : #'library path' }
AeTCairoLibrary classSide >> ffiLibraryName [
	^ AeCairoLibrary
]

{ #category : #'library path' }
AeTCairoLibrary >> ffiLibraryName [
	^ self class ffiLibraryName
]
