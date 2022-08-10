Class {
	#name : #AeFaceEntry,
	#superclass : #Object,
	#instVars : [
		'familyName',
		'styleName',
		'slant',
		'weight',
		'stretch'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFaceEntry >> applyStyleToken: token [

	(AeFontSlant normalTags includes: token) ifTrue: [ 
		^ slant := AeFontSlant normal ].
	(AeFontSlant italicTags includes: token) ifTrue: [ 
		^ slant := AeFontSlant italic ].
	(AeFontSlant obliqueTags includes: token) ifTrue: [ 
		^ slant := AeFontSlant oblique ].

	(#(thin hairline) includes: token) ifTrue: [ 
		^ weight := AeFontWeight thin ].
	(#(extralight ultralight) includes: token) ifTrue: [ 
		^ weight := AeFontWeight extraLight ].
	(#(light) includes: token) ifTrue: [ 
		^ weight := AeFontWeight light ].
	(#(semilight) includes: token) ifTrue: [ 
		^ weight := AeFontWeight semiLight ].
	(#(medium) includes: token) ifTrue: [ 
		^ weight := AeFontWeight medium ].
	(#(semibold demibold demi) includes: token) ifTrue: [ 
		^ weight := AeFontWeight semiBold ].
	(#(bold) includes: token) ifTrue: [ 
		^ weight := AeFontWeight bold ].
	(#(extrabold) includes: token) ifTrue: [ 
		^ weight := AeFontWeight extraBold ].
	(#(black ultrabold) includes: token) ifTrue: [ 
		^ weight := AeFontWeight black ].

	(#(condensed) includes: token) ifTrue: [ 
		^ stretch := AeFontStretch condensed ].

	token = 'boldoblique' ifTrue: [
		^ self
				applyStyleToken: 'bold';
				applyStyleToken: 'oblique' ].

	token = 'bold.1.1' ifTrue: [
		^ self applyStyleToken: 'bold' ].

	(#(retina phetsarath ot) includes: token)
		ifTrue: [ "ignore" ^self].

	1halt.
]

{ #category : #accessing }
AeFaceEntry >> ensureAnalysedAttributes [

	weight ifNotNil: [ ^ self ].

	"Set defaults"
	weight := AeFontWeight normal.
	slant := AeFontSlant normal.
	stretch := AeFontStretch normal.

	"Modify according to styleName tokens"
	styleName splitOn: Character space do: [ :token |
		self applyStyleToken: token asLowercase ]

]

{ #category : #accessing }
AeFaceEntry >> familyName [

	^ familyName
]

{ #category : #accessing }
AeFaceEntry >> familyName: aString [

	familyName := aString
]

{ #category : #'instance creation' }
AeFaceEntry >> newFaceWith: anAeFTLibrary [
	"Answer a new AeFTFace created in the library."

	^ self subclassResponsibility
]

{ #category : #printing }
AeFaceEntry >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPutAll: '(';
		print: familyName;
		space;
		print: styleName;
		nextPutAll: ')'
]

{ #category : #accessing }
AeFaceEntry >> slant [

	self ensureAnalysedAttributes.
	^ slant
]

{ #category : #accessing }
AeFaceEntry >> slantWeightStretch [

	self ensureAnalysedAttributes.
	^ { slant. weight. stretch }
]

{ #category : #accessing }
AeFaceEntry >> stretch [

	self ensureAnalysedAttributes.
	^ stretch
]

{ #category : #accessing }
AeFaceEntry >> styleName [

	^ styleName
]

{ #category : #accessing }
AeFaceEntry >> styleName: aString [

	styleName := aString
]

{ #category : #accessing }
AeFaceEntry >> weight [

	self ensureAnalysedAttributes.
	^ weight
]
