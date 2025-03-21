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

				package: 'Alexandrie-FreeType'
					with: [ spec requires: #('Alexandrie-Base') ];
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #('Alexandrie-FreeType' 'Alexandrie-Base-Tests') ];

				package: 'Alexandrie-Cairo'
					with: [ spec requires: #('Alexandrie-FreeType') ];
				package: 'Alexandrie-Cairo-Tests'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType-Tests') ];
					
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
				
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType' 'Alexandrie-Harfbuzz') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-Cairo-Tests') ];

				package: 'Alexandrie-NewTools'
					with: [ spec requires: #('Alexandrie-Canvas') ];
				package: 'Alexandrie-NewTools-Tests'
					with: [ spec requires: #('Alexandrie-NewTools' 'Alexandrie-Canvas-Tests') ].

			spec
				group: 'ffi-minimal' with: #('Alexandrie-Harfbuzz' 'Alexandrie-Cairo' 'Alexandrie-FreeType');
				group: 'development' with: #('Alexandrie-NewTools-Tests' 'Alexandrie-Harfbuzz-Tests' 'Alexandrie-FontManager-Tests');
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
BaselineOfAlexandrie >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized ifNotNil: [ ^ self ].

	"Re-initialize enumerations as they is executed before the subclasses
	are loaded since they are packaged separately.
	Additionally: reference the class indirectly to avoid NewUndeclaredWarning."
	(self class environment at: #AeEnumeration) initialize.

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
