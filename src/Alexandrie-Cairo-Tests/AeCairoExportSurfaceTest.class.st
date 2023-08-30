Class {
	#name : #AeCairoExportSurfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'surface'
	],
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #testing }
AeCairoExportSurfaceTest class >> isAbstract [
		
	^ self == AeCairoExportSurfaceTest
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> fileName [
	"Answer a filename that requires utf-8 encoding, to challenge the FFI binding."

	^ 'test_cairo_export_ū'
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> fileReference [

	^ self fileName asFileReference
]

{ #category : #running }
AeCairoExportSurfaceTest >> setUp [

	super setUp.
	self fileReference ensureDelete
]

{ #category : #accessing }
AeCairoExportSurfaceTest >> surfaceClass [

	^ self subclassResponsibility
]

{ #category : #running }
AeCairoExportSurfaceTest >> tearDown [

	surface finish.
	self fileReference ensureDelete.
	super tearDown
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testExportToFile [

	| aContext |
	surface := self surfaceClass
		extent: 100@100
		fileName: self fileName.

	aContext := surface newContext.
	"red rectangle"
	aContext
		sourceColorRGB: Color red;
		translateByX: 5 y: 5;
		rectangle: (0@0 corner: 20@20);
		fill.
	"blue rectangle"
	aContext
		sourceColorRGB: Color blue;
		translateByX: 5 y: 5;
		rectangle: (0@0 corner: 20@20);
		fill.

	"Make cairo write and close the file."
	surface finish.

	self assert: self fileReference exists.
	self assert: self fileReference size > 400
]

{ #category : #tests }
AeCairoExportSurfaceTest >> testHasDevice [

	surface := self surfaceClass
		extent: 1@1
		fileName: self fileName.

	self deny: surface hasDevice
]
