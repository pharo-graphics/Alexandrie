"
I am the FFI bindings library for Harfbuzz-Cairo, introduced in Harfbuzz v7.0.0.

See: https://harfbuzz.github.io/integration-cairo.html
See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html
"
Class {
	#name : #AeHarfbuzzCairoLibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-HarfbuzzCairo'
}

{ #category : #testing }
AeHarfbuzzCairoLibrary class >> isAvailable [

	[ self uniqueInstance libraryName ] onErrorDo: [ ^ false ].
	^ true
]

{ #category : #'accessing - platform' }
AeHarfbuzzCairoLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libharfbuzz-cairo.0.dylib'
]

{ #category : #'accessing - platform' }
AeHarfbuzzCairoLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libharfbuzz-cairo.so.0'
]

{ #category : #'accessing - platform' }
AeHarfbuzzCairoLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder findLibrary: 'libharfbuzz-cairo-0.dll'
]
