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
				package: 'Alexandrie-Cairo';
				package: 'Alexandrie-Cairo-Tests'
					with: [ spec requires: #('Alexandrie-Cairo') ];
					
				package: 'Alexandrie-FreeType';
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #('Alexandrie-FreeType') ];

				package: 'Alexandrie-Harfbuzz'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-Harfbuzz-Tests'
					with: [ spec requires: #('Alexandrie-Harfbuzz' 'Alexandrie-FreeType-Tests') ];
				
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType' 'Alexandrie-Harfbuzz') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-Cairo-Tests') ]
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

	self downloadTestFonts; stdoutLibraryVersions.

	Initialized := true.
]

{ #category : #actions }
BaselineOfAlexandrie >> stdoutLibraryVersions [
	
	Stdio stdout
		<< '-----------------------------'; lf;
		<< 'Main graphic library versions'; lf;
		<< '-----------------------------'; lf.

	Stdio stdout
		<< 'Cairo: 		';
		<< AeCairoLibrary uniqueInstance versionString; lf.

	Stdio stdout
		<< 'Freetype: 	';
		<< AeFTLibrary newInitialized versionString; lf.

	Stdio stdout
		<< 'Harfbuzz: 	';
		<< AeHarfbuffLibrary uniqueInstance versionString; lf.

	Stdio stdout
		<< 'SDL: 		'.
	SDL2 version printAsSemanticVersioningOn: Stdio stdout.
	Stdio stdout lf.
		
]
