Trait {
	#name : #AeTCairoDestroy,
	#category : #'Alexandrie-FFI-Library'
}

{ #category : #finalization }
AeTCairoDestroy classSide >> finalizeResourceData: aHandle [

	aHandle isNull ifTrue: [ ^ self ].
	self primDestroy: aHandle.
	aHandle beNull
]

{ #category : #finalization }
AeTCairoDestroy classSide >> primDestroy: aHandle [
	
	self explicitRequirement
]
