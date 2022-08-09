Class {
	#name : #AeFreeTypeLibrary,
	#superclass : #FFILibrary,
	#category : #'Alexandrie-FreeType'
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
