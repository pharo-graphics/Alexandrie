"
I'm an `ImageMorph` that refreshes periodically.

I can be useful to watch changes on an object that can be converted to `Form`.
 
"
Class {
	#name : 'AePollingImageMorph',
	#superclass : 'ImageMorph',
	#instVars : [
		'model',
		'stepTime'
	],
	#category : 'Alexandrie-NewTools',
	#package : 'Alexandrie-NewTools'
}

{ #category : 'stepping' }
AePollingImageMorph >> initialize [

	super initialize.

	stepTime := 50
]

{ #category : 'accessing' }
AePollingImageMorph >> model: anObjectThatRespondsToAsForm [
	
	model := anObjectThatRespondsToAsForm.
	self refreshForm.
]

{ #category : 'stepping' }
AePollingImageMorph >> refreshForm [
	
	model ifNil: [ ^self ].
	self form: model asForm
]

{ #category : 'stepping' }
AePollingImageMorph >> step [

	self refreshForm
]

{ #category : 'stepping' }
AePollingImageMorph >> stepTime [

	^ stepTime
]

{ #category : 'stepping' }
AePollingImageMorph >> stepTime: aNumberOfMilliseconds [

	stepTime := aNumberOfMilliseconds
]

{ #category : 'stepping' }
AePollingImageMorph >> wantsSteps [

	^ true
]
