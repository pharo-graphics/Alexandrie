"
I'm a trait for convenience of FreeType object bindings.
"
Trait {
	#name : #AeTFreeTypeLibrary,
	#category : #'Alexandrie-FreeType'
}

{ #category : #'library path' }
AeTFreeTypeLibrary classSide >> ffiLibraryName [

	^ AeFreeTypeLibrary
]

{ #category : #'library path' }
AeTFreeTypeLibrary >> ffiLibraryName [

	^ self class ffiLibraryName
]
