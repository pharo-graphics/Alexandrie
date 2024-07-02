Extension { #name : #'SDL_Version' }

{ #category : #'*BaselineOfAlexandrie' }
SDL_Version >> versionString [

	^ String streamContents: [ :aStream | self printAsSemanticVersioningOn: aStream ]

]
