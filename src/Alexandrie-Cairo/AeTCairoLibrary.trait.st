"
I'm a trait for all classes that represent bindings to Cairo library.
"
Trait {
	#name : #AeTCairoLibrary,
	#category : #'Alexandrie-Cairo-Library'
}

{ #category : #'library path' }
AeTCairoLibrary classSide >> ffiLibraryName [
	^ AeCairoLibrary
]

{ #category : #'library path' }
AeTCairoLibrary >> ffiLibraryName [
	^ self class ffiLibraryName
]
