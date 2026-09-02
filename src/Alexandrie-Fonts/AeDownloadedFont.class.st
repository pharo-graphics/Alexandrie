"
I am the superclass of fonts that are downloaded via HTTP.

My subclasses are particular fonts that can be loaded in a `AeFontManager`.
"
Class {
	#name : #AeDownloadedFont,
	#superclass : #Object,
	#instVars : [
		'downloadDirectory'
	],
	#category : #'Alexandrie-Fonts'
}

{ #category : #convenience }
AeDownloadedFont class >> ensureAllDownloadedAt: aFileReference [

	self allSubclassesDo: [ :each |
		each new
			downloadDirectory: aFileReference;
			ensureDownloaded ]
]

{ #category : #accessing }
AeDownloadedFont >> baseUrl [

	^ self subclassResponsibility 
]

{ #category : #actions }
AeDownloadedFont >> download [
	
	('Downloading {1}...' format: { self familyName }) traceCr.

	[	ZnClient new
			url: self baseUrl, self fileName;
			numberOfRetries: 5;
			timeout: 100;
			logToTranscript;
			downloadTo: self downloadDirectory ensureCreateDirectory; yourself.

		'
Download finished - ' trace ] timeToRun traceCr.

]

{ #category : #accessing }
AeDownloadedFont >> downloadDirectory [

	^ downloadDirectory
]

{ #category : #accessing }
AeDownloadedFont >> downloadDirectory: aFileReference [

	downloadDirectory := aFileReference
]

{ #category : #actions }
AeDownloadedFont >> ensureDownloaded [

	self isDownloaded ifFalse: [ self download ]
]

{ #category : #accessing }
AeDownloadedFont >> familyName [

	^ self subclassResponsibility 
]

{ #category : #accessing }
AeDownloadedFont >> fileName [

	^ self subclassResponsibility 
]

{ #category : #testing }
AeDownloadedFont >> fileReference [

	^ self downloadDirectory / self fileName
]

{ #category : #initialization }
AeDownloadedFont >> initialize [

	super initialize.

	downloadDirectory := AeFilesystemResources downloadedFontsDirectory
]

{ #category : #testing }
AeDownloadedFont >> isDownloaded [

	^ self fileReference exists
]
