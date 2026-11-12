"
I am an abstract export surface for vector formats such as PDF and SVG using Alexandrie Cairo.
"
Class {
	#name : #AthensAeCairoExportSurface,
	#superclass : #AthensAeCairoSurface,
	#category : #'Alexandrie-Athens'
}

{ #category : #'instance creation' }
AthensAeCairoExportSurface class >> extent: anExtent fileName: aFileName [

	| cairoExportSurface |
	cairoExportSurface := self cairoSurfaceClass extent: anExtent to: aFileName asFileReference.
	^ self on: cairoExportSurface
]

{ #category : #finalization }
AthensAeCairoExportSurface >> close [

	self finish
]
