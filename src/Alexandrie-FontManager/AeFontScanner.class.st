"
I'm a filesystem scanner to detect FreeType font faces.

This includes knowing the default locations for each OS platform.

Extracted from the Freetype bindings present in Pharo 11 in 2022 (FreeTypeFontProvider).
"
Class {
	#name : #AeFontScanner,
	#superclass : #Object,
	#instVars : [
		'manager',
		'alreadyScanned',
		'includedDirectories'
	],
	#category : #'Alexandrie-FontManager'
}

{ #category : #scanning }
AeFontScanner >> addDefaultDirectories [

	includedDirectories
		addAll: self platformSpecificDirectories;
		add: self imageRelativeDirectory;
	 	add: self vmRelativeDirectory.
		

]

{ #category : #scanning }
AeFontScanner >> addDirectory: aFileReference [

	includedDirectories add: aFileReference
]

{ #category : #directories }
AeFontScanner >> allDirectories [

	^{ self imageRelativeDirectory.
	 	self vmRelativeDirectory },
		self platformSpecificDirectories
]

{ #category : #directories }
AeFontScanner >> guessedWindowsDirectories [
	"Answer a collection with either an existing font folder, or empty if couldn't guess any.
	Based on FreeTypeFontProvider>>#guessWindowsFontFolderPath"

	| possibilities |
	possibilities := SortedCollection sortUsing: [ :a :b | 
		                 a entry creationTime >= b entry creationTime ].

	'cdefghijklmnopqrstuvwxyz' do: [ :drive | 
		#( 'windows\fonts' ) do: [ :path | 
			| d |
			d := (FileLocator driveNamed: drive asSymbol) resolve: path.
			d exists ifTrue: [ possibilities add: d ] ] ].

	"Why not just all?"
	^ possibilities ifNotEmpty: [ ^ { possibilities first } ]
]

{ #category : #directories }
AeFontScanner >> imageRelativeDirectory [

	^ FileLocator imageDirectory / 'Fonts'
]

{ #category : #initialization }
AeFontScanner >> initialize [

	super initialize.

	includedDirectories := OrderedCollection new
]

{ #category : #directories }
AeFontScanner >> macosDirectories [
	"Answer the Mac OS X font folder paths.
	This needs some FFI code, but for the time being, we guess these and omit the user fonts folder"
	
	"Adding some directories following the guidelines in https://support.apple.com/en-us/HT201722"
	
	^ { FileLocator home / 'Library' / 'Fonts'.
		'/System/Library/Fonts'.
		'/Network/Library/Fonts/'.
		'/Library/Fonts' }
]

{ #category : #accessing }
AeFontScanner >> manager: anAeFontManager [ 

	manager:= anAeFontManager 
]

{ #category : #directories }
AeFontScanner >> platformSpecificDirectories [

	Smalltalk os isWindows ifTrue: [ ^ self windowsDirectories ].
	Smalltalk os isUnix ifTrue: [ ^ self unixFontDirectories ].
	Smalltalk os isMacOSX ifTrue: [ ^ self macosDirectories ].
	^ #()
]

{ #category : #scanning }
AeFontScanner >> scan [
	
	alreadyScanned := Set new.
	includedDirectories do: [ :each |
		self scanRecursively: each asFileReference ]
]

{ #category : #'scanning - private' }
AeFontScanner >> scanFile: aFileReference [ 
	
	manager registerFacesOnFile: aFileReference

]

{ #category : #'scanning - private' }
AeFontScanner >> scanRecursively: aDirectory [

	aDirectory exists ifFalse: [ ^ self ].
	(alreadyScanned includes: aDirectory) ifTrue: [ ^self ].
	alreadyScanned add: aDirectory.

	aDirectory files
		reject: [ :aFile |
			 self shouldIgnoreFile: aFile ]
		thenDo: [ :aFile |
			self scanFile: aFile ].

	aDirectory directories do: [ :aSubDirectory |
		self scanRecursively: aSubDirectory ].

]

{ #category : #'scanning - private' }
AeFontScanner >> shouldIgnoreFile: aFile [

	^ ((aFile basename beginsWith: '.' ) or: [
		aFile basename asLowercase endsWith: '.gz' ])

]

{ #category : #directories }
AeFontScanner >> unixFontDirectories [
	"Trying with some common directories in unix. The prefered version is to read the /etc/fonts/fonts.conf"

	^ {		FileLocator home / '.fonts'.
			FileLocator home / '.local/share/fonts'.
			'/usr/share/fonts'.
			'/usr/local/share/fonts' }
]

{ #category : #directories }
AeFontScanner >> vmRelativeDirectory [

	^ FileLocator vmDirectory / 'Fonts'
]

{ #category : #directories }
AeFontScanner >> windowsAppDataDirectories [

	^ {
		FileLocator home / 'AppData' / 'Local' / 'Microsoft' / 'Windows' / 'Fonts'.
		FileLocator home / 'AppData' / 'Roaming' / 'Microsoft' / 'Windows' / 'Fonts' }
]

{ #category : #directories }
AeFontScanner >> windowsDirectories [

	^ self guessedWindowsDirectories, self windowsAppDataDirectories

]
