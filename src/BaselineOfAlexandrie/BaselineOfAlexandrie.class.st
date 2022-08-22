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
					
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-Cairo' 'Alexandrie-FreeType') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-Cairo-Tests') ]
			]
]

{ #category : #actions }
BaselineOfAlexandrie >> postload: loader package: packageSpec [

	"Ignore pre and post loads if already executed"
	Initialized = true ifTrue: [ ^ self ].

	AeNotoColorEmojiDownloadedFont new ensureDownloaded.

	Initialized := true.
]
