"
I am a trait for all classes that represent bindings to Harfbuzz-GPU library.
"
Trait {
	#name : #AeTHarfbuzzGPULibrary,
	#category : #'Alexandrie-HarfbuzzGPU-Library'
}

{ #category : #'library path' }
AeTHarfbuzzGPULibrary classSide >> ffiLibraryName [

	^ AeHarfbuzzGPULibrary
]

{ #category : #'library path' }
AeTHarfbuzzGPULibrary >> ffiLibraryName [

	^ self class ffiLibraryName
]
