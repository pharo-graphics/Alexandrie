"
An AeCairoQuartzSurfaceTest is a test class for testing the behavior of AeCairoQuartzSurface
"
Class {
	#name : #AeCairoQuartzSurfaceTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #tests }
AeCairoQuartzSurfaceTest >> testExportPNG [

	| aSurface filename |
	Smalltalk os isMacOSX ifFalse: [ ^ self skip ].
	
	aSurface := AeCairoQuartzSurface
						extent: 100 @ 100
						format: AeCairoSurfaceFormat rgb24.

	self assert: aSurface status isSuccess.
	
	filename := (Time microsecondClockValue asString, '.png') asFileReference.
	self deny: filename exists.
	aSurface writePngTo: filename.
	self assert: filename exists.
]
