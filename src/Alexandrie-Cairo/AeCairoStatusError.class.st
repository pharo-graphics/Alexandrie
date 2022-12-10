"
I represent one of the errors that can occur when using Cairo. 

I wrap a `AeCairoStatus`, which in some cases is returned directly by functions. In other cases, the error is stored in objects and retrieved with cairo_status* functions.

"
Class {
	#name : #AeCairoStatusError,
	#superclass : #Error,
	#instVars : [
		'status'
	],
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #'instance creation' }
AeCairoStatusError class >> newFor: anAeCairoStatus [ 
	
	^ self basicNew
		initializeFor: anAeCairoStatus;
		yourself
]

{ #category : #signalling }
AeCairoStatusError class >> signalFor: anAeCairoStatus [ 
	
	^ (self newFor: anAeCairoStatus) signal
]

{ #category : #initialization }
AeCairoStatusError >> initializeFor: anAeCairoStatus [ 

	self initialize.
	status := anAeCairoStatus.
	self messageText: anAeCairoStatus description
]
