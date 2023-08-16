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
	#category : #'Alexandrie-Cairo-Structures'
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
		  beIdentity;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newRotationByRadians: angle [

	^ self new
		  beRotationByRadians: angle;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newScalingBy: aPoint [

	^ self newScalingByX: aPoint x y: aPoint y
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newScalingByX: sx y: sy [

	^ self new
		  beScaleByX: sx y: sy;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newTranslationBy: aPoint [

	^ self newTranslationByX: aPoint x y: aPoint y
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newTranslationByX: x y: y [

	^ self new
		  beTranslationByX: x y: y;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newX: x y: y sx: sx sy: sy shx: shx shy: shy [

	^ self new
		  beX: x
		  y: y
		  sx: sx
		  sy: sy
		  shx: shx
		  shy: shy;
		  yourself
]

{ #category : #'instance creation' }
AeCairoMatrix class >> unownedNew [
	"Answer a new instance. Sender is responsible of freeing handle."

	^ self externalNew
]

{ #category : #comparing }
AeCairoMatrix >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	self getHandle = anObject getHandle ifTrue: [ ^ true ].

	^ self sx = anObject sx
		and: [ self shy = anObject shy
			and: [ self shx = anObject shx
				and: [ self sy = anObject sy
					and: [ self x = anObject x
						and: [ self y = anObject y ] ] ] ] ]
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beIdentity [
	"Mutate myself to be an identity transformation.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init-identity"

	self ffiCall: #( void cairo_matrix_init_identity ( self ) )
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beRotationByRadians: angle [
	"Mutate myself to be a transformation that rotates.

	Receives the angle of rotation, in radians. The direction of rotation is defined such that positive angles rotate in the direction from the positive X axis toward the positive Y axis. With the default axis orientation of cairo, positive angles rotate in a clockwise direction.

	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init-rotate"

	self ffiCall: #(
		void
		cairo_matrix_init_rotate (
			self,
			double angle ) )
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beScaleBy: aPoint [
	"Mutate myself to be a transformation that scales by aPoint"
	
	self beScaleByX: aPoint x y: aPoint y
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beScaleByX: sx y: sy [
	"Mutate myself to be a transformation that scales by sx and sy in the X and Y dimensions, respectively.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init-scale"
	
	self ffiCall: #(
		void
		cairo_matrix_init_scale (
			self,
			double sx,
			double sy ) )
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beTranslationBy: aPoint [
	"Mutate myself to be a transformation that translates by aPoint"

	self beTranslationByX: aPoint x y: aPoint y
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beTranslationByX: tx y: ty [
	"Mutate myself to be a transformation that translates by tx and ty in the X and Y dimensions, respectively.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init-translate"

	self ffiCall: #(
		void
		cairo_matrix_init_translate (
			self,
			double tx,
			double ty ) )
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beX: x0 y: y0 sx: xx sy: yy shx: xy shy: yx [
	"Mutate myself to be the affine transformation given by xx, yx, xy, yy, x0, and y0.
	The transformation is given by:

		x_new = xx * x + xy * y + x0;
		y_new = yx * x + yy * y + y0;

	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init"

	self ffiCall: #(
		void
		cairo_matrix_init (
			self,
			double xx,
			double yx,
			double xy,
			double yy,
			double x0,
			double y0 ) )
]

{ #category : #comparing }
AeCairoMatrix >> hash [

	^ ((((self sx hash
		bitXor: self shy hash)
			bitXor: self shx hash)
				bitXor: self sy hash)
					bitXor: self x hash)
						bitXor: self y hash
]

{ #category : #'API - initialize' }
AeCairoMatrix >> invert [

	^ self ffiCall: #( AeCairoStatus cairo_matrix_invert ( self ) )
]

{ #category : #testing }
AeCairoMatrix >> isIdentity [

	^ self x = 0.0 and: [ self y = 0.0 and: [ 
		self sx = 1.0 and: [ self sy = 1.0 and: [
			self shx = 0.0 and: [ self shy = 0.0 ] ] ] ] ]
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

{ #category : #'API - transformations' }
AeCairoMatrix >> rotateByRadians: angle [

	self ffiCall: #(
		void
		cairo_matrix_rotate (
			self,
			double angle ) )
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleBy: aPoint [

	self scaleByX: aPoint x y: aPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleByX: x y: y [

	self ffiCall: #(
		void
		cairo_matrix_scale (
			self,
			double x,
			double y ) )
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

{ #category : #'API - transformations' }
AeCairoMatrix >> translateBy: aPoint [

	self translateByX: aPoint x y: aPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> translateByX: px y: py [

	self ffiCall: #(
		void
		cairo_matrix_translate (
			self,
			double px,
			double py ) )

]

{ #category : #'API - query' }
AeCairoMatrix >> value: aPoint [
	"Answer aPoint transformed by self."

	| x y |
	x := ByteArray new: 8.
	y := ByteArray new: 8.
	x doubleAt: 1 put: aPoint x.
	y doubleAt: 1 put: aPoint y.
	self valueOnX: x onY: y.

	^ (x doubleAt: 1) @ (y doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoMatrix >> valueOnX: xPointer onY: yPointer [
	
	^ self ffiCall: #(
		void
		cairo_matrix_transform_point (
			self,
			double * xPointer, 
			double * yPointer ) )
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
