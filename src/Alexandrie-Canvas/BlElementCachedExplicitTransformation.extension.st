Extension { #name : #BlElementCachedExplicitTransformation }

{ #category : #'*Alexandrie-Canvas-Core' }
BlElementCachedExplicitTransformation >> aeApplyTo: aeCanvas element: aBlElement [

	self ensureMatrix.
	aeCanvas pathTransform:
		(AeCairoMatrix
			 x: matrix x
			 y: matrix y
			 sx: matrix sx
			 sy: matrix sy
			 shx: matrix shx
			 shy: matrix shy)
]
