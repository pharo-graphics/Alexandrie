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
AeTExternalFree classSide >> finalizeResourceData: anObject [

	| aHandle |
	aHandle := self resourceDataFrom: anObject.
	aHandle isNull ifTrue: [ ^ self ].
	self externallyFree: aHandle.
	aHandle beNull
]

{ #category : #finalization }
AeTExternalFree classSide >> resourceDataFrom: anObject [
	"Answer the handle from the resource data received as parameter.
	This is the inverse of the `resourceData` as implemented in instance-side."

	^ anObject
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
	"Answer an object that doesn't point to self and that is used in `resourceDataFrom:` to obtain the handle at freeing time."

	^ self getHandle
]
