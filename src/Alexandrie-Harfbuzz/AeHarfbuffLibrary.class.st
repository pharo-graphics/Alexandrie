"
I am the FFI bindings library for Harfbuzz.

See: https://harfbuzz.github.io/index.html

"
Class {
	#name : #AeHarfbuffLibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-Harfbuzz-Library'
}

{ #category : #'accessing - platform' }
AeHarfbuffLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libharfbuzz.0.dylib'
]
