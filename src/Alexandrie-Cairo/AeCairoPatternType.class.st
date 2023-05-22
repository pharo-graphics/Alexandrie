"
I am a Cairo FFI binding for `cairo_pattern_type_t`.

The type of a pattern is determined by the function used to create it.


Members:
- `CAIRO_PATTERN_TYPE_SOLID`: The pattern is a solid (uniform) color. It may be opaque or translucent, since 1.2.
- `CAIRO_PATTERN_TYPE_SURFACE`: The pattern is a based on a surface (an image), since 1.2.
- `CAIRO_PATTERN_TYPE_LINEAR`: The pattern is a linear gradient, since 1.2.
- `CAIRO_PATTERN_TYPE_RADIAL`: The pattern is a radial gradient, since 1.2.
- `CAIRO_PATTERN_TYPE_MESH`: The pattern is a mesh, since 1.12.
- `CAIRO_PATTERN_TYPE_RASTER_SOURCE`: The pattern is a user pattern providing raster data, since 1.12.

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-pattern-type-t
"
Class {
	#name : #AeCairoPatternType,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_PATTERN_TYPE_LINEAR',
		'CAIRO_PATTERN_TYPE_MESH',
		'CAIRO_PATTERN_TYPE_RADIAL',
		'CAIRO_PATTERN_TYPE_RASTER_SOURCE',
		'CAIRO_PATTERN_TYPE_SOLID',
		'CAIRO_PATTERN_TYPE_SURFACE',
		'ClassByValue'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_LINEAR [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_LINEAR
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_MESH [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_MESH
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_RADIAL [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_RADIAL
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_RASTER_SOURCE [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_RASTER_SOURCE
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_SOLID [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_SOLID
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> CAIRO_PATTERN_TYPE_SURFACE [
	"This method was automatically generated"
	^ CAIRO_PATTERN_TYPE_SURFACE
]

{ #category : #'enum declaration' }
AeCairoPatternType class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_PATTERN_TYPE_SOLID 0
		CAIRO_PATTERN_TYPE_SURFACE 1
		CAIRO_PATTERN_TYPE_LINEAR 2
		CAIRO_PATTERN_TYPE_RADIAL 3
		CAIRO_PATTERN_TYPE_MESH 4
		CAIRO_PATTERN_TYPE_RASTER_SOURCE 5
	)
]

{ #category : #'enum declaration' }
AeCairoPatternType class >> initialize [

	ClassByValue := Dictionary new
		at: CAIRO_PATTERN_TYPE_SOLID put: AeCairoColorPattern;
		at: CAIRO_PATTERN_TYPE_SURFACE put: AeCairoSurfacePattern;
		at: CAIRO_PATTERN_TYPE_LINEAR put: AeCairoLinearGradientPattern;
		at: CAIRO_PATTERN_TYPE_RADIAL put: AeCairoRadialGradientPattern;
		at: CAIRO_PATTERN_TYPE_MESH put: AeCairoMeshPattern;
		at: CAIRO_PATTERN_TYPE_RASTER_SOURCE put: AeCairoPattern;
		yourself

	"Note: CAIRO_PATTERN_TYPE_RASTER_SOURCE is not yet implemented.
	See more information in:
	https://www.cairographics.org/manual/cairo-Raster-Sources.html"

]

{ #category : #'accessing enum' }
AeCairoPatternType class >> linear [

	^ CAIRO_PATTERN_TYPE_LINEAR
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> mesh [

	^ CAIRO_PATTERN_TYPE_MESH
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> radial [

	^ CAIRO_PATTERN_TYPE_RADIAL
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> rasterSource [

	^ CAIRO_PATTERN_TYPE_RASTER_SOURCE
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> solid [

	^ CAIRO_PATTERN_TYPE_SOLID
]

{ #category : #'accessing enum' }
AeCairoPatternType class >> surface [

	^ CAIRO_PATTERN_TYPE_SURFACE
]

{ #category : #hook }
AeCairoPatternType class >> underlinedNamePrefix [
	
	^ 'CAIRO_PATTERN_TYPE_'
]
