Class {
	#name : #BaselineOfAlexandrie,
	#superclass : #BaselineOf,
	#classVars : [
		'Initialized'
	],
	#category : #BaselineOfAlexandrie
}

{ #category : #baselines }
BaselineOfAlexandrie >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [
			spec postLoadDoIt: #postLoad.

			spec
				package: 'Alexandrie-Base';
				package: 'Alexandrie-Base-Tests';

				package: 'Alexandrie-FreeType'
					with: [ spec requires: #('Alexandrie-Base') ];
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #('Alexandrie-FreeType' 'Alexandrie-Base-Tests') ];

				package: 'Alexandrie-Cairo'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-Cairo-Tests'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType-Tests') ];

				package: 'Alexandrie-CairoFreetype'
					with: [ spec requires: #('Alexandrie-Cairo') ];
				package: 'Alexandrie-CairoFreetype-Tests'
					with: [ spec requires: #('Alexandrie-CairoFreetype') ];

				package: 'Alexandrie-Blur'
					with: [ spec requires: #('Alexandrie-Cairo') ]; "Examples use freetype"
				package: 'Alexandrie-Blur-Tests'
					with: [ spec requires: #('Alexandrie-Blur' 'Alexandrie-CairoFreetype') ];
					
				package: 'Alexandrie-FontManager'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-FontManager-Tests'
					with: [ spec requires: #('Alexandrie-FontManager' 'Alexandrie-FreeType-Tests') ];

				package: 'Alexandrie-Harfbuzz'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-Harfbuzz-Tests'
					with: [ spec requires: #('Alexandrie-Harfbuzz' 'Alexandrie-FreeType-Tests') ];

				package: 'Alexandrie-HarfbuzzCairo'
					with: [ spec requires: #('Alexandrie-Harfbuzz' 'Alexandrie-Cairo') ];
				package: 'Alexandrie-HarfbuzzCairo-Tests'
					with: [ spec requires: #('Alexandrie-HarfbuzzCairo' 'Alexandrie-Harfbuzz-Tests') ];

				"Requires libharfbuzz-cairo. See: https://github.com/pharo-graphics/Alexandrie/issues/113"
				package: 'Alexandrie-HarfbuzzVariableFonts'
					with: [ spec requires: #('Alexandrie-HarfbuzzCairo') ];
				package: 'Alexandrie-HarfbuzzVariableFonts-Tests'
					with: [ spec requires: #('Alexandrie-HarfbuzzVariableFonts' 'Alexandrie-HarfbuzzCairo-Tests') ];
				
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-Blur') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-Cairo-Tests') ];

				package: 'Alexandrie-NewTools'
					with: [ spec requires: #('Alexandrie-Canvas') ];
				package: 'Alexandrie-NewTools-Tests'
					with: [ spec requires: #(
						'Alexandrie-NewTools'
						'Alexandrie-Cairo-Tests'
						'Alexandrie-FontManager') ].

			spec
				group: 'ffi-minimal' with: #('Alexandrie-HarfbuzzCairo' 'Alexandrie-CairoFreetype');
				group: 'production' with: #(
					'Alexandrie-Harfbuzz'
					'Alexandrie-Blur'
					'Alexandrie-Canvas'
					'Alexandrie-CairoFreetype'
					'Alexandrie-FontManager');
				group: 'development' with: #(
					'Alexandrie-NewTools-Tests'
					'Alexandrie-Harfbuzz-Tests'
					'Alexandrie-Blur-Tests'
					'Alexandrie-Canvas-Tests'
					'Alexandrie-CairoFreetype-Tests'
					'Alexandrie-FontManager-Tests');
				group: 'default' with: #('development')	]
]

{ #category : #actions }
BaselineOfAlexandrie >> downloadTestFonts [

	| aeFilesystemResources |
	"Do this class name trick to avoid loading warnings such as: 
	NewUndeclaredWarning: BaselineOfAlexandrie>>downloadTestFonts (AeFilesystemResources is Undeclared).
	
	Tolerate potentially missing packages and dynamic libraries."

	aeFilesystemResources :=
		self class environment
			at: #AeFilesystemResources
			ifAbsent: [ ^ self ].

	self class environment
		at: #AeDownloadedFont
		ifPresent: [ :aeDownloadedFont |
			aeDownloadedFont ensureAllDownloadedAt: aeFilesystemResources downloadedFontsDirectory ].

	self class environment
		at: #AeFontManager
		ifPresent: [ :aeFontManager |
			aeFontManager globalInstance scanDirectory: aeFilesystemResources fontsDirectory ]
]

{ #category : #actions }
BaselineOfAlexandrie >> initializeAeCanvas [
	"Initialize canvas. Assumes cairo enumerations are already initialized.
	Note: The canvas class is not loaded on ffi-minimal load group."

	(self class environment at: #AeCanvas ifPresent: #initializeFontOptions)
]

{ #category : #script }
BaselineOfAlexandrie >> initializeEnumerations [
	"Initialize all our enumerations (those that implement #enumDecl)"

	(self class environment at: #AeEnumeration)
		allSubclassesDo: [ :each |
			(each classSide includesSelector: #enumDecl)
				ifTrue: [ each initializeEnumeration ] ]
]

{ #category : #actions }
BaselineOfAlexandrie >> postLoad [

	"Ignore if already executed"
	Initialized ifNotNil: [ ^ self ].

	self initializeEnumerations.
	self initializeAeCanvas.
	self downloadTestFonts.
	self stdoutLibraryVersions.

	Initialized := true
]

{ #category : #actions }
BaselineOfAlexandrie >> stdoutLibraryVersions [
	<script: 'self new stdoutLibraryVersions'>

	"Do this class name trick to avoid loading warnings such as: 
	NewUndeclaredWarning: BaselineOfAlexandrie>>stdoutLibraryVersions (AeCairoLibrary is Undeclared).
	
	Additionally, we tolerate potentially missing packages and dynamic libraries."

	Stdio stdout
		<< '-----------------------------'; lf;
		<< 'Main graphic library versions'; lf;
		<< '-----------------------------'; lf.

	{	'Cairo:    '. {
			[ (self class environment at: #AeCairoLibrary) uniqueInstance versionString ].
			[ (self class environment at: #AeCairoLibrary) uniqueInstance libraryName ]}.
		'Freetype: '. {
			[ (self class environment at: #AeFTLibrary) newInitialized versionString ].
			[ (self class environment at: #AeFTLibrary) ffiLibrary uniqueInstance libraryName ]}.
		'Harfbuzz: '. {
			[ (self class environment at: #AeHarfbuzzLibrary) uniqueInstance versionString ].
			[ (self class environment at: #AeHarfbuzzLibrary) uniqueInstance libraryName ]}.
		'SDL2:     '. {
			[ (self class environment at: #SDL2) version versionString ].
			[ (self class environment at: #SDL2Library) uniqueInstance libraryName ]}.

	} 	pairsDo: [ :label :blockArray |
		Stdio stdout << label.
		blockArray do: [ :each |
			Stdio stdout
				<< (each onErrorDo: [ '---' ]);
				<< ' 	' ].
		Stdio stdout lf ]
]
