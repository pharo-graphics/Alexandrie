"
I test PDF and SVG export surfaces in Alexandrie-Athens.
"
Class {
	#name : #AthensAeCairoExportSurfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'fileReference'
	],
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #running }
AthensAeCairoExportSurfaceTest >> tearDown [

	fileReference ifNotNil: [ fileReference ensureDelete ].
	super tearDown
]

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testExportPDF [

	| surface |
	fileReference := FileLocator temp / ('athens-test-', UUID new asString, '.pdf').
	surface := AthensAeCairoPDFSurface extent: 100 @ 100 fileName: fileReference fullName.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color red.
		canvas drawShape: (0 @ 0 extent: 50 @ 50).
		canvas setPaint: Color blue.
		canvas drawString: 'Athens PDF' ].
	surface close.
	self assert: fileReference exists.
	self assert: fileReference size > 0
]

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testExportSVG [

	| surface |
	fileReference := FileLocator temp / ('athens-test-', UUID new asString, '.svg').
	surface := AthensAeCairoSVGSurface extent: 100 @ 100 fileName: fileReference fullName.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color green.
		canvas drawShape: (0 @ 0 extent: 50 @ 50).
		canvas setPaint: Color black.
		canvas drawString: 'Athens SVG' ].
	surface close.
	self assert: fileReference exists.
	self assert: fileReference size > 0
]

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testShowPageAndCopyPage [

	| surface |
	fileReference := FileLocator temp / ('athens-test-', UUID new asString, '.pdf').
	surface := AthensAeCairoPDFSurface extent: 100 @ 100 fileName: fileReference fullName.
	surface drawDuring: [ :canvas |
		canvas setPaint: Color red.
		canvas drawShape: (0 @ 0 extent: 50 @ 50).
		canvas showPage.
		canvas setPaint: Color blue.
		canvas drawShape: (0 @ 0 extent: 30 @ 30).
		canvas copyPage ].
	surface close.
	self assert: fileReference exists.
	self assert: fileReference size > 0
]
