"
I export drawing operations to SVG files using Alexandrie Cairo.
"
Class {
	#name : #AthensAeCairoSVGSurface,
	#superclass : #AthensAeCairoExportSurface,
	#category : #'Alexandrie-Athens'
}

{ #category : #accessing }
AthensAeCairoSVGSurface class >> cairoSurfaceClass [

	^ AeCairoSVGSurface
]
