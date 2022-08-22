"
I am a Cairo FFI binding for `cairo_matrix_t`.

`cairo_matrix_t` is used throughout cairo to convert between different coordinate spaces. A `cairo_matrix_t` holds an affine transformation, such as a scale, rotation, shear, or a combination of these.

See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html
"
Class {
	#name : #AeCairoMatrix,
	#superclass : #FFIExternalStructure,
	#traits : 'AeTCairoLibrary',
	#classTraits : 'AeTCairoLibrary classTrait',
	#classVars : [
		'OFFSET_SHX',
		'OFFSET_SHY',
		'OFFSET_SX',
		'OFFSET_SY',
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #'field definition' }
AeCairoMatrix class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		double sx; double shy;
		double shx; double sy;
		double x; double y;	
	)
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newIdentity [

	^ self new
		  autoRelease;
		  primInitIdentity;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> scaleBy: aFactor [
	
	^ self x: 0
		y: 0
		sx: aFactor
		sy: aFactor
		shx: 0
		shy: 0
]

{ #category : #'instance creation' }
AeCairoMatrix class >> x: x y: y sx: sx sy: sy shx: shx shy: shy [

	^ self new
		  primInitX: x
		  y: y
		  sx: sx
		  sy: sy
		  shx: shx
		  shy: shy;
		  yourself
]

{ #category : #transformations }
AeCairoMatrix >> invert [

	self primInvert
]

{ #category : #testing }
AeCairoMatrix >> isIdentity [

	^ self x = 0.0 and: [ self y = 0.0 and: [ 
		self sx = 1.0 and: [ self sy = 1.0 and: [
			self shx = 0.0 and: [ self shy = 0.0 ] ] ] ] ]
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primInitIdentity [

	self ffiCall: #( void cairo_matrix_init_identity ( self ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primInitX: x y: y sx: sx sy: sy shx: shx shy: shy [

	self ffiCall: #(
		void
		cairo_matrix_init (
			self,
			double sx,
			double shy,
			double shx,
			double sy,
			double x,
			double y ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primInvert [

	self ffiCall: #( AeCairoStatus cairo_matrix_invert ( self ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primRotateByRadians: angle [

	self ffiCall: #( void cairo_matrix_rotate (
		self,
		double angle ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primScaleX: x y: y [

	self ffiCall: #( void cairo_matrix_scale (
			self,
			double x,
			double y ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primTransformX: xPointer y: yPointer [
	
	^ self ffiCall: #( void cairo_matrix_transform_point (
			self,
			double * xPointer, 
			double * yPointer))
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primTranslateX: px y: py [

	self ffiCall: #( void cairo_matrix_translate (
		self,
		double px,
		double py ))

]

{ #category : #printing }
AeCairoMatrix >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.

	{	{ self sx . self shy. }.
		{ self shx. self sy . }.
		{ self x  . self y    } }
			do: [ :eachRow |
				eachRow
					do: [ :eachValue |
						aStream nextPutAll: 
							(eachValue printShowingDecimalPlaces: 1) ] 
					separatedBy: [ aStream space ] ]
			separatedBy: [ aStream nextPutAll: ' | ' ].

	aStream nextPut: $).

]

{ #category : #transformations }
AeCairoMatrix >> rotateByRadians: angle [

	^ self primRotateByRadians: angle asFloat.
]

{ #category : #transformations }
AeCairoMatrix >> scaleBy: aPoint [

	self primScaleX: aPoint x y: aPoint y
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> shx [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SHX
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> shx: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SHX put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> shy [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SHY
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> shy: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SHY put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> sx [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SX
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> sx: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SX put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> sy [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SY
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> sy: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SY put: anObject
]

{ #category : #transformations }
AeCairoMatrix >> transform: aPoint [

	| x y |
	x := ByteArray new: 8.
	y := ByteArray new: 8.
	x doubleAt: 1 put: aPoint x.
	y doubleAt: 1 put: aPoint y.
	self primTransformX: x y: y.

	^ (x doubleAt: 1) @ (y doubleAt: 1)
]

{ #category : #transformations }
AeCairoMatrix >> translateBy: aPoint [

	self primTranslateX: aPoint x y: aPoint y
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
