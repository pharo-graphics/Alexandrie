Extension { #name : #AeCairoImageSurface }

{ #category : #'*Alexandrie-Athens' }
AeCairoImageSurface >> asAthensPaintOn: aCanvas [

	^ AeCairoSurfacePattern surface: self
]
