Class {
	#name : #AeFaceEntry,
	#superclass : #Object,
	#instVars : [
		'index',
		'familyName',
		'styleName',
		'slant',
		'weight',
		'stretch',
		'wasStyleNameParsed'
	],
	#category : #'Alexandrie-FreeType-Core'
}

{ #category : #accessing }
AeFaceEntry >> ensureAnalysedAttributes [

	wasStyleNameParsed ifTrue: [ ^ self ].
	wasStyleNameParsed := true.

	"Guess from styleName"
	(styleName splitOn: Character space) readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [ self readStyleFrom: stream ] ]

]

{ #category : #accessing }
AeFaceEntry >> familyName [

	^ familyName
]

{ #category : #accessing }
AeFaceEntry >> familyName: aString [

	familyName := aString
]

{ #category : #accessing }
AeFaceEntry >> index [

	^ index
]

{ #category : #accessing }
AeFaceEntry >> index: aZeroBasedInteger [

	index := aZeroBasedInteger
]

{ #category : #initialization }
AeFaceEntry >> initialize [

	super initialize.
	
	wasStyleNameParsed := false.
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
AeFaceEntry >> readSemiStyleFrom: aStream [

	| token |
	token := aStream next asLowercase.
	
	token = 'bold' ifTrue: [ ^ weight := AeFontWeight semiBold ].

	1halt.
]

{ #category : #accessing }
AeFaceEntry >> readStyleFrom: aStream [
	"This is a aimplification of FreeTypeNameParser.
	
	References:
	- https://docs.microsoft.com/es-mx/typography/opentype/spec/os2#wtc
	"

	| token |
	token := aStream next asLowercase.
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
	(#(regular normal plain roman standard text) includes: token) ifTrue: [ 
		^ weight := AeFontWeight normal ].
	(#(medium) includes: token) ifTrue: [ 
		^ weight := AeFontWeight medium ].
	(#(semibold demibold demi) includes: token) ifTrue: [ 
		^ weight := AeFontWeight semiBold ].
	(#(bold) includes: token) ifTrue: [ 
		^ weight := AeFontWeight bold ].
	(#(extrabold) includes: token) ifTrue: [ 
		^ weight := AeFontWeight extraBold ].
	(#(black ultrabold heavy) includes: token) ifTrue: [ 
		^ weight := AeFontWeight black ].
	(#(extrablack) includes: token) ifTrue: [ 
		^ weight := AeFontWeight extraBlack ].

	(#(condensed) includes: token) ifTrue: [ 
		^ stretch := AeFontStretch condensed ].
	(#(wide) includes: token) ifTrue: [ 
		^ stretch := AeFontStretch semiExpanded ].

	token = 'boldoblique' ifTrue: [
		^ self
				readStyleFrom: { 'bold' } readStream;
				readStyleFrom: { 'oblique' } readStream ].

	token = 'bold.1.1' ifTrue: [
		^ self readStyleFrom: {'bold'} readStream ].

	(#(retina phetsarath ot housescript '6' '8' dot w0 w1 w2 w3 w4 w5 w6 w7 w8 w9 inline solid outline pinpoint titling chancery ornaments) includes: token)
		ifTrue: [ "ignore" ^self].

	token = 'ultra' ifTrue: [ 
		^ self readUltraStyleFrom: aStream ].
	token = 'semi' ifTrue: [ 
		^ self readSemiStyleFrom: aStream ].

	1halt.
]

{ #category : #accessing }
AeFaceEntry >> readUltraStyleFrom: aStream [

	| token |
	token := aStream next asLowercase.
	
	token = 'light' ifTrue: [ ^ weight := AeFontWeight extraLight ].

	1halt.
]

{ #category : #accessing }
AeFaceEntry >> slant [

	self ensureAnalysedAttributes.
	^ slant
]

{ #category : #accessing }
AeFaceEntry >> slant: anObject [

	slant := anObject
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
AeFaceEntry >> stretch: anObject [

	stretch := anObject
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

{ #category : #accessing }
AeFaceEntry >> weight: anObject [

	weight := anObject
]
