Extension { #name : #FFIEnumeration }

{ #category : #'*Alexandrie-FreeType' }
FFIEnumeration class >> bitFlagNamesAt: anInteger [
	"
	self bitFlagNamesAt: 7
	"

	^ Array streamContents: [ :stream |
		self enumerationDictionary keysAndValuesDo: [ :eachName :eachValue |
			(anInteger allMask: eachValue) ifTrue: [
				stream nextPut: eachName ] ] ]
]

{ #category : #'*Alexandrie-FreeType' }
FFIEnumeration class >> bitFlagsAt: anInteger [
	"
	self bitFlagsAt: 7
	"

	^ Array streamContents: [ :stream |
		self enumerationDictionary keysAndValuesDo: [ :eachName :eachValue |
			(anInteger allMask: eachValue) ifTrue: [
				stream nextPut: (self fromInteger: eachValue) ] ] ]
]
