Class {
	#name : #AeHeadlessHostSpace,
	#superclass : #Object,
	#instVars : [
		'canvas'
	],
	#category : #'Alexandrie-Canvas'
}

{ #category : #converting }
AeHeadlessHostSpace >> asForm [
	"Useful for debugging"

	^ canvas asForm	
]

{ #category : #private }
AeHeadlessHostSpace >> ensureCanvas [

	canvas ifNil:[
		canvas := AeCanvas extent: self extentAsPoint ]

]

{ #category : #private }
AeHeadlessHostSpace >> extentAsPoint [

	^ 500 asPoint
]

{ #category : #enumerating }
AeHeadlessHostSpace >> fetchedEventsDo: aFullBlockClosure [ 

	
]

{ #category : #'host space - events' }
AeHeadlessHostSpace >> generateEvents [

	
]

{ #category : #testing }
AeHeadlessHostSpace >> hasResized [

	^ false
]

{ #category : #'host space - geometry' }
AeHeadlessHostSpace >> logicalSize [
	
	^ self extentAsPoint asLogicalSize
]

{ #category : #testing }
AeHeadlessHostSpace >> needsRebuild [

	^ false
]

{ #category : #rendering }
AeHeadlessHostSpace >> render: aBlSpace [ 

	self ensureCanvas.
	canvas fullDraw: aBlSpace root.

]

{ #category : #'host space - rendering' }
AeHeadlessHostSpace >> requestRedraw [

	
]

{ #category : #'host space - displaying' }
AeHeadlessHostSpace >> show [

]

{ #category : #'host space - geometry' }
AeHeadlessHostSpace >> windowExtent: aPoint [ 

]
