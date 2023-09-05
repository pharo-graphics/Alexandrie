Class {
	#name : #AeCairoExportSurfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'surface',
		'target'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #testing }
AeCairoExportSurfaceTest class >> isAbstract [
		
	^ self == AeCairoExportSurfaceTest
]

{ #category : #tests }
AeCairoExportSurfaceTest >> assertExportsToTarget [

	| aContext |
	surface := self surfaceClass
		           extent: 100 @ 300
		           to: target.

	surface status ensureIsSuccess.

	aContext := surface newContext.

	"red rectangle"
	aContext
		sourceColorRGB: Color red;
		translateByX: 5 y: 5;
		rectangle: (0 @ 0 corner: 20 @ 20);
		fill.

	"blue rectangle"
	aContext
		sourceColorRGB: Color blue;
		translateByX: 5 y: 5;
		rectangle: (0 @ 0 corner: 20 @ 20);
		fill.

	"Make cairo write and close the file."
	surface finish.

	self assert: target exists.
	self assert: target size > 400 "Good enough as smoke test"
]

{ #category : #running }
AeCairoExportSurfaceTest >> ensureDeletePossibleTargets [

	self targetInSubdirectory parent ensureDeleteAll.
	self targetInSubdirectory ensureDelete.
	self targetInCurrentWorkingDirectory ensureDelete.

]

{ #category : #accessing }
AeCairoExportSurfaceTest >> fileName [

	^ self subclassResponsibility
]

{ #category : #running }
AeCairoExportSurfaceTest >> setUp [

	super setUp.
	self ensureDeletePossibleTargets
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> surfaceClass [

	^ self subclassResponsibility
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> targetInCurrentWorkingDirectory [

	^ FileSystem workingDirectory / self fileName
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> targetInSubdirectory [

	^ FileSystem workingDirectory / self utf8String / self fileName
]

{ #category : #running }
AeCairoExportSurfaceTest >> tearDown [

	surface ifNotNil: #finish.
	self ensureDeletePossibleTargets.
	super tearDown
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testExportInCurrentWorkingDirectory [

	target := self targetInCurrentWorkingDirectory.

	self assertExportsToTarget
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testExportInSubdirectory [

	target := self targetInSubdirectory.
	self targetInSubdirectory parent ensureCreateDirectory.

	self assertExportsToTarget
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testExportInUnexistentSubdirectoryFails [

	target := self targetInSubdirectory.

	self
		should: [ self assertExportsToTarget ]
		raise: AeCairoStatusError
		description: 'AeCairoStatusError: CAIRO_STATUS_WRITE_ERROR (error while writing to output stream)'
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testHasDevice [
	"This kind of cairo surfaces don't have a device."

	surface := self surfaceClass
		           extent: 1 @ 1
		           to: self targetInCurrentWorkingDirectory.

	self deny: surface hasDevice
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> utf8String [
	"Answer a filename (or directory name) that requires utf-8 encoding, to challenge the FFI bindings."

	^ 'testëxpört'
]
