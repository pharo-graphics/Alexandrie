"
I am a Cairo FFI binding for `cairo_matrix_t`.

`cairo_matrix_t` is used throughout cairo to convert between different coordinate spaces. A `cairo_matrix_t` holds an affine transformation, such as a scale, rotation, shear, or a combination of these.

See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html
See: https://www.cairographics.org/cookbook/matrix_transform/
See: https://www.cairographics.org/cookbook/matrix_conventions/
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
	#category : #'Alexandrie-Cairo-Context'
}

{ #category : #'field definition' }
AeCairoMatrix class >> byteSize [
	^ 48
]

{ #category : #'field definition' }
AeCairoMatrix class >> fieldsDesc [
	"
	self rebuildFieldAccessors.
	
	self classSide compile: 'byteSize
	^ ', self byteSize asString classified: 'field definition'.
	"
	^ #(
		double sx; double shy;
		double shx; double sy;
		double x; double y;	
	)
]

{ #category : #'instance creation' }
AeCairoMatrix class >> multiply: a by: b into: result [
	"Multiplies the affine transformations in `a` and `b` together and stores the result in `result`. The effect of the resulting transformation is to first apply the transformation in `a` to the coordinates and then apply the transformation in `b` to the coordinates.

	It is allowable for `result` to be identical to either `a` or `b`.

	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-multiply"

	^ self ffiCall: #(
		void
		cairo_matrix_multiply (
			AeCairoMatrix * result,
			AeCairoMatrix * a,
			AeCairoMatrix * b ) )
]

{ #category : #'instance creation' }
AeCairoMatrix class >> newFrom: aSimilarObject [

	^ self
		  newX: aSimilarObject x
		  y: aSimilarObject y
		  sx: aSimilarObject sx
		  sy: aSimilarObject sy
		  shx: aSimilarObject shx
		  shy: aSimilarObject shy
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
AeCairoMatrix >> beFlipBothAround: aPoint [
	"Mutate myself to a transformation that flips horizontally and vertically around a center.
	
	For example:
	```
	m := AeCairoMatrix new.
	m beFlipBothAround: 4@4.
	```
	is equivalent to:
	```
	m := AeCairoMatrix newIdentity.
	m translateBy: 4 asPoint.
	m scaleBy: -1 asPoint.
	m translateBy: -4 asPoint.
	```
	"

	self beFlipBothAroundX: aPoint x y: aPoint y
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beFlipBothAroundX: x y: y [
	"Mutate myself to a transformation that flips horizontally and vertically around a center.
	
	For example:
	```
	m := AeCairoMatrix new.
	m beFlipBothAroundX: 4 y: 4.
	```
	is equivalent to:
	```
	m := AeCairoMatrix newIdentity.
	m translateByX: 4 y: 4.
	m scaleByX: -1 y: -1.
	m translateByX: -4 y: -4.
	```
	"

	self
		beX: x * 2
		y: y * 2
		sx: -1.0
		sy: -1.0
		shx: 0.0
		shy: 0.0
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beFlipHorizontallyAround: x [
	"Mutate myself to a transformation that flips horizontally around a center."

	self
		beX: x * 2
		y: 0.0
		sx: -1.0
		sy: 1.0
		shx: 0.0
		shy: 0.0
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beFlipVerticallyAround: y [
	"Mutate myself to a transformation that flips vertically around a center."

	self
		beX: 0.0
		y: y * 2
		sx: 1.0
		sy: -1.0
		shx: 0.0
		shy: 0.0
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beIdentity [
	"Mutate myself to be an identity transformation.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-init-identity"

	self ffiCall: #( void cairo_matrix_init_identity ( self ) )
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beMultiplicationOf: a by: b [

	self class multiply: a by: b into: self
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beRotationByQuadrants: aCount around: aPoint [
	"Mutate myself to be a transformation that rotates around a center by a number of quadrants.
	Rotation by 0 quadrants is equivalent to be the identity matrix.

	For example:
	```
	m := AeCairoMatrix new.
	m beRotationByQuadrants: 3 around: 4@5
	```
	is equivalent to:
	```
	m := AeCairoMatrix newIdentity.
	m translateBy: 4 @ 5.
	m rotateByRadians: (Float pi / 2) * 3.
	m translateBy: -4 @ -5.
	```
	"
	self beRotationByQuadrants: aCount aroundX: aPoint x y: aPoint y
]

{ #category : #'API - initialize' }
AeCairoMatrix >> beRotationByQuadrants: aCount aroundX: x y: y [
	"Mutate myself to be a transformation that rotates around a center by a number of quadrants.
	Rotation by 0 quadrants is equivalent to be the identity matrix.

	For example:
	```
	m := AeCairoMatrix new.
	m beRotationByQuadrants: 3 aroundX: 4 y: 5
	```
	is equivalent to:
	```
	m := AeCairoMatrix newIdentity.
	m translateByX: 4 y: 5.
	m rotateByRadians: (Float pi / 2) * 3.
	m translateByX: -4 y: -5.
	```
	"

	| mod |
	mod := aCount \\ 4.

	mod = 0 ifTrue: [ ^ self beIdentity ].

	mod = 1 ifTrue: [
		^ self
			beX: x + y
			y: y - x
			sx: 0.0
			sy: 0.0
			shx: -1.0
			shy: 1.0 ].

	mod = 2 ifTrue: [
		^ self
			beX: x + x
			y: y + y
			sx: -1.0
			sy: -1.0
			shx: 0.0
			shy: 0.0 ].

	^ self
		beX: x - y
		y: y + x
		sx: 0.0
		sy: 0.0
		shx: 1.0
		shy: -1.0
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
AeCairoMatrix >> closeTo: anotherMatrix precision: num [

	^ (self sx closeTo: anotherMatrix sx precision: num)
		and: [ (self shy closeTo: anotherMatrix shy precision: num)
			and: [ (self shx closeTo: anotherMatrix shx precision: num)
				and: [ (self sy closeTo: anotherMatrix sy precision: num)
					and: [ (self x closeTo: anotherMatrix x precision: num)
						and: [ self y closeTo: anotherMatrix y precision: num ] ] ] ] ]
]

{ #category : #copying }
AeCairoMatrix >> copy [

	^ self class newFrom: self
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
	"Changes matrix to be the inverse of its original value. Not all transformation matrices have inverses; if the matrix collapses points together (it is degenerate), then it has no inverse and this function will fail (check returned status).
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-invert"

	^ self ffiCall: #( AeCairoStatus cairo_matrix_invert ( self ) )
]

{ #category : #factory }
AeCairoMatrix >> inverted [
	"Answer an inverted copy of this matrix, or signal an error if there is no inverse matrix."

	| aStatus anotherMatrix |
	anotherMatrix := self copy.
	aStatus := anotherMatrix invert.
	aStatus ensureIsSuccess.
	^ anotherMatrix
]

{ #category : #testing }
AeCairoMatrix >> isIdentity [

	^ self x = 0.0 and: [ self y = 0.0 and: [ 
		self sx = 1.0 and: [ self sy = 1.0 and: [
			self shx = 0.0 and: [ self shy = 0.0 ] ] ] ] ]
]

{ #category : #'API - transformations' }
AeCairoMatrix >> postMultiply: aMatrix [

	self beMultiplicationOf: self by: aMatrix
]

{ #category : #'API - transformations' }
AeCairoMatrix >> preMultiply: aMatrix [

	self beMultiplicationOf: aMatrix by: self
]

{ #category : #printing }
AeCairoMatrix >> printOn: aStream [

	super printOn: aStream.

	aStream nextPut: $(.

	#(x y sx sy shx shy)
		do: [ :each |
			aStream
				nextPutAll: each;
				nextPut: $:;
				space.
			((self perform: each)
				printOn: aStream
				showingDecimalPlaces: 4) ]
		separatedBy: [ aStream space ].

	aStream nextPut: $)
]

{ #category : #'API - transformations' }
AeCairoMatrix >> rotateByRadians: angle [
	"Applies rotation by radians to the transformation in this matrix. The effect of the new transformation is to first rotate the coordinates by radians, then apply the original transformation to the coordinates.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-rotate"

	self ffiCall: #(
		void
		cairo_matrix_rotate (
			self,
			double angle ) )
]

{ #category : #'API - transformations' }
AeCairoMatrix >> rotateByRadians: angle center: aPoint [
	"Rotate about a center.
	
	See: https://www.cairographics.org/cookbook/transform_about_point/"

	self rotateByRadians: angle centerX: aPoint x y: aPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> rotateByRadians: angle centerX: cx y: cy [
	"Rotate about a center.
	
	See: https://www.cairographics.org/cookbook/transform_about_point/"

	self
		translateByX: cx y: cy;
		rotateByRadians: angle;
		translateByX: cx negated y: cy negated
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleBy: aPoint [
	"Scale about origin (0@0)."

	self scaleByX: aPoint x y: aPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleBy: aPoint center: anotherPoint [
	"Scale about a center.

	See: https://www.cairographics.org/cookbook/transform_about_point/"

	self
		scaleByX: aPoint x
		y: aPoint y
		centerX: anotherPoint x
		y: anotherPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleByX: sx y: sy [
	"Applies scaling by (sx @ sy) to the transformation in this matrix. The effect of the new transformation is to first scale the coordinates by sx and sy, then apply the original transformation to the coordinates.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-scale"

	self ffiCall: #(
		void
		cairo_matrix_scale (
			self,
			double sx,
			double sy ) )
]

{ #category : #'API - transformations' }
AeCairoMatrix >> scaleByX: sx y: sy centerX: cx y: cy [
	"Scale about a center.
	
	See: https://www.cairographics.org/cookbook/transform_about_point/"

	self
		translateByX: cx y: cy;
		scaleByX: sx y: sy;
		translateByX: cx negated y: cy negated
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> scaleFactors [

	^ self sx @ self sy
]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> shearFactors [

	^ self shx @ self shy
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

{ #category : #printing }
AeCairoMatrix >> storeOn: aStream [

	self flag: #newX:y:sx:sy:shx:shy:. "I build a string that sends this selector"

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: (' newX: {1} y: {2} sx: {3} sy: {4} shx: {5} shy: {6})'
			format: ({ self x. self y. self sx. self sy. self shx. self shy }
				collect: [ :each |
					each printShowingDecimalPlaces: 4 ]))
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
	"Applies a translation by aPoint. The effect of the new transformation is to first translate the coordinates by aPoint, then apply the original transformation to the coordinates."

	self translateByX: aPoint x y: aPoint y
]

{ #category : #'API - transformations' }
AeCairoMatrix >> translateByX: tx y: ty [
	"Applies a translation by (tx@ty). The effect of the new transformation is to first translate the coordinates by tx and ty, then apply the original transformation to the coordinates.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-translate"

	self ffiCall: #(
		void
		cairo_matrix_translate (
			self,
			double tx,
			double ty ) )

]

{ #category : #'accessing - structure variables' }
AeCairoMatrix >> translationFactors [

	^ self x @ self y
]

{ #category : #'API - query' }
AeCairoMatrix >> value: aPoint [
	"Answer aPoint transformed by self."

	| x y |
	x := FFIFloat64 newBuffer.
	y := FFIFloat64 newBuffer.
	x doubleAt: 1 put: aPoint x.
	y doubleAt: 1 put: aPoint y.
	self valueOnX: x onY: y.

	^ (x doubleAt: 1) @ (y doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoMatrix >> valueOnX: xPointer onY: yPointer [
	"Transforms the pointed coordinates by this matrix.
	
	See: https://www.cairographics.org/manual/cairo-cairo-matrix-t.html#cairo-matrix-transform-point"

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
