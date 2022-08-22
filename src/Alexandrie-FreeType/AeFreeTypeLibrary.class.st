"
I'm a FreeType FFI binding library, that exposes as literal as possible to C API of the library.

The initial code is inspired on the FreeType library bindings from Pharo 11 (2022).
"
Class {
	#name : #AeFreeTypeLibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #'accessing - platform' }
AeFreeTypeLibrary >> macLibraryName [

	^ FFIMacLibraryFinder findLibrary: 'libfreetype.dylib'
]

{ #category : #'accessing - platform' }
AeFreeTypeLibrary >> unix64LibraryName [

	^ FFIUnix64LibraryFinder findLibrary: 'libfreetype.so.6'
]

{ #category : #'accessing - platform' }
AeFreeTypeLibrary >> win32LibraryName [

	^ FFIWindowsLibraryFinder findAnyLibrary: 
		#('freetype.dll' 'libfreetype.dll' 'libfreetype-6.dll') 

]
