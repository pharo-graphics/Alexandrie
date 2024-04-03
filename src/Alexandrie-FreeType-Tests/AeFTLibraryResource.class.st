"
I am a TestResource to share the instance of Freetype library.
"
Class {
	#name : #AeFTLibraryResource,
	#superclass : #TestResource,
	#instVars : [
		'library',
		'emojiFTFace',
		'sourceSansProRegular',
		'sourceSansProBold'
	],
	#category : #'Alexandrie-FreeType-Tests-Resource'
}

{ #category : #accessing }
AeFTLibraryResource >> emojiFTFace [

	^ emojiFTFace
]

{ #category : #accessing }
AeFTLibraryResource >> library [

	^ library
]

{ #category : #running }
AeFTLibraryResource >> setUp [

	super setUp.
	library := AeFTLibrary newInitialized.
	sourceSansProRegular := AeSourceSansPro_Regular firstFaceUsing: library.
	sourceSansProBold := AeSourceSansPro_Bold firstFaceUsing: library.
	emojiFTFace :=
		AeNotoColorEmojiDownloadedFont new 
			downloadDirectory: AeFilesystemResources downloadedFontsDirectory;
			ensureDownloaded;
			firstFaceUsing: library

]

{ #category : #accessing }
AeFTLibraryResource >> sourceSansProBoldFTFace [

	^ sourceSansProBold
]

{ #category : #accessing }
AeFTLibraryResource >> sourceSansProRegularFTFace [

	^ sourceSansProRegular
]

{ #category : #running }
AeFTLibraryResource >> tearDown [

	sourceSansProRegular externallyFree.
	sourceSansProRegular := nil.

	sourceSansProBold externallyFree.
	sourceSansProBold  := nil.

	emojiFTFace externallyFree.
	emojiFTFace := nil.
	
	library externallyFree.
	library := nil.

	super tearDown
]
