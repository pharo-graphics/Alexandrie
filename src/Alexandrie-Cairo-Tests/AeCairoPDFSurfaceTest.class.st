Class {
	#name : 'AeCairoPDFSurfaceTest',
	#superclass : 'AeCairoExportSurfaceTest',
	#category : 'Alexandrie-Cairo-Tests',
	#package : 'Alexandrie-Cairo-Tests'
}

{ #category : 'accessing' }
AeCairoPDFSurfaceTest >> fileName [

	^ self utf8String, '.pdf'
]

{ #category : 'accessing' }
AeCairoPDFSurfaceTest >> surfaceClass [

	^ AeCairoPDFSurface
]
