Class {
	#name : #AeCairoSurfaceForm,
	#superclass : #Form,
	#instVars : [
		'surface'
	],
	#category : #'Alexandrie-FFI-Form'
}

{ #category : #'as yet unclassified' }
AeCairoSurfaceForm >> isNull [

	^ false
]

{ #category : #accessing }
AeCairoSurfaceForm >> surface [
	^ surface
]

{ #category : #accessing }
AeCairoSurfaceForm >> surface: anAeCairoSurface [
	surface := anAeCairoSurface
]
