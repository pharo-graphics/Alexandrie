"
I'm the FFI binding for Cairo with a literal-style, in the sense that no object-oriented abstractions wrap the C API that the library provides.

See: https://cairographics.org/manual/index.html
"
Class {
	#name : #AeCairoLibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-Cairo-Library'
}

{ #category : #'accessing - platform' }
AeCairoLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libcairo.dylib'
]

{ #category : #'accessing - platform' }
AeCairoLibrary >> unix32LibraryName [
	"On different flavors of linux the path to library may differ
	depending on OS distro or whether system is 32 or 64 bit.
	Packages such as snapcraft can also change the path.
	Look in a number of known locations, or LD_LIBRARY_PATH."

	^ FFIUnix32LibraryFinder findLibrary: 'libcairo.so.2'
]

{ #category : #'accessing - platform' }
AeCairoLibrary >> unix64LibraryName [
	"On different flavors of linux the path to library may differ
	depending on OS distro or whether system is 32 or 64 bit.
	Packages such as snapcraft can also change the path.
	Look in a number of known locations, or LD_LIBRARY_PATH."

	^ FFIUnix64LibraryFinder findLibrary: 'libcairo.so.2'
]

{ #category : #'accessing - platform' }
AeCairoLibrary >> unixLibraryName [
	"Backward compatibility"
	^ self unix32LibraryName
]

{ #category : #versions }
AeCairoLibrary >> versionString [
	"Answer the version in a String, such as '1.16.0'. 
	
	See https://www.cairographics.org/manual/cairo-Version-Information.html#cairo-version-string
	"

	^ self ffiCall: #( String cairo_version_string #() )
]

{ #category : #'accessing - platform' }
AeCairoLibrary >> win32LibraryName [ 
	
	^ FFIWindowsLibraryFinder findAnyLibrary: #('libcairo-2.dll')
]
