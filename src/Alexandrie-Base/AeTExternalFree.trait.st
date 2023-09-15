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
AeTExternalFree >> autoRelease [
	"Add to finalization system so GC frees me when there are no more references.
	
	Based on `FFIExternalReference>>#autoRelease`, which is especially needed in `FFIExternalStructure` since it only auto-released the handle."

	FFIExternalResourceManager addResource: self
]

{ #category : #finalization }
AeTExternalFree >> externallyFree [

	self class finalizeResourceData: self resourceData
]

{ #category : #finalization }
AeTExternalFree >> resourceData [
	"Answer an object to be received in `finalizeResourceData:` to free external resources.
	Such object will be stored in a finalization registry, so shouldn't point directly or indirectly to myself."

	^ self getHandle
]
