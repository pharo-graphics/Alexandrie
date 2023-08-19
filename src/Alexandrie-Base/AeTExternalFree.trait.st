"
I'm a trait for all classes that represent bindings to Cairo library and need to be freed/destroyed.
"
Trait {
	#name : #AeTExternalFree,
	#category : #'Alexandrie-Base'
}

{ #category : #finalization }
AeTExternalFree classSide >> externallyFree: aHandle [
	
	self explicitRequirement
]

{ #category : #finalization }
AeTExternalFree classSide >> finalizeResourceData: aHandle [

	aHandle isNull ifTrue: [ ^ self ].
	self externallyFree: aHandle.
	aHandle beNull
]

{ #category : #finalization }
AeTExternalFree >> externallyFree [

	self class finalizeResourceData: self resourceData
]

{ #category : #finalization }
AeTExternalFree >> resourceData [

	self getHandle
]
