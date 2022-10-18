Extension { #name : #'SDL_Version' }

{ #category : #'*Alexandrie-Canvas' }
SDL_Version >> versionString [

	^ String streamContents: [ :aStream | self printAsSemanticVersioningOn: aStream ]

]
