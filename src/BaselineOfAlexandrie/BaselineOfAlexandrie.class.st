Class {
	#name : #BaselineOfAlexandrie,
	#superclass : #BaselineOf,
	#category : #BaselineOfAlexandrie
}

{ #category : #baseline }
BaselineOfAlexandrie >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [
			spec
				package: 'Alexandrie-FFI';
				package: 'Alexandrie-FFI-Tests'
					with: [ spec requires: #('Alexandrie-FFI') ];
					
				package: 'Alexandrie-FreeType';
				package: 'Alexandrie-FreeType-Tests'
					with: [ spec requires: #('Alexandrie-FreeType') ];
					
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-FFI' 'Alexandrie-FreeType') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas' 'Alexandrie-FreeType-Tests' 'Alexandrie-FFI-Tests') ]
			]
]
