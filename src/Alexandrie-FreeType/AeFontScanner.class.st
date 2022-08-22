"
I'm a filesystem scanner to detect FreeType font faces.

This includes knowing the default locations for each OS platform.

Extracted from the FileSystem bindings present in Pharo 11 in 2022.
"
Class {
	#name : #AeFontScanner,
	#superclass : #Object,
	#instVars : [
		'manager',
		'alreadyScanned',
		'includedDirectories'
	],
	#category : #'Alexandrie-FreeType-Manager'
}

{ #category : #directories }
AeFontScanner >> addDefaultDirectories [

	includedDirectories
		add: self imageRelativeFontsDirectory;
	 	add: self vmRelativeFontsDirectory;
		addAll: self platformSpecificDirectories

]

{ #category : #directories }
AeFontScanner >> addDirectory: aFileReference [

	includedDirectories add: aFileReference
]

{ #category : #directories }
AeFontScanner >> allDirectories [

	^{ self imageRelativeFontsDirectory.
	 	self vmRelativeFontsDirectory },
		self platformSpecificDirectories
]

{ #category : #directories }
AeFontScanner >> getWindowsFontFolderPath [
	"Answer the windows font folder path.
	This is obtained through the Windows API if FFI is present,
	otherwise it is a guess !"

	| fun buff |
	fun := TFExternalFunction
		       name: 'SHGetFolderPathA'
		       moduleName: 'shfolder.dll'
		       parameterTypes: { 
				       TFBasicType slong.
				       TFBasicType slong.
				       TFBasicType slong.
				       TFBasicType slong.
				       TFBasicType pointer }
		       returnType: TFBasicType slong.

	buff := ByteArray new: 1024.
	
	[ TFSameThreadRunner uniqueInstance invokeFunction: fun withArguments: { 0. 16r0014. 0. 0. buff } ]
		on: Error
		do: [ :e | ^ nil ].
	
	^ (buff copyFrom: 1 to: (buff indexOf: 0) - 1) asString
]

{ #category : #directories }
AeFontScanner >> getWindowsLocalPaths [
	"This values should be read from the repository in the key 
	HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Fonts
	However, things happened and we don't have support of the registry in the base image.
	So this is the best alternative... or not...??  "

	^ {
		FileLocator home / 'AppData' / 'Local' / 'Microsoft' / 'Windows' / 'Fonts'.
		FileLocator home / 'AppData' / 'Roaming' / 'Microsoft' / 'Windows' / 'Fonts' }
]

{ #category : #directories }
AeFontScanner >> imageRelativeFontsDirectory [

	^ FileLocator imageDirectory / 'Fonts'
]

{ #category : #directories }
AeFontScanner >> initialize [

	super initialize.

	includedDirectories := OrderedCollection new
]

{ #category : #directories }
AeFontScanner >> macOSXFolderDirectories [
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

	Smalltalk os isWindows ifTrue: [ ^ self winFontDirectories ].
	Smalltalk os isUnix ifTrue: [ ^ self unixFontDirectories ].
	Smalltalk os isMacOSX ifTrue: [ ^ self macOSXFolderDirectories ].
	^ #()
]

{ #category : #scanning }
AeFontScanner >> scan [
	
	alreadyScanned := Set new.
	includedDirectories do: [ :each |
		self scanRecursively: each asFileReference ]
]

{ #category : #directories }
AeFontScanner >> scanFile: aFileReference [ 
	
	manager registerFacesOnFile: aFileReference

]

{ #category : #directories }
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

{ #category : #directories }
AeFontScanner >> shouldIgnoreFile: aFile [

	^ ((aFile basename beginsWith: '.' ) or: [
		aFile basename asLowercase endsWith: '.gz' ])

]

{ #category : #directories }
AeFontScanner >> unixFontDirectories [
	"Trying with some common directories in unix. The prefered version is to read the /etc/fonts/fonts.conf"

	^ { FileLocator home / '.fonts'. '/usr/share/fonts'. '/usr/local/share/fonts' }
]

{ #category : #directories }
AeFontScanner >> vmRelativeFontsDirectory [

	^ FileLocator vmDirectory / 'Fonts'
]

{ #category : #directories }
AeFontScanner >> winFontDirectories [

	^ {self getWindowsFontFolderPath.
		self getWindowsLocalPaths }

]
