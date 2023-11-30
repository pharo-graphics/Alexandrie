"
I am the FFI bindings library for Harfbuzz.

See: https://harfbuzz.github.io/index.html

"
Class {
	#name : 'AeHarfbuzzLibrary',
	#superclass : 'FFILibrary',
	#category : 'Alexandrie-Harfbuzz-Library',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Library'
}

{ #category : 'accessing - platform' }
AeHarfbuzzLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libharfbuzz.0.dylib'
]

{ #category : 'accessing - platform' }
AeHarfbuzzLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libharfbuzz.so.0'
]

{ #category : 'versions' }
AeHarfbuzzLibrary >> versionString [
	"See: https://harfbuzz.github.io/harfbuzz-hb-version.html#hb-version-string"

	^ self ffiCall: #(
		String hb_version_string ( )
		)
]

{ #category : 'accessing - platform' }
AeHarfbuzzLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder findLibrary: 'libharfbuzz-0.dll'
]
