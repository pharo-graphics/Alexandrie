Class {
	#name : #AeFontScanner,
	#superclass : #Object,
	#instVars : [
		'includedDirectories',
		'manager',
		'alreadyScanned'
	],
	#category : #'Alexandrie-FreeType'
}

{ #category : #'as yet unclassified' }
AeFontScanner >> addDefaultDirectories [

	includedDirectories := { self imageRelativeFontsDirectory.
	 	self vmRelativeFontsDirectory },
		self platformSpecificDirectories
]

{ #category : #'as yet unclassified' }
AeFontScanner >> allDirectories [

	^{ self imageRelativeFontsDirectory.
	 	self vmRelativeFontsDirectory },
		self platformSpecificDirectories
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
AeFontScanner >> getWindowsLocalPaths [
	"This values should be read from the repository in the key 
	HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Fonts
	However, things happened and we don't have support of the registry in the base image.
	So this is the best alternative... or not...??  "

	^ {
		FileLocator home / 'AppData' / 'Local' / 'Microsoft' / 'Windows' / 'Fonts'.
		FileLocator home / 'AppData' / 'Roaming' / 'Microsoft' / 'Windows' / 'Fonts' }
]

{ #category : #'as yet unclassified' }
AeFontScanner >> imageRelativeFontsDirectory [

	^ FileLocator imageDirectory / 'Fonts'
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
AeFontScanner >> scanFile: aFileReference [ 
	
	| newFaces |
	newFaces := manager library facesOn: aFileReference.
	
	newFaces ifNotEmpty: [ 
		manager registerAllFaces: newFaces ] 
		ifEmpty: [ aFileReference traceCr. ]
	

]

{ #category : #'as yet unclassified' }
AeFontScanner >> scanRecursively: aDirectory [

	aDirectory exists ifFalse: [ ^ self ].
	(alreadyScanned includes: aDirectory) ifTrue: [ ^self ].
	alreadyScanned add: aDirectory.

	aDirectory files do: [ :aFile |
		((aFile basename beginsWith: '.' ) or: [
		aFile basename asLowercase endsWith: '.gz' ])
			ifFalse: [ self scanFile: aFile ] ].

	aDirectory directories do: [ :aSubDirectory |
		self scanRecursively: aSubDirectory ].

]

{ #category : #'as yet unclassified' }
AeFontScanner >> unixFontDirectories [
	"Trying with some common directories in unix. The prefered version is to read the /etc/fonts/fonts.conf"

	^ { FileLocator home / '.fonts'. '/usr/share/fonts'. '/usr/local/share/fonts' }
]

{ #category : #'as yet unclassified' }
AeFontScanner >> vmRelativeFontsDirectory [

	^ FileLocator vmDirectory / 'Fonts'
]

{ #category : #'as yet unclassified' }
AeFontScanner >> winFontDirectories [

	^ {self getWindowsFontFolderPath.
		self getWindowsLocalPaths }

]
