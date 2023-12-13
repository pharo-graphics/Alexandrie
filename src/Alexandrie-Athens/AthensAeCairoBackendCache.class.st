Class {
	#name : #AthensAeCairoBackendCache,
	#superclass : #Object,
	#instVars : [
		'cache'
	],
	#classInstVars : [
		'soleInstance',
		'session'
	],
	#category : #'Alexandrie-Athens'
}

{ #category : #'session management' }
AthensAeCairoBackendCache class >> checkSession [

	session == Smalltalk session ifFalse: [
		soleInstance := nil.
		session := Smalltalk session ]
]

{ #category : #flushing }
AthensAeCairoBackendCache class >> flush [

	self soleInstance flush
]

{ #category : #'instance creation' }
AthensAeCairoBackendCache class >> new [

	self error: 'Use #soleInstance'
]

{ #category : #'instance creation' }
AthensAeCairoBackendCache class >> soleInstance [

	self checkSession.
	^ soleInstance ifNil: [ soleInstance := super new ]
]

{ #category : #accessing }
AthensAeCairoBackendCache >> at: anObject [

	^ cache at: anObject ifAbsent: nil
]

{ #category : #accessing }
AthensAeCairoBackendCache >> at: anObject ifAbsentPut: aBlock [

	^ cache at: anObject ifAbsentPut: aBlock
]

{ #category : #accessing }
AthensAeCairoBackendCache >> flush [

	cache := WeakIdentityKeyDictionary new
]

{ #category : #accessing }
AthensAeCairoBackendCache >> for: anObject at: key ifAbsentPut: aBlock [

	| subCache |
	subCache := cache
		at: anObject
		ifAbsentPut: [ WeakIdentityKeyDictionary new ].

	^ subCache at: key ifAbsentPut: aBlock
]

{ #category : #initialization }
AthensAeCairoBackendCache >> initialize [

	self flush
]

{ #category : #removing }
AthensAeCairoBackendCache >> removeAt: anObject [

	^ cache removeKey: anObject ifAbsent: nil
]
