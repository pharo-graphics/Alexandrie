"
I'm a trait for all classes that represent bindings to Harfbuzz library.
"
Trait {
	#name : 'AeTHarfbuzzLibrary',
	#category : 'Alexandrie-Harfbuzz-Library',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Library'
}

{ #category : 'library path' }
AeTHarfbuzzLibrary classSide >> ffiLibraryName [

	^ AeHarfbuzzLibrary
]

{ #category : 'library path' }
AeTHarfbuzzLibrary >> ffiLibraryName [
	^ self class ffiLibraryName
]
