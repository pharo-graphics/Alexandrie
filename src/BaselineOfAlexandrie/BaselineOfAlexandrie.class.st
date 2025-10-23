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
			spec postLoadDoIt: #'postload:package:'.

			spec
				package: 'Alexandrie-Base';
				package: 'Alexandrie-Base-Tests';

				"Fonts package is independent from Freetype (e.g. it could be read by Harfbuzz)"
				package: 'Alexandrie-Fonts'
					with: [ spec requires: #('Alexandrie-Base') ];

				"Source Pro family is sed by test s but also are the default font manager fonts"
				package: 'Alexandrie-Fonts-SourcePro'
					with: [ spec requires: #('Alexandrie-Fonts') ];

				package: 'Alexandrie-FreeType'
					with: [ spec requires: #('Alexandrie-Base' 'Alexandrie-Fonts') ];
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #(
						'Alexandrie-FreeType'
						'Alexandrie-Base-Tests'
						'Alexandrie-Fonts-SourcePro') ];

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
					with: [ spec requires: #('Alexandrie-FreeType' 'Alexandrie-Fonts-SourcePro') ];
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
			aeDownloadedFont ensureAllDownloadedAt:
				aeFilesystemResources downloadedFontsDirectory ].

	self class environment
		at: #AeFontManager
		ifPresent: [ :aeFontManager |
			aeFontManager current scanDirectory:
				aeFilesystemResources fontsDirectory ]
]

{ #category : #actions }
BaselineOfAlexandrie >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized ifNotNil: [ ^ self ].

	"Re-initialize enumerations as they is executed before the subclasses
	are loaded since they are packaged separately.
	Additionally: reference the class indirectly to avoid NewUndeclaredWarning."
	(self class environment at: #AeEnumeration) initialize.

	"This initialization depends on cairo enumerations, that are now ready.
	The class is not loaded on ffi-minimal load group."
	(self class environment at: #AeCanvas ifPresent: #initializeFontOptions).

	self downloadTestFonts; stdoutLibraryVersions.

	Initialized := true
]

{ #category : #actions }
BaselineOfAlexandrie >> stdoutLibraryVersions [
	<script: 'self new stdoutLibraryVersions'>

	| aeCairoLibrary aeFTLibrary aeHarfbuzzLibrary |
	"Do this class name trick to avoid loading warnings such as: 
	NewUndeclaredWarning: BaselineOfAlexandrie>>stdoutLibraryVersions (AeCairoLibrary is Undeclared).
	
	Additionally, we tolerate potentially missing packages and dynamic libraries."

	Stdio stdout
		<< '-----------------------------'; lf;
		<< 'Main graphic library versions'; lf;
		<< '-----------------------------'; lf.

	{	'Cairo:    '. {
			[ (aeCairoLibrary := self class environment at: #AeCairoLibrary) uniqueInstance versionString ].
			[ aeCairoLibrary uniqueInstance libraryName ]}.
		'Freetype: '. {
			[ (aeFTLibrary := self class environment at: #AeFTLibrary) newInitialized versionString ].
			[ aeFTLibrary ffiLibrary uniqueInstance libraryName ]}.
		'Harfbuzz: '. {
			[ (aeHarfbuzzLibrary := self class environment at: #AeHarfbuzzLibrary) uniqueInstance versionString ].
			[ aeHarfbuzzLibrary uniqueInstance libraryName ]}.
		'SDL2:     '. {
			[ SDL2 version versionString ].
			[ SDL2Library uniqueInstance libraryName ]}.

	} 	pairsDo: [ :label :blockArray |
		Stdio stdout << label.
		blockArray do: [ :each |
			Stdio stdout
				<< (each onErrorDo: [ '---' ]);
				<< ' 	' ].
		Stdio stdout lf ]
]
