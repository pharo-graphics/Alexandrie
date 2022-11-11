"
I am a Cairo FFI binding for `cairo_t`.

This tutorial is a good source to understand how to use my instances: https://www.cairographics.org/tutorial/

See: https://www.cairographics.org/manual/cairo-cairo-t.html
"
Class {
	#name : #AeCairoContext,
	#superclass : #FFIExternalReference,
	#traits : 'AeTCairoLibrary + AeTCairoDestroy',
	#classTraits : 'AeTCairoLibrary classTrait + AeTCairoDestroy classTrait',
	#instVars : [
		'surface'
	],
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #converting }
AeCairoContext class >> asExternalTypeOn: generator [

	^ FFIExternalObjectType objectClass: self
]

{ #category : #finalization }
AeCairoContext class >> destroyHandle: aHandle [
	
	self ffiCall: #( void cairo_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoContext class >> newFor: aSurface [

	^ (self unownedNewFor: aSurface)
		initializeWith: aSurface;
		autoRelease;
		yourself
]

{ #category : #'private - ffi' }
AeCairoContext class >> unownedNewFor: aSurface [

	^ self ffiCall: #( AeCairoContext cairo_create ( AeCairoImageSurface aSurface ) )
]

{ #category : #'API - path' }
AeCairoContext >> annulusSectorCenter: aPoint from: radiansStart to: radiansStop innerRadius: innerRadius outerRadius: outerRadius [
	"Precondition: radiansStart < radiansStop"

	self
		arcCenterX: aPoint x
			centerY: aPoint y
			radius: outerRadius
			startAngle: radiansStart
			endAngle: radiansStop;
		arcNegativeCenterX: aPoint x
			centerY: aPoint y
			radius: innerRadius
			startAngle: radiansStop
			endAngle: radiansStart;
		closePath

]

{ #category : #'API - path settings' }
AeCairoContext >> antialias: aCairoAntialias [

	self ffiCall: #(
		void
		cairo_set_antialias (
			self,
			AeCairoAntialias aCairoAntialias ) )
]

{ #category : #'API - path' }
AeCairoContext >> appendPath: aCairoPath [

	self ffiCall: #(
		void
		cairo_append_path (
			self,
			AeCairoPath aCairoPath ) )
]

{ #category : #'API - path' }
AeCairoContext >> arcCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 

	self ffiCall: #(
		void
		cairo_arc (
			self,
			double centerX,
			double centerY,
			double aRadius,
			double aStartAngle,
			double anEndAngle ) )
]

{ #category : #'API - path' }
AeCairoContext >> arcNegativeCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 
	self ffiCall: #(
		void
		cairo_arc_negative (
			self,
			double centerX,
			double centerY,
			double aRadius,
			double aStartAngle,
			double anEndAngle ) )
]

{ #category : #'API - path' }
AeCairoContext >> circleCenterX: x y: y radius: radius [

	self
		arcCenterX: x
		centerY: y
		radius: radius
		startAngle: 0.0
		endAngle: Float twoPi
]

{ #category : #'API - path' }
AeCairoContext >> circleRadius: radius [

	self
		arcCenterX: radius
		centerY: radius
		radius: radius
		startAngle: 0.0
		endAngle: Float twoPi
]

{ #category : #'API - path' }
AeCairoContext >> circleSectorCenter: aPoint from: radiansStart to: radiansStop radius: radius [
	"Precondition: radiansStart < radiansStop"

	self
		arcCenterX: aPoint x
			centerY: aPoint y
			radius: radius
			startAngle: radiansStart
			endAngle: radiansStop;
		lineToX: aPoint x
			y: aPoint y;
		closePath

]

{ #category : #'API - painting' }
AeCairoContext >> clearR: r g: g b: b a: a [
	"See https://www.cairographics.org/FAQ/#clear_a_surface"

	self
		saveState;
		setOperatorSource;
		sourceColorR: r
			g: g
			b: b
			a: a;
		paint;
		restoreState

]

{ #category : #'API - painting' }
AeCairoContext >> clearTransparent [
	"See https://www.cairographics.org/FAQ/#clear_a_surface"

	self
		saveState;
		setOperatorClear;
		paint;
		restoreState

]

{ #category : #'API - clipping' }
AeCairoContext >> clip [

	self ffiCall: #( void cairo_clip ( self ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> clipPreserve [

	self ffiCall: #( void cairo_clip_preserve ( self ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> clippingAreaAsForm [ 
	
	| clippingForm |
	"Temporarily reset CTM matrix"
	self
		saveState;
		setIdentityMatrix.

	clippingForm := Form extent: surface extent depth: 1.
	0 to: clippingForm width - 1 do: [ :x |
		0 to: clippingForm height - 1 do: [ :y |
			| isInClip |
			isInClip := self isInClipX: x y: y.
			clippingForm
				colorAt: x@y
				put: (isInClip
					ifTrue: [ Color black ]
					ifFalse: [ Color white ]).
			] ].

	self restoreState.
		
	^ clippingForm
]

{ #category : #'API - path' }
AeCairoContext >> closePath [
	
	self ffiCall: #( void cairo_close_path ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> cubicCurveFrom: startPoint controlPoint1: cp1 controlPoint2: cp2 to: endPoint [

	self
		moveToX: startPoint x
			y: startPoint y;
		curveViaX: cp1 x
			y: cp1 y
			viaX: cp2 x
			y: cp2 y
			toX: endPoint x
			y: endPoint y
]

{ #category : #'API - path' }
AeCairoContext >> currentPath [
	"Return a copy of the current path."

	^ self unownedCurrentPath
		  autoRelease;
		  yourself
]

{ #category : #'API - path' }
AeCairoContext >> curveViaX: x1 y: y1 viaX: x2 y: y2 toX: x3 y: y3 [
	"See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-curve-to"	

	self ffiCall: #(
		void
		cairo_curve_to (
			self,
			double x1,
			double y1,
			double x2,
			double y2,
			double x3,
			double y3 ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> dash: anArrayOfDoubles count: aNumberOfDashes offset: anOffset [

	self ffiCall: #(
		void
		cairo_set_dash (
			self,
			double* anArrayOfDoubles,
			int aNumberOfDashes,
			double anOffset ) )
]

{ #category : #'API - path' }
AeCairoContext >> ellipseWidth: width height: height [
	"See: https://www.cairographics.org/cookbook/ellipses/"

	self saveState.

	self
		scaleByX: width
			y: height;
		arcCenterX: 0.5
			centerY: 0.5
			radius: 0.5
			startAngle: 0.0
			endAngle: Float twoPi.

	self restoreState.

]

{ #category : #'API - painting' }
AeCairoContext >> fill [

	self ffiCall: #( void cairo_fill ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> fillPreserve [

	self ffiCall: #( void cairo_fill_preserve ( self ) )
]

{ #category : #'API - text' }
AeCairoContext >> getFontExtentsOn: aFontExtents [
	"Gets the font extents for the currently selected font.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-font-extents"

	self ffiCall: #(
		void
		cairo_font_extents (
			self,
			AeCairoFontExtents* aFontExtents ) )
]

{ #category : #'API - text' }
AeCairoContext >> getGlyphExtentsOf: theGlyphs size: aGlyphsNum on: aTextMetrics [
	"Gets the extents for an array of glyphs. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs, (as they would be drawn by `cairo_show_glyphs()`). Additionally, the `x_advance` and `y_advance` values indicate the amount by which the current point would be advanced by `cairo_show_glyphs()`.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-glyph-extents"

	self ffiCall: #(
		void
		cairo_glyph_extents (
			self,
			AeCairoGlyphArray theGlyphs,
			int aGlyphsNum,
			AeCairoTextExtents* aTextMetrics ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> getMatrixOn: aCairoMatrix [
	"Stores the current transformation matrix (CTM) into to argument.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-get-matrix"

	self ffiCall: #(
		void
		cairo_get_matrix (
			self,
			AeCairoMatrix *aCairoMatrix ) )
]

{ #category : #initialization }
AeCairoContext >> initializeWith: anAeCairoSurface [
	"Note: don't send super initialize as it nullifies the handle."

	surface := anAeCairoSurface
]

{ #category : #'API - clipping' }
AeCairoContext >> isInClipX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-clip"

	^ self ffiCall: #(
		Boolean
		cairo_in_clip (
			self,
			double x,
			double y ) )
]

{ #category : #'API - hit testing' }
AeCairoContext >> isInFillX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-fill"

	^ self ffiCall: #(
		Boolean
		cairo_in_fill (
			self,
			double x,
			double y ) )
]

{ #category : #'API - hit testing' }
AeCairoContext >> isInStrokeX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-stroke"

	^ self ffiCall: #(
		Boolean cairo_in_stroke (
			self,
			double x,
			double y ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> lineCap: aCairoCapStyle [

	self ffiCall: #(
		void
		cairo_set_line_cap (
			self,
			AeCairoCapStyle aCairoCapStyle ) )
]

{ #category : #'API - path' }
AeCairoContext >> lineFrom: aPoint to: anotherPoint [

	self
		moveTo: aPoint;
		lineTo: anotherPoint
]

{ #category : #'API - path settings' }
AeCairoContext >> lineJoin: aCairoJoinStyle [

	self ffiCall: #( void cairo_set_line_join (
		self,
      AeCairoJoinStyle aCairoJoinStyle ) )
]

{ #category : #'API - path' }
AeCairoContext >> lineTo: aPoint [

	^ self lineToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - path' }
AeCairoContext >> lineToX: aX y: aY [

	self ffiCall: #(
		void
		cairo_line_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> lineWidth: aNumber [

	self ffiCall: #(
		void
		cairo_set_line_width (
			self,
			double aNumber ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> mask: pattern [
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-mask"

	^ self ffiCall: #(
		void
		cairo_mask (
			self,
			AeCairoPattern pattern ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> maskSurface: aSurface x: x y: y [
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-mask-surface"

	^ self ffiCall: #(
		void
		cairo_mask_surface (
			self,
			AeCairoSurface aSurface,
			double x
			double y ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> matrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix externalNew.
	self getMatrixOn: aCairoMatrix.
	^ aCairoMatrix
		  autoRelease;
		  yourself
]

{ #category : #'API - matrix' }
AeCairoContext >> matrix: aCairoMatrix [

	self ffiCall: #(
		void
		cairo_set_matrix (
			self,
			AeCairoMatrix *aCairoMatrix ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> miterLimit: aNumber [

	self ffiCall: #( void cairo_set_miter_limit (
		self,
      double aNumber ) )
]

{ #category : #'API - path' }
AeCairoContext >> moveTo: aPoint [

	self moveToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - path' }
AeCairoContext >> moveToX: aX y: aY [

	self ffiCall: #(
		void
		cairo_move_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> operator: aCairoOperator [

	self ffiCall: #(
		void
		cairo_set_operator (
			self,
			AeCairoCompositionOp aCairoOperator ) )
]

{ #category : #'API - painting' }
AeCairoContext >> paint [

	self ffiCall: #( void cairo_paint ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> paintGroupWith: aBlock [
	"Note: Cairo already saves and restores its state with push_group and pop_group"

	self pushGroup.

	aBlock value.

	self
		popGroupToSource;
		paint
]

{ #category : #'API - painting' }
AeCairoContext >> paintGroupWith: aBlockClosure alpha: aNumber [
	"Note: Cairo already saves and restores its state with push_group and pop_group"

	self pushGroup.

	aBlockClosure value.

	self
		popGroupToSource;
		paintWithAlpha: aNumber
]

{ #category : #'API - painting' }
AeCairoContext >> paintWithAlpha: aNumber [

	self ffiCall: #(
		void
		cairo_paint_with_alpha (
			self,
			double aNumber ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> popGroup [

	^ self unownedPopGroup
		  autoRelease;
		  yourself
]

{ #category : #'API - compositing' }
AeCairoContext >> popGroupToSource [

	self ffiCall: #( void cairo_pop_group_to_source ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> pushGroup [

	self ffiCall: #( void cairo_push_group ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> quadraticCurveFrom: startPoint controlPoint: qp1 to: endPoint [
	"Quadratic bezier curve.

	Fundaments:

	Any quadratic spline can be expressed as a cubic (where the cubic term is zero). The end points of the cubic will be the same as the quadratic's.

		CP0 = QP0
		CP3 = QP2

	The two control points for the cubic are:

		CP1 = QP0 + 2/3 *(QP1-QP0)
		CP2 = QP2 + 2/3 *(QP1-QP2)
		
	Based on AthensCairoPathBuilder>>#curveVia:to:"

	| cp1 cp2 |
	cp1 := (qp1 - startPoint) * 0.6666666666666666 + startPoint.
	cp2 := (qp1 - endPoint)   * 0.6666666666666666 + endPoint.

	self
		moveToX: startPoint x
			y: startPoint y;
		curveViaX: cp1 x
			y: cp1 y
			viaX: cp2 x
			y: cp2 y
			toX: endPoint x
			y: endPoint y
]

{ #category : #'API - path' }
AeCairoContext >> rectangle: aRectangle [

	self
		rectangleX: aRectangle left
		y: aRectangle top
		width: aRectangle width
		height: aRectangle height
]

{ #category : #'API - path' }
AeCairoContext >> rectangleTo: extentPoint [

	self
		rectangleX: 0
		y: 0
		width: extentPoint x
		height:extentPoint y
]

{ #category : #'API - path' }
AeCairoContext >> rectangleX: aX y: aY width: aWidth height: aHeight [
	"Note: aWidth and aHeight can be negative"

	self ffiCall: #(
		void
		cairo_rectangle (
			self,
			double aX,
			double aY,
			double aWidth,
			double aHeight ) )
]

{ #category : #'API - path' }
AeCairoContext >> relativeLineTo: aPoint [

	^ self relativeLineToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - path' }
AeCairoContext >> relativeLineToX: aX y: aY [

	self ffiCall: #(
		void
		cairo_rel_line_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - path' }
AeCairoContext >> relativeMoveTo: aPoint [

	self relativeMoveToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - path' }
AeCairoContext >> relativeMoveToX: aX y: aY [

	self ffiCall: #(
		void
		cairo_rel_move_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> resetClip [

	self ffiCall: #( void cairo_reset_clip #( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> resetPath [
	"See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-new-path"

	self ffiCall: #( void cairo_new_path ( self ) )
]

{ #category : #'API - states' }
AeCairoContext >> restoreState [
	"Restores me to the state saved by a preceding call to `cairo_save()` and removes that state from the stack of saved states.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-restore"

	self ffiCall: #( void cairo_restore ( self ) )
]

{ #category : #'API - states' }
AeCairoContext >> restoreStateAfter: aBlockClosure [ 
	
	self saveState.
	aBlockClosure value.
	self restoreState.
]

{ #category : #'API - matrix' }
AeCairoContext >> rotateByRadians: angle [
	"Modifies the current transformation matrix (CTM) by rotating the user-space axes by angle radians. 
	The rotation of the axes takes places after any existing transformation of user space. 
	The rotation direction for positive angles is from the positive X axis toward the positive Y axis.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-rotate"

	self ffiCall: #(
		void
		cairo_rotate (
			self,
			double angle ) )
]

{ #category : #'API - path' }
AeCairoContext >> roundedRectangle: aRectangle radii: anArrayOfCornerRadii [
	"anArrayOfCornerRadii must contain four numbers representing corner radii:
	(topLeft, topRight, bottomRight, bottomLeft)"

	"See: https://www.cairographics.org/cookbook/roundedrectangles/"

	| bound tlR blR brR trR t b l r threeHalvesPi |

	bound := (aRectangle width min: aRectangle height) / 2.0.
	tlR := anArrayOfCornerRadii first min: bound.
	trR := anArrayOfCornerRadii second min: bound.
	brR := anArrayOfCornerRadii third min: bound.
	blR := anArrayOfCornerRadii fourth min: bound.
	
	t := aRectangle top.
	b := aRectangle bottom.
	l := aRectangle left.
	r := aRectangle right.

	threeHalvesPi := 3.0 * Float halfPi.

	self
		arcCenterX: t + tlR
		centerY: l + tlR
		radius: tlR
		startAngle: Float pi
		endAngle: threeHalvesPi.

	self
		arcCenterX: b - trR
		centerY: l + trR
		radius: trR
		startAngle: threeHalvesPi
		endAngle: Float twoPi.

	self
		arcCenterX: b - brR
		centerY: r - brR
		radius: brR
		startAngle: 0.0
		endAngle: Float halfPi.

	self
		arcCenterX: t + blR
		centerY: r - blR
		radius: blR
		startAngle: Float halfPi
		endAngle: Float pi.

	self closePath.

]

{ #category : #'API - path' }
AeCairoContext >> roundedRectangleTo: extentPoint radii: anArrayOfCornerRadii [
	"anArrayOfCornerRadii must contain four numbers representing corner radii:
	(topLeft, topRight, bottomRight, bottomLeft)"

	"See: https://www.cairographics.org/cookbook/roundedrectangles/"

	| bound tlR blR brR trR b r threeHalvesPi |

	bound := (extentPoint x min: extentPoint y) / 2.0.
	tlR := anArrayOfCornerRadii first min: bound.
	trR := anArrayOfCornerRadii second min: bound.
	brR := anArrayOfCornerRadii third min: bound.
	blR := anArrayOfCornerRadii fourth min: bound.
	
	b := extentPoint y.
	r := extentPoint x.

	threeHalvesPi := 3.0 * Float halfPi.

	self
		arcCenterX: tlR
		centerY: tlR
		radius: tlR
		startAngle: Float pi
		endAngle: threeHalvesPi.

	self
		arcCenterX: r - trR
		centerY: trR
		radius: trR
		startAngle: threeHalvesPi
		endAngle: Float twoPi.

	self
		arcCenterX: r - brR
		centerY: b - brR
		radius: brR
		startAngle: 0.0
		endAngle: Float halfPi.

	self
		arcCenterX: blR
		centerY: b - blR
		radius: blR
		startAngle: Float halfPi
		endAngle: Float pi.

	self closePath.

]

{ #category : #'API - states' }
AeCairoContext >> saveState [
	"Makes a copy of the current state of self and saves it on an internal stack of saved states for self . When `cairo_restore()` is called, self will be restored to the saved state. Multiple calls to `cairo_save()` and `cairo_restore()` can be nested; each call to `cairo_restore()` restores the state from the matching paired `cairo_save()`.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-save"

	self ffiCall: #( void cairo_save ( self ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> scaleBy: aPoint [

	self scaleByX: aPoint x y: aPoint y
]

{ #category : #'API - matrix' }
AeCairoContext >> scaleByX: sx y: sy [
	"Modifies the current transformation matrix (CTM) by scaling the X and Y user-space axes by sx and sy respectively. 
	The scaling of the axes takes place after any existing transformation of user space.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-scale"

	self ffiCall: #(
		void cairo_scale (
			self,
			double sx,
			double sy ) )
]

{ #category : #'API - text' }
AeCairoContext >> scaledFont: aScaledFont [
	"Replaces the current font face, font matrix, and font options in self with those of the received `cairo_scaled_font_t`.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-set-scaled-font"

	self ffiCall: #(
		void
		cairo_set_scaled_font (
			self,
			AeCairoScaledFont aScaledFont ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> setIdentityMatrix [

	self ffiCall: #( void cairo_identity_matrix ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorClear [
	"Set 'CAIRO_OPERATOR_CLEAR' drawing mode.
	
	Drawing under this mode will clear the surface under the shape boundaries.
	
	See https://www.cairographics.org/operators/"
	
	^ self operator: AeCairoCompositionOp CAIRO_OPERATOR_CLEAR
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorSource [
	"Set 'CAIRO_OPERATOR_SOURCE' drawing mode.

	See https://www.cairographics.org/operators/"
	
	^ self operator: AeCairoCompositionOp CAIRO_OPERATOR_SOURCE
]

{ #category : #'API - text' }
AeCairoContext >> showGlyphs: aGlyphsArray size: aNumberOfGlyphs [

	self ffiCall: #(
		void
		cairo_show_glyphs (
			self,
			void * aGlyphsArray,
			int aNumberOfGlyphs ) )
]

{ #category : #'API - path' }
AeCairoContext >> source [
	"Answer the current source pattern. This object is owned by cairo. To keep a reference to it, you must call `cairo_pattern_reference()`.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-source"

	^ self ffiCall: #( AeCairoPattern cairo_get_source ( self ) )
]

{ #category : #'API - source' }
AeCairoContext >> source: aPattern [

	self ffiCall: #(
		void
		cairo_set_source (
			self,
			AeCairoPattern aPattern ) )
]

{ #category : #'API - source' }
AeCairoContext >> sourceColorR: aRed g: aGreen b: aBlue [
	
	self ffiCall: #(
		void
		cairo_set_source_rgb (
			self,
			double aRed,
			double aGreen,
			double aBlue ) )
]

{ #category : #'API - source' }
AeCairoContext >> sourceColorR: aRed g: aGreen b: aBlue a: anAlpha [
	
	self ffiCall: #(
		void
		cairo_set_source_rgba (
			self,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha ) )
]

{ #category : #'API - source' }
AeCairoContext >> sourceColorRGB: aColor [

	self sourceColorR: aColor red g: aColor green b: aColor blue
]

{ #category : #'API - source' }
AeCairoContext >> sourceColorRGBA: aColor [

	self
		sourceColorR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #'API - source' }
AeCairoContext >> sourceSurface: aCairoSurface x: aX y: aY [

	self ffiCall: #(
		void
		cairo_set_source_surface (
			self,
			AeCairoSurface aCairoSurface,
			double aX,
			double aY ) )
]

{ #category : #'API - states' }
AeCairoContext >> status [
	"Answer a `AeCairoStatus` that indicates the error status of this Cairo context.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-status"

	^ self ffiCall: #( AeCairoStatus cairo_status ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> stroke [

	self ffiCall: #( void cairo_stroke ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> strokePreserve [

	self ffiCall: #( void cairo_stroke_preserve ( self ))
]

{ #category : #accessing }
AeCairoContext >> surface [

	^ surface
]

{ #category : #'API - path settings' }
AeCairoContext >> tolerance: aNumber [ 

	self ffiCall: #( void cairo_set_tolerance (
		self,
      double aNumber ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> transformWith: aCairoMatrix [ 
	"Modifies the current transformation matrix (CTM) by applying aCairoMatrix as an additional transformation.
	The new transformation of user space takes place after any existing transformation.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-transform"

	self ffiCall: #(
		void
		cairo_transform (
			self,
			AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'API - matrix' }
AeCairoContext >> translateBy: aPoint [

	self translateByX: aPoint x y: aPoint y
]

{ #category : #'API - matrix' }
AeCairoContext >> translateByX: tx y: ty [
	"Modifies the current transformation matrix (CTM) by translating the user-space origin by (tx,ty). 
	This offset is interpreted as a user-space coordinate according to the CTM in place before the new 
	call to `cairo_translate()`. In other words, the translation of the user-space origin takes place
	after any existing transformation.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-translate"

	self ffiCall: #(
		void
		cairo_translate (
			self,
			double tx,
			double ty ) )
]

{ #category : #'API - path' }
AeCairoContext >> unownedCurrentPath [
	"Return a copy of the current path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-copy-path"

	^ self ffiCall: #( AeCairoPath cairo_copy_path ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> unownedPopGroup [

	^ self ffiCall: #( AeCairoSurfacePattern cairo_pop_group ( self ) )
]
