"
I am the FFI bindings library for Harfbuzz-GPU, introduced in Harfbuzz v14.0.0.

See: https://harfbuzz.github.io/
"
Class {
	#name : #AeHarfbuzzGPULibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-HarfbuzzGPU-Library'
}

{ #category : #testing }
AeHarfbuzzGPULibrary class >> isAvailable [

	[ self uniqueInstance libraryName ] onErrorDo: [ ^ false ].
	^ true
]

{ #category : #'accessing - platform' }
AeHarfbuzzGPULibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libharfbuzz-gpu.0.dylib'
]

{ #category : #'accessing - platform' }
AeHarfbuzzGPULibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libharfbuzz-gpu.so.0'
]

{ #category : #'accessing - platform' }
AeHarfbuzzGPULibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder findLibrary: 'libharfbuzz-gpu-0.dll'
]
