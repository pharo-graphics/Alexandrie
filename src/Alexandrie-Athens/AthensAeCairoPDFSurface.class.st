"
I export drawing operations to PDF files using Alexandrie Cairo.
"
Class {
	#name : #AthensAeCairoPDFSurface,
	#superclass : #AthensAeCairoExportSurface,
	#category : #'Alexandrie-Athens'
}

{ #category : #accessing }
AthensAeCairoPDFSurface class >> cairoSurfaceClass [

	^ AeCairoPDFSurface
]
