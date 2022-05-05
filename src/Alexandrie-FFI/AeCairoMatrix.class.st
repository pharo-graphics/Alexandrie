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
	#category : #'Alexandrie-FFI-Core'
}

{ #category : #'field definition' }
AeCairoMatrix class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		double sx; double shx;
		double shy; double sy;
		double x; double y;	
	)
]

{ #category : #'instance creation' }
AeCairoMatrix class >> x: x y: y sx: sx sy: sy shx: shx shy: shy [

	^ self new
		  initX: x
		  y: y
		  sx: sx
		  sy: sy
		  shx: shx
		  shy: shy;
		  yourself
]

{ #category : #initialization }
AeCairoMatrix >> initX: aX y: aY sx: aSx sy: aSy shx: aShX shy: aShY [

	self
		primInitX: aX
		y: aY
		sx: aSx
		sy: aSy
		shx: aShX
		shy: aShY
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

{ #category : #initialization }
AeCairoMatrix >> loadIdentity [

	self primLoadIdentity
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primInitX: aX y: aY sx: aSx sy: aSy shx: aShX shy: aShY [

	self ffiCall: #( void cairo_matrix_init (
			self,
			double aSx,
			double aShY,
			double aShX,
			double aSy,
			double aX,
			double aY ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primInvert [

	self ffiCall: #( AeCairoStatus cairo_matrix_invert ( self ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primLoadIdentity [

	self ffiCall: #( void cairo_matrix_init_identity ( self ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primRotateByRadians: angle [

	self ffiCall: #( void cairo_matrix_rotate (
		self,
		double angle ) )
]

{ #category : #'private - ffi' }
AeCairoMatrix >> primScaleX: aX Y: aY [

	self ffiCall: #( void cairo_matrix_scale (
			self,
			double aX,
			double aY ) )
]

{ #category : #transformations }
AeCairoMatrix >> rotateByRadians: angle [

	^ self primRotateByRadians: angle asFloat.
]

{ #category : #transformations }
AeCairoMatrix >> scaleBy: aPoint [

	self primScaleX: aPoint x Y: aPoint y
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> shx [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SHX
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> shx: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SHX put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> shy [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SHY
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> shy: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SHY put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> sx [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SX
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> sx: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SX put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> sy [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_SY
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> sy: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_SY put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing structure variables' }
AeCairoMatrix >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
