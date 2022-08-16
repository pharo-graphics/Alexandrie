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
	#category : #'Alexandrie-FFI-Core'
}

{ #category : #converting }
AeCairoContext class >> asExternalTypeOn: generator [
	^ FFIExternalObjectType objectClass: self
]

{ #category : #'instance creation' }
AeCairoContext class >> newFor: aSurface [

	^ (self primCreate: aSurface)
		initializeWith: aSurface;
		autoRelease;
		yourself
]

{ #category : #'private - ffi' }
AeCairoContext class >> primCreate: aSurface [

	^ self ffiCall: #(AeCairoContext cairo_create (AeCairoImageSurface aSurface) )
]

{ #category : #finalization }
AeCairoContext class >> primDestroy: aHandle [
	
	self ffiCall: #( void cairo_destroy ( void * aHandle ) )
]

{ #category : #'API - path' }
AeCairoContext >> circleCenterX: x y: y radius: radius [

	self
		primArcCenterX: x + radius
		centerY: y + radius
		radius: radius
		startAngle: 0.0
		endAngle: Float twoPi
]

{ #category : #'API - path' }
AeCairoContext >> circleRadius: radius [

	self
		primArcCenterX: radius
		centerY: radius
		radius: radius
		startAngle: 0.0
		endAngle: Float twoPi
]

{ #category : #'API - painting' }
AeCairoContext >> clearR: r g: g b: b a: a [
	"See https://www.cairographics.org/FAQ/#clear_a_surface"

	self
		primSave;
		setOperatorSource;
		primSetSourceR: r
			g: g
			b: b
			a: a;
		primPaint;
		primRestore

]

{ #category : #'API - painting' }
AeCairoContext >> clearTransparent [
	"See https://www.cairographics.org/FAQ/#clear_a_surface"

	self
		primSave;
		setOperatorClear;
		primPaint;
		primRestore

]

{ #category : #'API - path' }
AeCairoContext >> copyPath [

	^ self primCopyPath
		  autoRelease;
		  yourself
]

{ #category : #'API - path' }
AeCairoContext >> ellipseWidth: width height: height [
	"See: https://www.cairographics.org/cookbook/ellipses/"

	self primSave.

	self
		primScaleX: width
			y: height;
		primArcCenterX: 0.5
			centerY: 0.5
			radius: 0.5
			startAngle: 0.0
			endAngle: Float twoPi.

	self primRestore.

]

{ #category : #initialization }
AeCairoContext >> initializeWith: anAeCairoSurface [
	"Note: don't send super initialize as it nullifies the handle."

	surface := anAeCairoSurface
]

{ #category : #'API - path' }
AeCairoContext >> lineTo: aPoint [

	^ self primLineToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - matrix' }
AeCairoContext >> matrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix externalNew.
	self primGetMatrix: aCairoMatrix.
	^ aCairoMatrix
		  autoRelease;
		  yourself
]

{ #category : #'API - matrix' }
AeCairoContext >> matrix: aeMatrix [

	self primGetMatrix: aeMatrix

]

{ #category : #'API - path' }
AeCairoContext >> moveTo: aPoint [

	self primMoveToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #'API - compositing' }
AeCairoContext >> popGroup [

	^ self primPopGroup
		  autoRelease;
		  yourself
]

{ #category : #'API - path' }
AeCairoContext >> primAppendPath: aCairoPath [

	self ffiCall: #( void cairo_append_path (
			self,
			AeCairoPath aCairoPath ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> primApplyTransform: aCairoMatrix [ 

	self ffiCall: #( void cairo_transform (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'API - path' }
AeCairoContext >> primArcCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 
	self ffiCall: #(void cairo_arc (
			self,
			double centerX,
			double centerY,
			double aRadius,
			double aStartAngle,
			double anEndAngle) )
]

{ #category : #'API - path' }
AeCairoContext >> primArcNegativeCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 
	self ffiCall: #(void cairo_arc_negative (
			self,
			double centerX,
			double centerY,
			double aRadius,
			double aStartAngle,
			double anEndAngle) )
]

{ #category : #'API - clipping' }
AeCairoContext >> primClip [

	self ffiCall: #(void cairo_clip ( self ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> primClipPreserve [

	self ffiCall: #(void cairo_clip_preserve ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> primClosePath [
	
	self ffiCall: #(void cairo_close_path ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> primCopyPath [

	^ self ffiCall: #(AeCairoPath cairo_copy_path ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> primCurveViaX: x1 y: y1 viaX: x2 y: y2 toX: x3 y: y3 [
	
	self ffiCall: #(
		void cairo_curve_to (
			self,
			double x1,
			double y1,
			double x2,
			double y2,
			double x3,
			double y3 ) )
]

{ #category : #'API - painting' }
AeCairoContext >> primFill [

	self ffiCall: #( void cairo_fill ( self ))
]

{ #category : #'API - painting' }
AeCairoContext >> primFillPreserve [

	self ffiCall: #( void cairo_fill_preserve ( self ))
]

{ #category : #'API - text' }
AeCairoContext >> primFontExtents: aFontExtents [

	self ffiCall: #( void cairo_font_extents (
		self,
		AeCairoFontExtents* aFontExtents ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> primGetMatrix: aCairoMatrix [

	self ffiCall: #( void cairo_get_matrix (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'API - text' }
AeCairoContext >> primGlyphExtents: theGlyphs num: aGlyphsNum metrics: aTextMetrics [

	self ffiCall: #( void cairo_glyph_extents (
		self,
		AeCairoGlyphArray theGlyphs,
		int aGlyphsNum,
		AeCairoTextExtents* aTextMetrics ) )
]

{ #category : #'API - hit testing' }
AeCairoContext >> primInFillX: x y: y [ 

	^ self ffiCall: #( Boolean cairo_in_fill (
		self,
		double x,
		double y ) )
]

{ #category : #'API - path' }
AeCairoContext >> primLineToX: aX y: aY [

	self ffiCall: #(void cairo_line_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> primLoadIdentity [

	self ffiCall: #( void cairo_identity_matrix ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> primMoveToX: aX y: aY [

	self ffiCall: #(void cairo_move_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - painting' }
AeCairoContext >> primPaint [

	self ffiCall: #( void cairo_paint ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> primPaintAlpha: aNumber [

	self ffiCall: #(void cairo_paint_with_alpha (
			self,
			double aNumber ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> primPopGroup [

	^ self ffiCall: #( AeCairoSurfacePattern cairo_pop_group ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> primPopGroupToSource [

	self ffiCall: #( void cairo_pop_group_to_source ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> primPushGroup [

	self ffiCall: #( void cairo_push_group ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> primRectangleX: aX y: aY width: aWidth height: aHeight [

	self ffiCall: #(void cairo_rectangle (
			self,
			double aX,
			double aY,
			double aWidth,
			double aHeight ) )
]

{ #category : #'API - path' }
AeCairoContext >> primRelativeLineToX: aX y: aY [

	self ffiCall: #(void cairo_rel_line_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - path' }
AeCairoContext >> primRelativeMoveToX: aX y: aY [

	self ffiCall: #(void cairo_rel_move_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'API - states' }
AeCairoContext >> primRestore [

	self ffiCall: #( void cairo_restore ( self ) )
]

{ #category : #'API - states' }
AeCairoContext >> primSave [

	self ffiCall: #( void cairo_save ( self ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> primScaleX: aX y: aY [

	self ffiCall: #( void cairo_scale (
			self,
			double aX,
			double aY) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetAntialias: aCairoAntialias [

	self ffiCall: #( void cairo_set_antialias (
		self,
      AeCairoAntialias aCairoAntialias ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetDash: anArrayOfDoubles count: aNumberOfDashes offset: anOffset [

	self ffiCall: #( void cairo_set_dash (
		self,
      double* anArrayOfDoubles,
		int aNumberOfDashes,
		double anOffset ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetLineCap: aCairoCapStyle [

	self ffiCall: #( void cairo_set_line_cap (
		self,
      AeCairoCapStyle aCairoCapStyle ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetLineJoin: aCairoJoinStyle [

	self ffiCall: #( void cairo_set_line_join (
		self,
      AeCairoJoinStyle aCairoJoinStyle ) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetLineWidth: aNumber [

	self ffiCall: #( void cairo_set_line_width (
		self,
      double aNumber ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> primSetMatrix: aCairoMatrix [

	self ffiCall: #( void cairo_set_matrix (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetMiterLimit: aNumber [

	self ffiCall: #( void cairo_set_miter_limit (
		self,
      double aNumber ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> primSetOperator: aCairoOperator [

	self ffiCall: #( void cairo_set_operator (
		self,
      AeCairoCompositionOp aCairoOperator ) )
]

{ #category : #'API - text' }
AeCairoContext >> primSetScaledFont: aScaledFont [

	self ffiCall: #( void cairo_set_scaled_font (
		self,
		AeCairoScaledFont aScaledFont ) )
]

{ #category : #'API - source' }
AeCairoContext >> primSetSource: aPattern [

	self ffiCall: #( void cairo_set_source (
		self,
		AeCairoPattern aPattern ))
]

{ #category : #'API - source' }
AeCairoContext >> primSetSourceR: aRed g: aGreen b: aBlue [
	
	self ffiCall: #( void cairo_set_source_rgb (
			self,
			double aRed,
			double aGreen,
			double aBlue) )
]

{ #category : #'API - source' }
AeCairoContext >> primSetSourceR: aRed g: aGreen b: aBlue a: anAlpha [
	
	self ffiCall: #( void cairo_set_source_rgba (
			self,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha) )
]

{ #category : #'API - source' }
AeCairoContext >> primSetSourceSurface: aCairoSurface x: aX y: aY [

	self ffiCall: #( void cairo_set_source_surface (
			self,
			AeCairoSurface aCairoSurface,
			double aX,
			double aY) )
]

{ #category : #'API - path settings' }
AeCairoContext >> primSetTolerance: aNumber [ 

	self ffiCall: #( void cairo_set_tolerance (
		self,
      double aNumber ) )
]

{ #category : #'API - text' }
AeCairoContext >> primShowGlyphs: aGlyphsArray num: aNumberOfGlyphs [

	self ffiCall: #( void cairo_show_glyphs (
		self,
		void * aGlyphsArray,
		int aNumberOfGlyphs ) )
]

{ #category : #'API - painting' }
AeCairoContext >> primStroke [

	self ffiCall: #( void cairo_stroke ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> primStrokePreserve [

	self ffiCall: #( void cairo_stroke_preserve ( self ))
]

{ #category : #'API - matrix' }
AeCairoContext >> primTranslateX: aX y: aY [

	self ffiCall: #( void cairo_translate (
			self,
			double aX,
			double aY) )
]

{ #category : #'API - path' }
AeCairoContext >> rectangle: aRectangle [

	self
		primRectangleX: aRectangle left
		y: aRectangle top
		width: aRectangle width
		height: aRectangle height
]

{ #category : #'API - path' }
AeCairoContext >> rectangleTo: extentPoint [

	self
		primRectangleX: 0
		y: 0
		width: extentPoint x
		height:extentPoint y
]

{ #category : #'API - clipping' }
AeCairoContext >> resetClip [

	self ffiCall: #( void cairo_reset_clip #( self ) )
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
		primArcCenterX: t + tlR
		centerY: l + tlR
		radius: tlR
		startAngle: Float pi
		endAngle: threeHalvesPi.

	self
		primArcCenterX: b - trR
		centerY: l + trR
		radius: trR
		startAngle: threeHalvesPi
		endAngle: Float twoPi.

	self
		primArcCenterX: b - brR
		centerY: r - brR
		radius: brR
		startAngle: 0.0
		endAngle: Float halfPi.

	self
		primArcCenterX: t + blR
		centerY: r - blR
		radius: blR
		startAngle: Float halfPi
		endAngle: Float pi.

	self primClosePath.

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
		primArcCenterX: tlR
		centerY: tlR
		radius: tlR
		startAngle: Float pi
		endAngle: threeHalvesPi.

	self
		primArcCenterX: b - trR
		centerY: trR
		radius: trR
		startAngle: threeHalvesPi
		endAngle: Float twoPi.

	self
		primArcCenterX: b - brR
		centerY: r - brR
		radius: brR
		startAngle: 0.0
		endAngle: Float halfPi.

	self
		primArcCenterX: blR
		centerY: r - blR
		radius: blR
		startAngle: Float halfPi
		endAngle: Float pi.

	self primClosePath.

]

{ #category : #'API - matrix' }
AeCairoContext >> scale: aPoint [

	self primScaleX: aPoint x y: aPoint y
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorClear [
	"Set 'CAIRO_OPERATOR_CLEAR' drawing mode.
	
	Drawing under this mode will clear the surface under the shape boundaries.
	
	See https://www.cairographics.org/operators/"
	
	^ self primSetOperator: AeCairoCompositionOp CAIRO_OPERATOR_CLEAR
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorSource [
	"Set 'CAIRO_OPERATOR_SOURCE' drawing mode.

	See https://www.cairographics.org/operators/"
	
	^ self primSetOperator: AeCairoCompositionOp CAIRO_OPERATOR_SOURCE
]

{ #category : #'API - source' }
AeCairoContext >> setSourceRGBAColor: aColor [

	self
		primSetSourceR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #'API - source' }
AeCairoContext >> setSourceRGBColor: aColor [

	self primSetSourceR: aColor red g: aColor green b: aColor blue
]

{ #category : #accessing }
AeCairoContext >> surface [

	^ surface
]

{ #category : #'API - matrix' }
AeCairoContext >> translate: aPoint [

	self primTranslateX: aPoint x y: aPoint y
]
