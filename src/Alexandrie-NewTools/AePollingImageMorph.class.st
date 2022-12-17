"
I'm an `ImageMorph` that refreshes periodically.

I can be useful to watch changes on an object that can be converted to `Form`.
 
"
Class {
	#name : #AePollingImageMorph,
	#superclass : #ImageMorph,
	#instVars : [
		'model',
		'stepTime'
	],
	#category : #'Alexandrie-NewTools'
}

{ #category : #stepping }
AePollingImageMorph >> initialize [

	super initialize.

	stepTime := 500
]

{ #category : #accessing }
AePollingImageMorph >> model: anObjectThatRespondsToAsForm [
	
	model := anObjectThatRespondsToAsForm
]

{ #category : #stepping }
AePollingImageMorph >> step [
	
	self form: model asForm
]

{ #category : #stepping }
AePollingImageMorph >> stepTime [

	^ stepTime
]

{ #category : #stepping }
AePollingImageMorph >> stepTime: aNumberOfMilliseconds [

	stepTime := aNumberOfMilliseconds
]

{ #category : #stepping }
AePollingImageMorph >> wantsSteps [

	^ true
]
