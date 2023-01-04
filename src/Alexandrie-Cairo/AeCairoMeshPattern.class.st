"
I am a Cairo FFI binding for a `cairo_pattern_t` with a mesh.

Mesh patterns are tensor-product patch meshes (type 7 shadings in PDF). Mesh patterns may also be used to create other types of shadings that are special cases of tensor-product patch meshes such as Coons patch meshes (type 6 shading in PDF) and Gouraud-shaded triangle meshes (type 4 and 5 shadings in PDF).

Mesh patterns consist of one or more tensor-product patches, which should be defined before using the mesh pattern.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-mesh
"
Class {
	#name : #AeCairoMeshPattern,
	#superclass : #AeCairoPattern,
	#category : #'Alexandrie-Cairo-Patterns'
}

{ #category : #'instance creation' }
AeCairoMeshPattern class >> newEmpty [

	^ self unownedNewEmpty
		autoRelease;
		yourself
]

{ #category : #'instance creation' }
AeCairoMeshPattern class >> unownedNewEmpty [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-create-mesh"
	
	^ self ffiCall: #(
		AeCairoMeshPattern
		cairo_pattern_create_mesh () )
]

{ #category : #'begin/end' }
AeCairoMeshPattern >> beginPatch [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-begin-patch"

	self ffiCall: #(
		void
		cairo_mesh_pattern_begin_patch ( self ) )
]

{ #category : #color }
AeCairoMeshPattern >> cornerAt: index putColorRGB: aColor [

	self
		cornerAt: index
		putR: aColor red
		g: aColor green
		b: aColor blue
]

{ #category : #color }
AeCairoMeshPattern >> cornerAt: index putColorRGBA: aColor [

	self
		cornerAt: index
		putR: aColor red
		g: aColor green
		b: aColor blue
		a: aColor alpha
]

{ #category : #color }
AeCairoMeshPattern >> cornerAt: index putR: r g: g b: b [ 
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-set-corner-color-rgb"
	
	self ffiCall: #(
		void
		cairo_mesh_pattern_set_corner_color_rgb (
			self,
			uint index,
			double r,
			double g,
			double b ) )
]

{ #category : #color }
AeCairoMeshPattern >> cornerAt: index putR: r g: g b: b a: a [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-set-corner-color-rgba"
	
	self ffiCall: #(
		void
		cairo_mesh_pattern_set_corner_color_rgba (
			self,
			uint index,
			double r,
			double g,
			double b,
			double a ) )
]

{ #category : #path }
AeCairoMeshPattern >> curveViaX: x1 y: y1 viaX: x2 y: y2 toX: x3 y: y3 [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-curve-to"	

	self ffiCall: #(
		void
		cairo_mesh_pattern_curve_to (
			self,
			double x1,
			double y1,
			double x2,
			double y2,
			double x3,
			double y3 ) )
]

{ #category : #'begin/end' }
AeCairoMeshPattern >> endPatch [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-end-patch"

	self ffiCall: #(
		void
		cairo_mesh_pattern_end_patch ( self ) )
]

{ #category : #path }
AeCairoMeshPattern >> lineTo: aPoint [

	self lineToX: aPoint x y: aPoint y

]

{ #category : #path }
AeCairoMeshPattern >> lineToX: x y: y [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-line-to"

	self ffiCall: #(
		void
		cairo_mesh_pattern_line_to (
			self,
			double x,
			double y ) )
]

{ #category : #path }
AeCairoMeshPattern >> moveTo: aPoint [

	self moveToX: aPoint x y: aPoint y
]

{ #category : #path }
AeCairoMeshPattern >> moveToX: x y: y [
	"See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-mesh-pattern-move-to"

	self ffiCall: #(
		void
		cairo_mesh_pattern_move_to (
			self,
			double x,
			double y ) )
]
