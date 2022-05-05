Class {
	#name : #AeMorphicWindowHost,
	#superclass : #BlMorphicWindowHost,
	#category : #'Alexandrie-Canvas'
}

{ #category : #'driver selection' }
AeMorphicWindowHost class >> label [

	^ 'Morphic Alexandrie'
]

{ #category : #'host - api' }
AeMorphicWindowHost >> createHostSpaceFor: aSpace [
	"Create and assign a new morphic host space for given bloc space"

	| aWindow aHostSpace|
	aWindow := self createMorphicWindowFor: aSpace.

	aHostSpace := BlMorphicWindowHostSpace new
		morphicWindow: aWindow;
		host: self;
		universe: self universe;
		space: aSpace;
		renderer: AeRenderer new;
		yourself.

	aSpace hostSpace: aHostSpace
]
