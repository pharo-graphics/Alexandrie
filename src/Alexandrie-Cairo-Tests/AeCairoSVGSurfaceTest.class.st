Class {
	#name : #AeCairoSVGSurfaceTest,
	#superclass : #AeCairoExportSurfaceTest,
	#category : #'Alexandrie-Cairo-Tests'
}

{ #category : #accessing }
AeCairoSVGSurfaceTest >> fileName [

	^ self utf8String, '.svg'
]

{ #category : #accessing }
AeCairoSVGSurfaceTest >> surfaceClass [

	^ AeCairoSVGSurface
]
