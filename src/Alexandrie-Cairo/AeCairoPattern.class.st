"
I am a Cairo FFI binding for `cairo_pattern_t`.
A `cairo_pattern_t` represents a source when drawing onto a surface.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html
"
Class {
	#name : #AeCairoPattern,
	#superclass : #FFIExternalObject,
	#traits : 'AeTCairoLibrary + AeTExternalFree',
	#classTraits : 'AeTCairoLibrary classTrait + AeTExternalFree classTrait',
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'private - ffi' }
AeCairoPattern class >> externallyFree: aHandle [
	
	self ffiCall: #( void cairo_pattern_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeCairoPattern class >> new [
	"Instance are created via FFI, with specialized class side methods of each subclass."

	^ self shouldNotImplement
]

{ #category : #API }
AeCairoPattern >> extend: anExtendMode [
	"Sets the mode to be used for drawing outside the area of a pattern. See cairo_extend_t for details on the semantics of each extend strategy.

The default extend mode is CAIRO_EXTEND_NONE for surface patterns and CAIRO_EXTEND_PAD for gradient patterns.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-extend"

	self ffiCall: #(
		void cairo_pattern_set_extend (
			self,
			AeCairoExtendMode anExtendMode ) )
]

{ #category : #API }
AeCairoPattern >> filter [
	"Gets the current filter on this pattern.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-get-filter"

	self ffiCall: #( AeCairoSamplingFilter cairo_pattern_get_filter ( self ) )
]

{ #category : #API }
AeCairoPattern >> filter: filter [
	"Sets the filter to be used for resizing when using this pattern.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-filter"

	self ffiCall: #(
		void
		cairo_pattern_set_filter (
			self,
			AeCairoSamplingFilter filter ) )
]

{ #category : #'API - matrix' }
AeCairoPattern >> getMatrixInto: aCairoMatrix [
	"Stores the pattern's transformation matrix into to argument.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-get-matrix"

	self ffiCall: #(
		void
		cairo_pattern_get_matrix (
			self,
			AeCairoMatrix *aCairoMatrix ) )
]

{ #category : #accessing }
AeCairoPattern >> matrix [

	| aCairoMatrix |
	aCairoMatrix := AeCairoMatrix unownedNew.
	self getMatrixInto: aCairoMatrix.
	^ aCairoMatrix
		  autoRelease;
		  yourself
]

{ #category : #API }
AeCairoPattern >> matrix: matrix [
	"Sets the pattern's transformation matrix to matrix . This matrix is a transformation from user space to pattern space.

	When a pattern is first created it always has the identity matrix for its transformation matrix, which means that pattern space is initially identical to user space.

	Important: Please note that the direction of this transformation matrix is from user space to pattern space. This means that if you imagine the flow from a pattern to user space (and on to device space), then coordinates in that flow will be transformed by the inverse of the pattern matrix.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-set-matrix"

	self ffiCall: #(
		void
		cairo_pattern_set_matrix (
			self,
			AeCairoMatrix * matrix ) )
]

{ #category : #API }
AeCairoPattern >> status [
	"Checks whether an error has previously occurred for this pattern.
	
	See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-status"

	^ self ffiCall: #( AeCairoStatus cairo_pattern_status ( self ) )
]

{ #category : #API }
AeCairoPattern >> type [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-get-type"

	^ self ffiCall: #( AeCairoPatternType cairo_pattern_get_type ( self ) )
]
