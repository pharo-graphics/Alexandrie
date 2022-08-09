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
			"self declareBlocOn: spec."
			spec
				package: 'Alexandrie-FFI';
				package: 'Alexandrie-FFI-Tests'
					with: [ spec requires: #('Alexandrie-FFI') ];
				package: 'Alexandrie-Canvas'
					with: [ spec requires: #('Alexandrie-FFI') ];
				package: 'Alexandrie-Canvas-Tests'
					with: [ spec requires: #('Alexandrie-Canvas') ]
			]
]

{ #category : #baseline }
BaselineOfAlexandrie >> declareBlocOn: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:dev-1.0/src' ]
]
