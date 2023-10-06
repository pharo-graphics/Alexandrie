"
I am a Cairo FFI binding for `cairo_t`.

This tutorial is a good source to understand how to use my instances: https://www.cairographics.org/tutorial/

See: https://www.cairographics.org/manual/cairo-cairo-t.html
"
Class {
	#name : #AeCairoContext,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#instVars : [
		'surface'
	],
	#classVars : [
		'ThreeHalvesPi'
	],
	#category : #'Alexandrie-Cairo-Core'
}

{ #category : #finalization }
AeCairoContext class >> externallyFree: aHandle [
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-destroy"

	self ffiCall: #( void cairo_destroy ( void * aHandle ) )
]

{ #category : #initialization }
AeCairoContext class >> initialize [

	ThreeHalvesPi := 3.0 * Float halfPi.
]

{ #category : #'instance creation' }
AeCairoContext class >> newFor: aSurface [

	^ (self unownedNewFor: aSurface)
		initializeWith: aSurface;
		autoRelease;
		yourself
]

{ #category : #'instance creation' }
AeCairoContext class >> unownedNewFor: targetSurface [
	"Answer a new instance with all graphics state parameters set to default values.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-create"

	^ self ffiCall: #(
		AeCairoContext
		cairo_create (
			AeCairoSurface targetSurface ) )
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

{ #category : #'API - painting settings' }
AeCairoContext >> antialias: aCairoAntialias [

	self ffiCall: #(
		void
		cairo_set_antialias (
			self,
			AeCairoAntialias aCairoAntialias ) )
]

{ #category : #'API - text' }
AeCairoContext >> appendGlyphsPath: aeCairoGlyphArray [ 
	"Adds closed paths for the glyphs to the current path."

	self appendGlyphsPath: aeCairoGlyphArray length: aeCairoGlyphArray size
]

{ #category : #'API - text' }
AeCairoContext >> appendGlyphsPath: aGlyphsArray length: aNumberOfGlyphs [
	"Adds closed paths for the glyphs to the current path.
	The generated path if filled, achieves an effect similar to that of `cairo_show_glyphs()`.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-glyph-path"
			
	self ffiCall: #(
		void
		cairo_glyph_path (
			self,
			void * aGlyphsArray,
			int aNumberOfGlyphs ) )
]

{ #category : #'API - path' }
AeCairoContext >> appendPath: aCairoPath [
	"Append the path onto the current path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-append-path"

	self ffiCall: #(
		void
		cairo_append_path (
			self,
			AeCairoPath aCairoPath ) )
]

{ #category : #'API - text toy' }
AeCairoContext >> appendTextPath: utf8String [
	"Adds closed paths for text to the current path. The generated path if filled, achieves an effect similar to that of `cairo_show_text()`.
	
	The argument must be a NULL-terminated string of text encoded in UTF-8.

	Text conversion and positioning is done similar to `cairo_show_text()`.

	Like `cairo_show_text()`, After this call the current point is moved to the origin of where the next glyph would be placed in this same progression. That is, the current point will be at the origin of the final glyph offset by its advance values. This allows for chaining multiple calls to to `cairo_text_path()` without having to set current point in between.

	Note: This function call is part of what the cairo designers call the ""toy"" text API. It is convenient for short demos and simple programs, but it is not expected to be adequate for serious text-using applications. See `cairo_glyph_path()` for the ""real"" text path API in cairo.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-text-path"

	self ffiCall: #(
		void
		cairo_text_path (
			self,
			char* utf8String ))
]

{ #category : #'API - path' }
AeCairoContext >> arcCenter: aPoint radius: aRadius startAngle: aStartAngleInRadians endAngle: anEndAngleInRadians [

	self
		arcCenterX: aPoint x
		centerY: aPoint y
		radius: aRadius
		startAngle: aStartAngleInRadians
		endAngle: anEndAngleInRadians
]

{ #category : #'API - path' }
AeCairoContext >> arcCenter: aCenter radius: aRadius startAngle: startAngleInRadians sweep: sweepAngleInRadians [
	"Draw and arc that may be positive or negative according to the specified sweep angle."

	| endAngle |
	endAngle := startAngleInRadians + sweepAngleInRadians.
	sweepAngleInRadians positive
		ifTrue: [
			self
				arcCenter: aCenter
				radius: aRadius
				startAngle: startAngleInRadians
				endAngle: endAngle ]
		ifFalse: [
			self
				arcNegativeCenter: aCenter
				radius: aRadius
				startAngle: startAngleInRadians
				endAngle: endAngle ]
]

{ #category : #'API - path' }
AeCairoContext >> arcCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 
	"Adds a circular arc of the given radius to the current path.
	The arc is centered at xc@yc, begins at angle1 and proceeds in the direction of increasing angles to end at angle2.
	If angle2 is less than angle1 it will be progressively increased by 2*PI until it is greater than angle1.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-arc"

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
AeCairoContext >> arcNegativeCenter: aPoint radius: aRadius startAngle: aStartAngleInRadians endAngle: anEndAngleInRadians [

	^ self
		  arcNegativeCenterX: aPoint x
		  centerY: aPoint y
		  radius: aRadius
		  startAngle: aStartAngleInRadians
		  endAngle: anEndAngleInRadians
]

{ #category : #'API - path' }
AeCairoContext >> arcNegativeCenterX: centerX centerY: centerY radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [ 
	"Adds a circular arc of the given radius to the current path.
	The arc is centered at xc@yc, begins at angle1 and proceeds in the direction of decreasing angles to end at angle2. If angle2 is greater than angle1 it will be progressively decreased by 2*PI until it is less than angle1.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-arc-negative"

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
AeCairoContext >> beginSubPath [
	"Begin a new sub-path. Note that the existing path is not affected. After this call there will be no current point.

	In many cases, this call is not needed since new sub-paths are frequently started with `cairo_move_to()`.

	A call to `cairo_new_sub_path()` is particularly useful when beginning a new sub-path with one of the `cairo_arc()` calls. This makes things easier as it is no longer necessary to manually compute the arc's initial coordinates for a call to `cairo_move_to()`.

	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-new-sub-path"

	self ffiCall: #( void cairo_new_sub_path ( self ) )
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
	"Establishes a new clip region by intersecting the current clip region with the current path as it would be filled according to the current fill rule.

	The current path will be cleared from the cairo context.

	The current clip region affects all drawing operations by effectively masking out any changes to the surface that are outside the current clip region.

	This operation can only make the clip region smaller, never larger. But the current clip is part of the graphics state, so a temporary restriction of the clip region can be achieved by calling `cairo_clip_preserve()` within a `cairo_save()`/`cairo_restore()` pair.
	The only other means of increasing the size of the clip region is `cairo_reset_clip()`.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-clip"

	self ffiCall: #( void cairo_clip ( self ) )
]

{ #category : #'API - query' }
AeCairoContext >> clipExtentsInDeviceSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getClipExtentsIntoLeft: leftPointer
			top: topPointer
			right: rightPointer
			bottom: bottomPointer;
		getUserToDeviceIntoX: leftPointer
			y: topPointer;
		getUserToDeviceIntoX: rightPointer
			y: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoContext >> clipExtentsInUserSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getClipExtentsIntoLeft: leftPointer
		top: topPointer
		right: rightPointer
		bottom: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - clipping' }
AeCairoContext >> clipPreserve [
	"Establishes a new clip region by intersecting the current clip region with the current path as it would be filled according to the current fill rule.

	Preserve the path within the cairo context.

	The current clip region affects all drawing operations by effectively masking out any changes to the surface that are outside the current clip region.

	This operation can only make the clip region smaller, never larger. But the current clip is part of the graphics state, so a temporary restriction of the clip region can be achieved by calling `cairo_clip_preserve()` within a `cairo_save()`/`cairo_restore()` pair.
	The only other means of increasing the size of the clip region is `cairo_reset_clip()`.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-clip-preserve"

	self ffiCall: #( void cairo_clip_preserve ( self ) )
]

{ #category : #'API - clipping' }
AeCairoContext >> clipPreservingPath: aBoolean [
	"Establishes a new clip region by intersecting the current clip region with the current path as it would be filled according to the current fill rule.
	The argument indicates whether the path must be preserved within the cairo context."

	aBoolean
		ifTrue: [ self clipPreserve ]
		ifFalse: [ self clip ]
]

{ #category : #'API - path' }
AeCairoContext >> closePath [
	"Adds a line segment to the path from the current point to the beginning of the current sub-path, (the most recent point passed to `cairo_move_to()`), and closes this sub-path. After this call the current point will be at the joined endpoint of the sub-path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-close-path"

	self ffiCall: #( void cairo_close_path ( self ) )
]

{ #category : #'API - pages' }
AeCairoContext >> copyPage [
	"Emits the current page for backends that support multiple pages, but doesn't clear it, so, the contents of the current page will be retained for the next page too.
	
	Use `AeCairoContext>>#showPage` if you want to get an empty page after the emission.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-copy-page"

	self ffiCall: #( void cairo_copy_page ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> cubicCurveFrom: startPoint controlPoint1: cp1 controlPoint2: cp2 to: endPoint [

	self
		moveTo: startPoint;
		curveVia: cp1 via: cp2 to: endPoint
]

{ #category : #'API - query' }
AeCairoContext >> currentPath [
	"Return an instance of `AeCairoPath` that is a copy of the current path."

	^ self unownedCurrentPath
		  autoRelease;
		  yourself
]

{ #category : #'API - query' }
AeCairoContext >> currentPointInDeviceSpace [

	| xPointer yPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.

	self getCurrentPointIntoX: xPointer y: yPointer.
	self getUserToDeviceIntoX: xPointer y: yPointer.

	^ (xPointer doubleAt: 1) @ (yPointer doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoContext >> currentPointInUserSpace [

	| xPointer yPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.

	self getCurrentPointIntoX: xPointer y: yPointer.

	^ (xPointer doubleAt: 1) @ (yPointer doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoContext >> currentTarget [
	"Gets the current destination surface for the context. This is either the original target surface as passed to `cairo_create()` or the target surface for the current group as started by the most recent call to `cairo_push_group()` or `cairo_push_group_with_content()`.
	
	Return the target surface. This object is owned by cairo.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-group-target"

	self ffiCall: #( AeCairoSurface cairo_get_group_target ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> curveVia: point1 via: point2 to: point3 [

	self
		curveViaX: point1 x y: point1 y
		viaX: point2 x y: point2 y
		toX: point3 x y: point3 y
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

{ #category : #'API - painting settings' }
AeCairoContext >> dash: anArrayOfDoubles count: aNumberOfDashes offset: anOffset [
	"Sets the dash pattern to be used by `cairo_stroke()`.
	A dash pattern is specified by an array of positive values.
	Each value provides the length of alternate 'on' and 'off' portions of the stroke.
	The offset specifies an offset into the pattern at which the stroke begins.

	Each 'on' segment will have caps applied as if the segment were a separate sub-path.
	In particular, it is valid to use an 'on' length of 0.0 with `CAIRO_LINE_CAP_ROUND` or `CAIRO_LINE_CAP_SQUARE` in order to distributed dots or squares along a path.

	Note: The length values are in user-space units as evaluated at the time of stroking.
	This is not necessarily the same as the user space at the time of `cairo_set_dash()`.

	If aNumberOfDashes is 0 dashing is disabled.

	If aNumberOfDashes is 1, a symmetric pattern is assumed with alternating on and off portions of the size specified by the single value.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-dash"

	self ffiCall: #(
		void
		cairo_set_dash (
			self,
			void * anArrayOfDoubles,
			int aNumberOfDashes,
			double anOffset ) )
]

{ #category : #'API - painting settings' }
AeCairoContext >> dash: aFFIExternalArrayOfFloat64 offset: anOffset [

	self
		dash: aFFIExternalArrayOfFloat64
		count: aFFIExternalArrayOfFloat64 size
		offset: anOffset
]

{ #category : #'API - painting settings' }
AeCairoContext >> dashCount [
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-dash-count"

	self ffiCall: #( int cairo_get_dash_count ( self ) )
]

{ #category : #'API - painting settings' }
AeCairoContext >> dashDisable [
	"Disable dashing.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-dash"

	self
		dash: ExternalAddress null
		count: 0
		offset: 0.0
]

{ #category : #'API - painting settings' }
AeCairoContext >> dashes [

	| count aDashArray |
	count := self dashCount.
	count = 0 ifTrue: [ ^ Array empty ].

	aDashArray := AeCairoDoubleArray newOf: count.

	self
		getDashesInto: aDashArray getHandle
		offset: ExternalAddress null.
	
	^ aDashArray
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
	"Fill the current path according to the current fill rule.

	The current path will be cleared from the cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-fill"

	self ffiCall: #( void cairo_fill ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> fillPreserve [
	"Fill the current path according to the current fill rule.
	Preserve the path within the cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-fill-preserve"

	self ffiCall: #( void cairo_fill_preserve ( self ) )
]

{ #category : #'API - painting' }
AeCairoContext >> fillPreservingPath: aBoolean [
	"Fill the current path according to the current fill rule.
	The argument indicates whether the path must be preserved within the cairo context."

	aBoolean
		ifTrue: [ self fillPreserve ]
		ifFalse: [ self fill ]
]

{ #category : #'API - path' }
AeCairoContext >> fillRule [
	"Answer the current fill rule.

	The default fill rule is `CAIRO_FILL_RULE_WINDING`.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-fill-rule"

	self ffiCall: #( AeCairoFillRule cairo_get_fill_rule ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> fillRule: aCairoFillRule [ 
	"Set the current fill rule within the cairo context. The fill rule is used to determine which regions are inside or outside a complex (potentially self-intersecting) path. The current fill rule affects both `cairo_fill()` and `cairo_clip()`.

	The default fill rule is `CAIRO_FILL_RULE_WINDING`.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-fill-rule"

	self ffiCall: #(
		void
		cairo_set_fill_rule (
			self,
			AeCairoFillRule aCairoFillRule ) )
]

{ #category : #'API - text' }
AeCairoContext >> fontExtents [
	"Answer the font extents for the currently selected font."

	| result |
	result := AeCairoFontExtents new.
	self getFontExtentsInto: result.
	^ result
]

{ #category : #'API - text' }
AeCairoContext >> fontFace [
	"Gets the current font face (owned by cairo).
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-get-font-face"

	^ self ffiCall: #( #AeCairoFontFace cairo_get_font_face ( self ) )
]

{ #category : #'API - text' }
AeCairoContext >> fontFace: aFontFace [
	"Replaces the current font face. The replaced font face will be destroyed if there are no other references to it.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-set-font-face"

	^ self ffiCall: #(
		void
		cairo_set_font_face (
			self,
			AeCairoFontFace aFontFace
			) )
]

{ #category : #'API - text' }
AeCairoContext >> fontMatrix: aMatrix [
	"Sets the current font matrix to `aMatrix`. 
	The font matrix gives a transformation from the design space of the font (in this space, the em-square is 1 unit by 1 unit) to user space.
	Normally, a simple scale is used (see `cairo_set_font_size()`), but a more complex font matrix can be used to shear the font or stretch it unequally along the two axes.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-set-font-matrix"

	self ffiCall: #(
		void
		cairo_set_font_matrix (
			self,
			AeCairoMatrix * aMatrix ) )
]

{ #category : #'API - text' }
AeCairoContext >> fontOptions: options [
	"Sets a set of custom font rendering options. Rendering options are derived by merging these options with the options derived from underlying surface; if the value in options has a default value (like CAIRO_ANTIALIAS_DEFAULT), then the value from the surface is used.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-set-font-options"

	self ffiCall: #(
		void
		cairo_set_font_options (
			self,
			AeCairoFontOptions options ) )
]

{ #category : #'API - text' }
AeCairoContext >> fontSize: aSize [
	"Sets the current font matrix to a scale by a factor of `aSize`, replacing any font matrix previously set with `cairo_set_font_size()` or `cairo_set_font_matrix()`.
	This results in a font size of size user space units. (More precisely, this matrix will result in the font's em-square being a size by size square in user space.)

	If text is drawn without a call to `cairo_set_font_size()`, (nor `cairo_set_font_matrix()` nor `cairo_set_scaled_font()`), the default font size is 10.0.

	See: https://www.cairographics.org/manual/cairo-text.html#cairo-set-font-size"

	self ffiCall: #(
		void
		cairo_set_font_size (
			self,
			double aSize ) )
]

{ #category : #'API - query' }
AeCairoContext >> getClipExtentsIntoLeft: x1 top: y1 right: x2 bottom: y2 [
	"Computes a bounding box in user coordinates covering the area inside the current clip.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-clip-extents"

	self ffiCall: #(
		void
		cairo_clip_extents (
			self,
			double *x1,
			double *y1,
			double *x2,
			double *y2 ) )
]

{ #category : #'API - query' }
AeCairoContext >> getCurrentPointIntoX: xPointer y: yPointer [
	"Gets the current point of the current path, which is conceptually the final point reached by the path so far.

	The current point is returned in the user-space coordinate system. If there is no defined current point or if cr is in an error status, x and y will both be set to 0.0. It is possible to check this in advance with `cairo_has_current_point()`.

	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-get-current-point"

	self ffiCall: #(
		void
		cairo_get_current_point (
			self,
			double *xPointer,
			double *yPointer ) )
]

{ #category : #'API - painting settings' }
AeCairoContext >> getDashesInto: pointerToArrayOfDoubles offset: pointerToOffset [
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-dash"

	self ffiCall: #(
		void
		cairo_get_dash (
			self,
			"double" void * pointerToArrayOfDoubles,
			"double" void * pointerToOffset ) )
]

{ #category : #'API - query' }
AeCairoContext >> getExtentsIntoLeft: x1 top: y1 right: x2 bottom: y2 [
	"Computes a bounding box in user-space coordinates covering the points on the current path. If the current path is empty, returns an empty rectangle. Stroke parameters, fill rule, surface dimensions and clipping are not taken into account.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-path-extents"

	self ffiCall: #(
		void
		cairo_path_extents (
			self,
			double *x1,
			double *y1,
			double *x2,
			double *y2 ) )
]

{ #category : #'API - text' }
AeCairoContext >> getFontExtentsInto: aFontExtents [
	"Gets the font extents for the currently selected font.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-font-extents"

	self ffiCall: #(
		void
		cairo_font_extents (
			self,
			AeCairoFontExtents* aFontExtents ) )
]

{ #category : #'API - text' }
AeCairoContext >> getGlyphExtentsOf: aGlyphArray size: numberOfGlyphs into: aTextMetrics [
	"Gets the extents for an array of glyphs. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs, (as they would be drawn by `cairo_show_glyphs()`). Additionally, the `x_advance` and `y_advance` values indicate the amount by which the current point would be advanced by `cairo_show_glyphs()`.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-glyph-extents"

	self ffiCall: #(
		void
		cairo_glyph_extents (
			self,
			AeCairoGlyphArray aGlyphArray,
			int numberOfGlyphs,
			AeCairoTextExtents *aTextMetrics ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> getMatrixInto: aCairoMatrix [
	"Stores the current transformation matrix (CTM) into to argument.
	
	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-get-matrix"

	self ffiCall: #(
		void
		cairo_get_matrix (
			self,
			AeCairoMatrix *aCairoMatrix ) )
]

{ #category : #'API - query' }
AeCairoContext >> getStrokeExtentsIntoLeft: x1 top: y1 right: x2 bottom: y2 [
	"Computes a bounding box in user coordinates covering the area that would be affected, (the 'inked' area), by a `cairo_stroke()` operation given the current path and stroke parameters. 
	If the current path is empty, returns an empty rectangle ((0,0), (0,0)). Surface dimensions and clipping are not taken into account.

	Note that if the line width is set to exactly zero, then `cairo_stroke_extents()` will return an empty rectangle.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-stroke-extents"

	self ffiCall: #(
		void
		cairo_stroke_extents (
			self,
			double *x1,
			double *y1,
			double *x2,
			double *y2 ) )
]

{ #category : #'API - text' }
AeCairoContext >> getTextExtents: utf8String into: aTextExtents [

	self
		deprecated: 'Renamed selector'
		transformWith:
			'`@rcv getTextExtents: `@arg1 into: `@arg2' ->
			'`@rcv getTextExtentsOf: `@arg1 into: `@arg2'.

	self getTextExtentsOf: utf8String into: aTextExtents

]

{ #category : #'API - text' }
AeCairoContext >> getTextExtentsOf: utf8String into: aTextExtents [
	"See: https://www.cairographics.org/manual/cairo-text.html#cairo-text-extents"

	self ffiCall: #(
		void
		cairo_text_extents (
			self,
			char *utf8String,
			AeCairoTextExtents *aTextExtents ) )
]

{ #category : #'API - query' }
AeCairoContext >> getUserToDeviceIntoX: xPointer y: yPointer [
	"Transform a coordinate from user space to device space by multiplying the given point by the current transformation matrix (CTM).

	See: https://www.cairographics.org/manual/cairo-Transformations.html#cairo-user-to-device"

	self ffiCall: #(
		void
		cairo_user_to_device (
			self,
			double *xPointer,
			double *yPointer ) )
]

{ #category : #'API - text' }
AeCairoContext >> glyphExtentsOf: aGlyphArray [
	"Gets the extents for an array of glyphs. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs."

	| textExtents |
	textExtents := AeCairoTextExtents new.
	self
		getGlyphExtentsOf: aGlyphArray
		size: aGlyphArray size
		into: textExtents.
	^ textExtents
]

{ #category : #'API - query' }
AeCairoContext >> hasCurrentPoint [
	"Returns whether a current point is defined on the current path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-has-current-point"

	^ self ffiCall: #( Boolean cairo_has_current_point ( self ) )
]

{ #category : #initialization }
AeCairoContext >> initializeWith: anAeCairoSurface [
	"Note: don't send super initialize as it nullifies the handle."

	surface := anAeCairoSurface
]

{ #category : #'API - query' }
AeCairoContext >> isInClipX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-clip"

	^ self ffiCall: #(
		Boolean
		cairo_in_clip (
			self,
			double x,
			double y ) )
]

{ #category : #'API - query' }
AeCairoContext >> isInFillX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-fill"

	^ self ffiCall: #(
		Boolean
		cairo_in_fill (
			self,
			double x,
			double y ) )
]

{ #category : #'API - query' }
AeCairoContext >> isInStrokeX: x y: y [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-in-stroke"

	^ self ffiCall: #(
		Boolean
		cairo_in_stroke (
			self,
			double x,
			double y ) )
]

{ #category : #'API - painting settings' }
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

{ #category : #'API - painting settings' }
AeCairoContext >> lineJoin: aCairoJoinStyle [

	self ffiCall: #(
		void
		cairo_set_line_join (
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

{ #category : #'API - painting settings' }
AeCairoContext >> lineWidth: aNumber [

	self ffiCall: #(
		void
		cairo_set_line_width (
			self,
			double aNumber ) )
]

{ #category : #'API - painting' }
AeCairoContext >> mask: pattern [
	"A drawing operator that paints the current source using the alpha channel of pattern as a mask.
	(Opaque areas of pattern are painted with the source, transparent areas are not painted.)

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-mask"

	^ self ffiCall: #(
		void
		cairo_mask (
			self,
			AeCairoPattern pattern ) )
]

{ #category : #'API - painting' }
AeCairoContext >> maskGroupWith: aBlockClosure [
	"Mask a surface that will be created in a group with the specified block closure."

	self pushGroup.
	aBlockClosure value.
	self mask: self popGroupAsSurfacePattern
]

{ #category : #'API - painting' }
AeCairoContext >> maskSurface: aSurface x: surfaceX y: surfaceY [
	"A drawing operator that paints the current source using the alpha channel of surface as a mask. (Opaque areas of surface are painted with the source, transparent areas are not painted.)
	
	Parameters:
	- surfaceX X coordinate at which to place the origin of surface
	- surfaceY: Y coordinate at which to place the origin of surface 

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-mask-surface"

	^ self ffiCall: #(
		void
		cairo_mask_surface (
			self,
			AeCairoSurface aSurface,
			double surfaceX,
			double surfaceY ) )
]

{ #category : #'API - matrix' }
AeCairoContext >> matrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix unownedNew.
	self getMatrixInto: aCairoMatrix.
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

{ #category : #'API - painting settings' }
AeCairoContext >> miterLimit: aNumber [

	self ffiCall: #(
		void
		cairo_set_miter_limit (
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
AeCairoContext >> operator [
	"Answer the current compositing operator for a cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-get-operator"

	^ self ffiCall: #( AeCairoOperator cairo_get_operator ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> operator: aCairoOperator [
	"Sets the compositing operator to be used for all drawing operations. See `AeCairoOperator` for details on the semantics of each available compositing operator.

	The default operator is `CAIRO_OPERATOR_OVER`.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-operator"

	self ffiCall: #(
		void
		cairo_set_operator (
			self,
			AeCairoOperator aCairoOperator ) )
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

{ #category : #'API - query' }
AeCairoContext >> pathExtentsInDeviceSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getExtentsIntoLeft: leftPointer
			top: topPointer
			right: rightPointer
			bottom: bottomPointer;
		getUserToDeviceIntoX: leftPointer
			y: topPointer;
		getUserToDeviceIntoX: rightPointer
			y: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoContext >> pathExtentsInUserSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getExtentsIntoLeft: leftPointer
		top: topPointer
		right: rightPointer
		bottom: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - compositing' }
AeCairoContext >> popGroupAsSurfacePattern [

	^ self unownedPopGroupAsSurfacePattern
		  autoRelease;
		  yourself
]

{ #category : #'API - compositing' }
AeCairoContext >> popGroupToSource [
	"Terminates the redirection begun by a call to cairo_push_group() or cairo_push_group_with_content() and installs the resulting pattern as the source pattern in the given cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-pop-group-to-source"

	self ffiCall: #( void cairo_pop_group_to_source ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> pushGroup [

	self ffiCall: #( void cairo_push_group ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> pushGroupWithContent: content [
	"Temporarily redirects drawing to an intermediate surface known as a group. The redirection lasts until the group is completed by a call to `cairo_pop_group()` or `cairo_pop_group_to_source()`. These calls provide the result of any drawing to the group as a pattern, (either as an explicit object, or set as the source pattern).

	The group will have a content type of content . The ability to control this content type is the only distinction between this function and cairo_push_group() which you should see for a more detailed description of group rendering.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-push-group-with-content"

	self ffiCall: #(
		void
		cairo_push_group_with_content (
			self,
			AeCairoContent content ) )
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
		moveTo: startPoint;
		curveVia: cp1 via: cp2 to: endPoint
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
		rectangleX: 0.0
		y: 0.0
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
	"Reset the current clip region to its original, unrestricted state. That is, set the clip region to an infinitely large shape containing the target surface. Equivalently, if infinity is too hard to grasp, one can imagine the clip region being reset to the exact bounds of the target surface.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-reset-clip"

	self ffiCall: #( void cairo_reset_clip #( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> resetPath [
	"Clears the current path. After this call there will be no path and no current point.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-new-path"

	self ffiCall: #( void cairo_new_path ( self ) )
]

{ #category : #'API - states' }
AeCairoContext >> restoreState [
	"Restores me to the state saved by a preceding call to `cairo_save()` and removes that state from the stack of saved states.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-restore"

	self ffiCall: #( void cairo_restore ( self ) )
]

{ #category : #'API - states' }
AeCairoContext >> restoreStateAfter: aBlock [ 
	
	self saveState.
	aBlock value.
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
AeCairoContext >> roundedRectangleLeft: l top: t right: r bottom: b tl: tlR tr: trR br: brR bl: blR [
	"Append the path of a rounded rectangle.

	Assumes that radii are consistent with extent, i.e.:
	* tlR + trR <= r - l  (top side doesn't exceed width)
	* blR + brR <= r - l  (bottom side doesn't exceed width)
	* trR + brR <= b - t  (right side doesn't exceed height)
	* tlR + blR <= b - t  (left side doesn't exceed height)

	See: https://www.cairographics.org/cookbook/roundedrectangles/"

	tlR isZero
		ifFalse: [
			self
				arcCenterX: l + tlR
				centerY: t + tlR
				radius: tlR
				startAngle: Float pi
				endAngle: ThreeHalvesPi ]
		ifTrue: [
			self lineToX: l y: t ].

	trR isZero
		ifFalse: [
			self
				arcCenterX: r - trR
				centerY: t + trR
				radius: trR
				startAngle: ThreeHalvesPi
				endAngle: Float twoPi ]
		ifTrue: [
			self lineToX: r y: t ].

	brR isZero
		ifFalse: [
			self
				arcCenterX: r - brR
				centerY: b - brR
				radius: brR
				startAngle: 0.0
				endAngle: Float halfPi ]
		ifTrue: [
			self lineToX: r y: b ].

	blR isZero
		ifFalse: [
			self
				arcCenterX: l + blR
				centerY: b - blR
				radius: blR
				startAngle: Float halfPi
				endAngle: Float pi ]
		ifTrue: [
			self lineToX: l y: b ].

	self closePath

]

{ #category : #'API - path' }
AeCairoContext >> roundedRectangleTo: extentPoint radius: aRadius [
	"Append the path of a rounded rectangle, where all corners have same radius."

	self
		roundedRectangleLeft: 0.0
		top: 0.0
		right: extentPoint x
		bottom: extentPoint y
		tl: aRadius
		tr: aRadius
		br: aRadius
		bl: aRadius
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
		void
		cairo_scale (
			self,
			double sx,
			double sy ) )
]

{ #category : #'API - text' }
AeCairoContext >> scaledFont [
	"Returns the current scaled font.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-get-scaled-font"

	^ self ffiCall: #( AeCairoScaledFont cairo_get_scaled_font ( self ) )
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

{ #category : #'API - text toy' }
AeCairoContext >> selectFont: aFontFamily slant: aFontSlant weight: aFontWeight [

	self ffiCall: #(
		void
		cairo_select_font_face (
			self,
			char * aFontFamily,
			AeCairoFontSlant aFontSlant,
			AeCairoFontWeight aFontWeight
		) )
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
	
	self operator: AeCairoOperator clear
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorOver [
	"Set 'CAIRO_OPERATOR_OVER' drawing mode. This is the default.

	See https://www.cairographics.org/operators/"
	
	self operator: AeCairoOperator over
]

{ #category : #'API - compositing' }
AeCairoContext >> setOperatorSource [
	"Set 'CAIRO_OPERATOR_SOURCE' drawing mode.

	See https://www.cairographics.org/operators/"
	
	self operator: AeCairoOperator source
]

{ #category : #'API - text' }
AeCairoContext >> showGlyphs: aGlyphsArray [

	^ self showGlyphs: aGlyphsArray size: aGlyphsArray size
]

{ #category : #'API - text' }
AeCairoContext >> showGlyphs: aGlyphsArray size: aNumberOfGlyphs [
	"A drawing operator that generates the shape from an array of glyphs, rendered according to the current font face, font size (font matrix), and font options.
	
	See: https://www.cairographics.org/manual/cairo-text.html#cairo-show-glyphs"

	self ffiCall: #(
		void
		cairo_show_glyphs (
			self,
			void * aGlyphsArray,
			int aNumberOfGlyphs ) )
]

{ #category : #'API - pages' }
AeCairoContext >> showPage [
	"Emits and clears the current page for backends that support multiple pages.

	Use `AeCairoContext>>#copyPage` if you don't want to clear the page.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-show-page"

	self ffiCall: #( void cairo_show_page ( self ) )
]

{ #category : #'API - text toy' }
AeCairoContext >> showText: anUTF8String [
	"A drawing operator that generates the shape from a string of UTF-8 characters, rendered according to the current font_face, font_size (font_matrix), and font_options. "
	
	^ self ffiCall: #(void cairo_show_text (self, char * anUTF8String ))
]

{ #category : #'API - source' }
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
AeCairoContext >> sourceColor: aColor [

	aColor isTranslucent
		ifTrue: [
			self
				sourceColorR: aColor red
				g: aColor green
				b: aColor blue
				a: aColor alpha ]
		ifFalse: [
			self
				sourceColorR: aColor red
				g: aColor green
				b: aColor blue ]
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

	self
		deprecated: 'Please use #sourceColor: instead'
		transformWith:
			'`@receiver sourceColorRGB: `@arg' ->
			'`@receiver sourceColor: `@arg'.

	self sourceColor: aColor
]

{ #category : #'API - source' }
AeCairoContext >> sourceColorRGBA: aColor [

	self
		deprecated: 'Please use #sourceColor: instead'
		transformWith:
			'`@receiver sourceColorRGBA: `@arg' ->
			'`@receiver sourceColor: `@arg'.

	self sourceColor: aColor
]

{ #category : #'API - source' }
AeCairoContext >> sourceConverted [
	"Answer the current source pattern, adopting the precise class according to it's `cairo_pattern_type_t`."

	| result preciseClass |
	result := self source.
	preciseClass := result type correspondingClass.
	preciseClass adoptInstance: result.
	^ result
]

{ #category : #'API - source' }
AeCairoContext >> sourceSurface: aCairoSurface x: aX y: aY [
	"This is a convenience function for creating a pattern from surface and setting it as the source.

	The x and y parameters give the user-space coordinate at which the surface origin should appear. 
	(The surface origin is its upper-left corner before any transformation has been applied.) 
	The x and y parameters are negated and then set as translation values in the pattern matrix.

	Other than the initial translation pattern matrix, as described above, all other pattern attributes, such as its extend mode,
	are set to the default values.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-set-source-surface"

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
	"Stroke the current path according to the current line width, line join, line cap, and dash settings.

	The current path will be cleared from the cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-stroke"

	self ffiCall: #( void cairo_stroke ( self ) )
]

{ #category : #'API - query' }
AeCairoContext >> strokeExtentsInDeviceSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getStrokeExtentsIntoLeft: leftPointer
			top: topPointer
			right: rightPointer
			bottom: bottomPointer;
		getUserToDeviceIntoX: leftPointer
			y: topPointer;
		getUserToDeviceIntoX: rightPointer
			y: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - query' }
AeCairoContext >> strokeExtentsInUserSpace [

	| leftPointer topPointer rightPointer bottomPointer |
	leftPointer := FFIFloat64 newBuffer.
	topPointer := FFIFloat64 newBuffer.
	rightPointer := FFIFloat64 newBuffer.
	bottomPointer := FFIFloat64 newBuffer.

	self
		getStrokeExtentsIntoLeft: leftPointer
		top: topPointer
		right: rightPointer
		bottom: bottomPointer.

	^ (leftPointer doubleAt: 1) @ (topPointer doubleAt: 1) corner:
		  (rightPointer doubleAt: 1) @ (bottomPointer doubleAt: 1)
]

{ #category : #'API - painting' }
AeCairoContext >> strokePreserve [
	"Stroke the current path according to the current line width, line join, line cap, and dash settings.
	Preserve the path within the cairo context.
	
	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-stroke-preserve"

	self ffiCall: #( void cairo_stroke_preserve ( self ))
]

{ #category : #'API - painting' }
AeCairoContext >> strokePreservingPath: aBoolean [
	"Stroke the current path according to the current line width, line join, line cap, and dash settings.
	The argument indicates whether the path must be preserved within the cairo context."

	aBoolean
		ifTrue: [ self strokePreserve ]
		ifFalse: [ self stroke ]
]

{ #category : #accessing }
AeCairoContext >> surface [

	^ surface
]

{ #category : #'API - text' }
AeCairoContext >> textExtentsOf: aString [
	"Gets the extents for a String. The extents describe a user-space rectangle that encloses the 'inked' portion of the glyphs."

	| textExtents |
	textExtents := AeCairoTextExtents new.
	self
		getTextExtentsOf: aString utf8Encoded
		into: textExtents.
	^ textExtents
]

{ #category : #'API - painting settings' }
AeCairoContext >> tolerance: aNumber [ 

	self ffiCall: #(
		void
		cairo_set_tolerance (
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
			AeCairoMatrix *aCairoMatrix ) )
]

{ #category : #'API - query' }
AeCairoContext >> transformedFromUserToDevice: aPoint [

	| xPointer yPointer |
	xPointer := FFIFloat64 newBuffer.
	yPointer := FFIFloat64 newBuffer.

	xPointer doubleAt: 1 put: aPoint x.
	yPointer doubleAt: 1 put: aPoint y.

	self getUserToDeviceIntoX: xPointer y: yPointer.

	^ (xPointer doubleAt: 1) @ (xPointer doubleAt: 1)
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

{ #category : #'API - query' }
AeCairoContext >> unownedCurrentPath [
	"Return a copy of the current path.
	
	See: https://www.cairographics.org/manual/cairo-Paths.html#cairo-copy-path"

	^ self ffiCall: #( AeCairoPath cairo_copy_path ( self ) )
]

{ #category : #'API - compositing' }
AeCairoContext >> unownedPopGroupAsSurfacePattern [
	"Terminates the redirection begun by a call to cairo_push_group() or cairo_push_group_with_content() and returns a new pattern containing the results of all drawing operations performed to the group.

	The cairo_pop_group() function calls cairo_restore(), (balancing a call to cairo_save() by the push_group function), so that any changes to the graphics state will not be visible outside the group.

	Return a newly created (surface) pattern containing the results of all drawing operations performed to the group. The caller owns the returned object and should call cairo_pattern_destroy() when finished with it.

	See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-pop-group"

	^ self ffiCall: #( AeCairoSurfacePattern cairo_pop_group ( self ) )
]

{ #category : #'API - path' }
AeCairoContext >> useFillRuleEvenOdd [
	"Select even-odd rule to fill paths.
	
	Counts the total number of intersections, without regard to the orientation of the contour. If the total number of intersections is odd, the point will be filled."

	self fillRule: AeCairoFillRule evenOdd
]

{ #category : #'API - path' }
AeCairoContext >> useFillRuleWinding [
	"Select winding rule to fill paths.
	
	If the path crosses the ray from left-to-right, counts +1. If the path crosses the ray from right to left, counts -1. (Left and right are determined from the perspective of looking along the ray from the starting point.) If the total count is non-zero, the point will be filled."

	self fillRule: AeCairoFillRule winding
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineCapButt [

	self lineCap: AeCairoCapStyle butt
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineCapRound [

	self lineCap: AeCairoCapStyle round
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineCapSquare [

	self lineCap: AeCairoCapStyle square
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineJoinBevel [

	self lineJoin: AeCairoJoinStyle bevel
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineJoinMiter [

	self lineJoin: AeCairoJoinStyle miter
]

{ #category : #'API - painting settings' }
AeCairoContext >> useLineJoinRound [

	self lineJoin: AeCairoJoinStyle round
]
