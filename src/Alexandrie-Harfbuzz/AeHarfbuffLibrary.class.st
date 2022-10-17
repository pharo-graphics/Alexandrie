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

{ #category : #'accessing - platform' }
AeHarfbuffLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libharfbuzz.so.0'
]

{ #category : #versions }
AeHarfbuffLibrary >> versionString [
	"See: https://harfbuzz.github.io/harfbuzz-hb-version.html#hb-version-string"

	^ self ffiCall: #(
		String hb_version_string ( )
		)
]

{ #category : #'accessing - platform' }
AeHarfbuffLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder findLibrary: 'libharfbuzz-0.dll'
]
