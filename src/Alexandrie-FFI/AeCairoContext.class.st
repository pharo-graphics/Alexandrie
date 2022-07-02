"
I am a Cairo FFI binding for `cairo_t`.

See https://www.cairographics.org/manual/cairo-cairo-t.html
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
AeCairoContext class >> create: aSurface [

	^ (self primCreate: aSurface)
		surface: aSurface;
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

{ #category : #API }
AeCairoContext >> copyPath [

	^ self primCopyPath
		  autoRelease;
		  yourself
]

{ #category : #API }
AeCairoContext >> currentMatrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix externalNew.
	self primGetTransform: aCairoMatrix.
	^ aCairoMatrix	autoRelease.
]

{ #category : #API }
AeCairoContext >> lineTo: aPoint [

	^ self primLineToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #API }
AeCairoContext >> moveTo: aPoint [

	self primMoveToX: aPoint x asFloat y: aPoint y asFloat
]

{ #category : #API }
AeCairoContext >> popGroup [

	^ self primPopGroup initialize; yourself "(autoRelease)"
]

{ #category : #'private - ffi' }
AeCairoContext >> primAppendPath: aCairoPath [

	self ffiCall: #( void cairo_append_path (
			self,
			AeCairoPath aCairoPath ) )
]

{ #category : #'private - transformation' }
AeCairoContext >> primApplyTransform: aCairoMatrix [ 

	self ffiCall: #( void cairo_transform (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primArcCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 

	self ffiCall: #(void cairo_arc (
			self,
			double centerX,
			double centerY,
			double aRadius,
			double aStartAngle,
			double anEndAngle) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primClip [

	self ffiCall: #(void cairo_clip ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primClipPreserve [

	self ffiCall: #(void cairo_clip_preserve ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primClosePath [
	
	self ffiCall: #(void cairo_close_path ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primCopyPath [

	^ self ffiCall: #(AeCairoPath cairo_copy_path ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primFill [

	self ffiCall: #( void cairo_fill ( self ))
]

{ #category : #'private - ffi' }
AeCairoContext >> primFillPreserve [

	self ffiCall: #( void cairo_fill_preserve ( self ))
]

{ #category : #'private - text' }
AeCairoContext >> primFontExtents: aFontExtents [

	^ self ffiCall: #( void cairo_font_extents (
		self,
		AeCairoFontExtents* aFontExtents ) )
]

{ #category : #'private - transformation' }
AeCairoContext >> primGetTransform: aCairoMatrix [

	self ffiCall: #( void cairo_get_matrix (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'private - text' }
AeCairoContext >> primGlyphExtents: theGlyphs num: aGlyphsNum metrics: aTextMetrics [

	^ self ffiCall: #( void cairo_glyph_extents (
		self,
		AeCairoGlyphArray theGlyphs,
		int aGlyphsNum,
		AeCairoTextExtents* aTextMetrics ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primInFillX: x y: y [ 

	^ self ffiCall: #( Boolean cairo_in_fill (
		self,
		double x,
		double y ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primLineToX: aX y: aY [

	self ffiCall: #(void cairo_line_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primLoadIdentity [

	self ffiCall: #( void cairo_identity_matrix ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primMoveToX: aX y: aY [

	self ffiCall: #(void cairo_move_to (
			self,
			double aX,
			double aY ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primPaint [

	self ffiCall: #( void cairo_paint ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primPaintAlpha: aNumber [

	self ffiCall: #(void cairo_paint_with_alpha (
			self,
			double aNumber ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primPopGroup [

	^ self ffiCall: #( AeCairoSurfacePattern cairo_pop_group ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primPopGroupToSource [

	self ffiCall: #( void cairo_pop_group_to_source ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primPushGroup [

	self ffiCall: #( void cairo_push_group ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primRectangleX: aX y: aY width: aWidth height: aHeight [

	^ self ffiCall: #(void cairo_rectangle (
			self,
			double aX,
			double aY,
			double aWidth,
			double aHeight ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primRestore [

	self ffiCall: #( void cairo_restore ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSave [

	self ffiCall: #( void cairo_save ( self ) )
]

{ #category : #'private - transformation' }
AeCairoContext >> primScaleX: aX y: aY [

	self ffiCall: #( void cairo_scale (
			self,
			double aX,
			double aY) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetAntialias: aCairoAntialias [

	self ffiCall: #( void cairo_set_antialias (
		self,
      AeCairoAntialias aCairoAntialias ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetDash: anArrayOfDoubles count: aNumberOfDashes offset: anOffset [

	self ffiCall: #( void cairo_set_dash (
		self,
      double* anArrayOfDoubles,
		int aNumberOfDashes,
		double anOffset ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetLineCap: aCairoCapStyle [

	self ffiCall: #( void cairo_set_line_cap (
		self,
      AeCairoCapStyle aCairoCapStyle ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetLineJoin: aCairoJoinStyle [

	self ffiCall: #( void cairo_set_line_join (
		self,
      AeCairoJoinStyle aCairoJoinStyle ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetLineWidth: aNumber [

	self ffiCall: #( void cairo_set_line_width (
		self,
      double aNumber ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetMatrix: aCairoMatrix [

	self ffiCall: #( void cairo_set_matrix (
		self,
		AeCairoMatrix *aCairoMatrix) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetMiterLimit: aNumber [

	self ffiCall: #( void cairo_set_miter_limit (
		self,
      double aNumber ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetOperator: aCairoOperator [

	self ffiCall: #( void cairo_set_operator (
		self,
      AeCairoCompositionOp aCairoOperator ) )
]

{ #category : #'private - text' }
AeCairoContext >> primSetScaledFont: aScaledFont [

	^ self ffiCall: #( void cairo_set_scaled_font (
		self,
		AeCairoScaledFont aScaledFont ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetSource: aPattern [

	self ffiCall: #( void cairo_set_source (
		self,
		AeCairoPattern aPattern ))
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetSourceR: aRed g: aGreen b: aBlue [
	
	self ffiCall: #( void cairo_set_source_rgb (
			self,
			double aRed,
			double aGreen,
			double aBlue) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetSourceR: aRed g: aGreen b: aBlue a: anAlpha [
	
	self ffiCall: #( void cairo_set_source_rgba (
			self,
			double aRed,
			double aGreen,
			double aBlue,
			double anAlpha) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetSourceSurface: aCairoSurface x: aX y: aY [

	self ffiCall: #( void cairo_set_source_surface (
			self,
			AeCairoSurface aCairoSurface,
			double aX,
			double aY) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primSetTolerance: aNumber [ 

	self ffiCall: #( void cairo_set_tolerance (
		self,
      double aNumber ) )
]

{ #category : #'private - text' }
AeCairoContext >> primShowGlyphs: aGlyphsArray num: aNumberOfGlyphs [

	^ self ffiCall: #( void cairo_show_glyphs (
		self,
		void * aGlyphsArray,
		int aNumberOfGlyphs ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primStroke [

	self ffiCall: #( void cairo_stroke ( self ) )
]

{ #category : #'private - ffi' }
AeCairoContext >> primStrokePreserve [

	self ffiCall: #( void cairo_stroke_preserve ( self ))
]

{ #category : #'private - transformation' }
AeCairoContext >> primTranslateX: aX y: aY [

	self ffiCall: #( void cairo_translate (
			self,
			double aX,
			double aY) )
]

{ #category : #API }
AeCairoContext >> rectangle: aRectangle [

	self
		primRectangleX: aRectangle left
		y: aRectangle top
		width: aRectangle width
		height: aRectangle height
]

{ #category : #initialization }
AeCairoContext >> resetClip [

	^ self ffiCall: #( void cairo_reset_clip #( self ) )
]

{ #category : #API }
AeCairoContext >> scale: aPoint [

	self primScaleX: aPoint x y: aPoint y
]

{ #category : #initialization }
AeCairoContext >> setOperatorClear [
	"Set 'clear' drawing mode.
	
	Drawing under this mode will clear the surface under the shape boundaries"
	
	^ self primSetOperator: AeCairoCompositionOp CAIRO_OPERATOR_CLEAR
]

{ #category : #API }
AeCairoContext >> setSourceRGBColor: aColor [

	^ self primSetSourceR: aColor red g: aColor green b: aColor blue
]

{ #category : #accessing }
AeCairoContext >> surface [

	^ surface
]

{ #category : #accessing }
AeCairoContext >> surface: anAeCairoSurface [

	surface := anAeCairoSurface
]

{ #category : #API }
AeCairoContext >> translate: aPoint [

	self primTranslateX: aPoint x y: aPoint y
]
