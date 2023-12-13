Class {
	#name : #AthensAeCairoTigerWindow,
	#superclass : #AthensTigerWindow,
	#category : #'Alexandrie-Athens-Examples'
}

{ #category : #initialization }
AthensAeCairoTigerWindow >> initialize [

	super initialize.

	surface := AthensAeCairoSurface extent: self class surfaceExtent.
	example := AthensTiger on: surface
]
