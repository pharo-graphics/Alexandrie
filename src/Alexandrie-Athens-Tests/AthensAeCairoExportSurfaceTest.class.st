"
I test PDF and SVG export surfaces in Alexandrie-Athens.
"
Class {
	#name : #AthensAeCairoExportSurfaceTest,
	#superclass : #TestCase,
	#category : #'Alexandrie-Athens-Tests'
}

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testExportPDF [

	| fileRef surface |
	fileRef := FileLocator temp / ('athens-test-' , UUID new asString , '.pdf').
	[
		surface := AthensAeCairoPDFSurface extent: 100 @ 100 fileName: fileRef fullName.
		surface drawDuring: [ :canvas |
			canvas setPaint: Color red.
			canvas drawShape: (0 @ 0 extent: 50 @ 50).
			canvas setPaint: Color blue.
			canvas drawString: 'Athens PDF' ].
		surface close.
		self assert: fileRef exists.
		self assert: fileRef size > 0 ] ensure: [ fileRef ensureDelete ]
]

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testExportSVG [

	| fileRef surface |
	fileRef := FileLocator temp / ('athens-test-' , UUID new asString , '.svg').
	[
		surface := AthensAeCairoSVGSurface extent: 100 @ 100 fileName: fileRef fullName.
		surface drawDuring: [ :canvas |
			canvas setPaint: Color green.
			canvas drawShape: (0 @ 0 extent: 50 @ 50).
			canvas setPaint: Color black.
			canvas drawString: 'Athens SVG' ].
		surface close.
		self assert: fileRef exists.
		self assert: fileRef size > 0 ] ensure: [ fileRef ensureDelete ]
]

{ #category : #tests }
AthensAeCairoExportSurfaceTest >> testShowPageAndCopyPage [

	| fileRef surface |
	fileRef := FileLocator temp / ('athens-test-' , UUID new asString , '.pdf').
	[
		surface := AthensAeCairoPDFSurface extent: 100 @ 100 fileName: fileRef fullName.
		surface drawDuring: [ :canvas |
			canvas setPaint: Color red.
			canvas drawShape: (0 @ 0 extent: 50 @ 50).
			canvas showPage.
			canvas setPaint: Color blue.
			canvas drawShape: (0 @ 0 extent: 30 @ 30).
			canvas copyPage ].
		surface close.
		self assert: fileRef exists.
		self assert: fileRef size > 0 ] ensure: [ fileRef ensureDelete ]
]
