Class {
	#name : #BaselineOfAlexandrie,
	#superclass : #BaselineOf,
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfAlexandrie
}

{ #category : #baseline }
BaselineOfAlexandrie >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [
			spec postLoadDoIt: #'postload:package:'.

			spec
				package: 'Alexandrie-Base';
				package: 'Alexandrie-Base-Tests';

				package: 'Alexandrie-Cairo'
					with: [ spec requires: #('Alexandrie-Base') ];
				package: 'Alexandrie-Cairo-Tests'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-Base-Tests') ];
					
				package: 'Alexandrie-FreeType'
					with: [ spec requires: #('Alexandrie-Base') ];
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #('Alexandrie-FreeType' 'Alexandrie-Base-Tests') ];

				package: 'Alexandrie-Harfbuzz'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-Harfbuzz-Tests'
					with: [ spec requires: #('Alexandrie-Harfbuzz' 'Alexandrie-FreeType-Tests') ];
				
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType' 'Alexandrie-Harfbuzz') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-Cairo-Tests') ];

				package: 'Alexandrie-NewTools'
					with: [ spec requires: #('Alexandrie-Canvas') ]

			]
]

{ #category : #actions }
BaselineOfAlexandrie >> downloadTestFonts [

	AeDownloadedFont ensureAllDownloadedAt: AeFilesystemResources downloadedFontsDirectory.
	AeFontManager globalInstance scanDirectory: AeFilesystemResources fontsDirectory.

]

{ #category : #actions }
BaselineOfAlexandrie >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].

	AeEnumeration initialize. "Workaround a bug: initialize is executed before the subclasses are loaded"

	self downloadTestFonts; stdoutLibraryVersions.

	Initialized := true.
]

{ #category : #actions }
BaselineOfAlexandrie >> stdoutLibraryVersions [
	
	Stdio stdout
		<< '-----------------------------'; lf;
		<< 'Main graphic library versions'; lf;
		<< '-----------------------------'; lf.

	{	'Cairo: 		'. {[AeCairoLibrary uniqueInstance versionString]. [AeCairoLibrary uniqueInstance ffiLibraryName]}.
		'Freetype: 	'. {[AeFTLibrary newInitialized versionString]. [AeFreeTypeLibrary uniqueInstance ffiLibraryName]}.
		'Harfbuzz: 	'. {[AeHarfbuzzLibrary uniqueInstance versionString]. [AeHarfbuzzLibrary uniqueInstance ffiLibraryName]}.
		'SDL: 		'. {[SDL2 version versionString]. [SDL2 findSDL2 asFFILibrary ffiLibraryName]}.
	} 	pairsDo: [ :label :blockArray |
		Stdio stdout << label.
		blockArray do: [ :each |
			Stdio stdout << (each onErrorDo: [ '---' ]); << ' 	' ].
		Stdio stdout lf ]


]
