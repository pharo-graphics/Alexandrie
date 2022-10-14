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

{ #category : #versions }
AeHarfbuffLibrary >> versionString [
	"See: https://harfbuzz.github.io/harfbuzz-hb-version.html#hb-version-string"

	^ self ffiCall: #(
		String hb_version_string ( )
		)
]
