"
I'm a host that proocesses its frames normally, but doesn't open any kind of window and do not copy bytes from the rendered surface to any place. Also, I don't generate mouse or keyboard events, but any events enqueued such as the ones from animations.

"
Class {
	#name : #AeHeadlessHost,
	#superclass : #Object,
	#category : #'Alexandrie-Canvas'
}

{ #category : #accessing }
AeHeadlessHost class >> stop [
	
	
]

{ #category : #enumerating }
AeHeadlessHost class >> uiProcessDo: aFullBlockClosure [ 
	
	^ aFullBlockClosure value: Processor activeProcess
]

{ #category : #'host - api' }
AeHeadlessHost >> createHostSpaceFor: aBlSpace [ 
	
	| aHostSpace |
	aHostSpace := AeHeadlessHostSpace new.
"	aHostSpace universe: aBlSpace universe.
	aHostSpace host: self."
"	aHostSpace space: aBlSpace." "Only because BlHostRenderer>>render: wants to know it?"
"	aHostSpace renderer: AeRenderer new."
	aBlSpace hostSpace: aHostSpace.

]

{ #category : #'host - api' }
AeHeadlessHost >> destroyHostSpaceFor: aBlSpace [

	aBlSpace detachHostSpace
]

{ #category : #testing }
AeHeadlessHost >> isRunning [

	^ true
]

{ #category : #testing }
AeHeadlessHost >> isStillAvailable [

	^ true
]
