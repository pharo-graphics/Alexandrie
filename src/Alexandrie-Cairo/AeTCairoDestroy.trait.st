"
I'm a trait for all classes that represent bindings to Cairo library and need to be freed/destroyed.
"
Trait {
	#name : #AeTCairoDestroy,
	#category : #'Alexandrie-Cairo-Library'
}

{ #category : #finalization }
AeTCairoDestroy classSide >> destroyHandle: aHandle [
	
	self explicitRequirement
]

{ #category : #finalization }
AeTCairoDestroy classSide >> finalizeResourceData: aHandle [

	aHandle isNull ifTrue: [ ^ self ].
	self destroyHandle: aHandle.
	aHandle beNull
]
