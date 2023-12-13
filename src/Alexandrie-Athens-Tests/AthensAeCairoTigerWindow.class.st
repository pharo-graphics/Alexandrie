Class {
	#name : #AthensAeCairoTigerWindow,
	#superclass : #AthensTigerWindow,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #running }
AthensAeCairoTigerWindow class >> openAnimated [
	<script: 'self openAnimated'>.
	
	super openAnimated.
]

{ #category : #initialization }
AthensAeCairoTigerWindow >> initialize [

	super initialize.

	surface := AthensAeCairoSurface extent: self class surfaceExtent.
	example := AthensTiger on: surface
]
