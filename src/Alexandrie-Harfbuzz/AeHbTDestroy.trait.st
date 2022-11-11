"
I'm a trait for all classes that represent bindings to Harfbuzz library and responsability to destroy is on Pharo-side.

"
Trait {
	#name : #AeHbTDestroy,
	#category : #'Alexandrie-Harfbuzz-Library'
}

{ #category : #finalization }
AeHbTDestroy classSide >> destroyHandle: aHandle [
	
	self explicitRequirement
]

{ #category : #finalization }
AeHbTDestroy classSide >> finalizeResourceData: aHandle [

	aHandle isNull ifTrue: [ ^ self ].
	self destroyHandle: aHandle.
	aHandle beNull
]
