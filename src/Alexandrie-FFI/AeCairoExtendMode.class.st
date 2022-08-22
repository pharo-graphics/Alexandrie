"
I am a Cairo FFI binding for `cairo_extend_t`.

It is used to describe how pattern color/alpha will be determined for areas ""outside"" the pattern's natural area, (for example, outside the surface bounds or outside the gradient geometry).

Mesh patterns are not affected by the extend mode.

The default extend mode is `CAIRO_EXTEND_NONE` for surface patterns and `CAIRO_EXTEND_PAD` for gradient patterns.

Members:

- `CAIRO_EXTEND_NONE`: pixels outside of the source pattern are fully transparent (Since 1.0)
- `CAIRO_EXTEND_REPEAT`: the pattern is tiled by repeating (Since 1.0)
- `CAIRO_EXTEND_REFLECT`: the pattern is tiled by reflecting at the edges (Since 1.0; but only implemented for surface patterns since 1.6)
- `CAIRO_EXTEND_PAD`: pixels outside of the pattern copy the closest pixel from the source (Since 1.2; but only implemented for surface patterns since 1.6)

See: https://www.cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-extend-t
"
Class {
	#name : #AeCairoExtendMode,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_EXTEND_NONE',
		'CAIRO_EXTEND_PAD',
		'CAIRO_EXTEND_REFLECT',
		'CAIRO_EXTEND_REPEAT'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_NONE [
	"This method was automatically generated"
	^ CAIRO_EXTEND_NONE
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_PAD [
	"This method was automatically generated"
	^ CAIRO_EXTEND_PAD
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_REFLECT [
	"This method was automatically generated"
	^ CAIRO_EXTEND_REFLECT
]

{ #category : #'accessing enum' }
AeCairoExtendMode class >> CAIRO_EXTEND_REPEAT [
	"This method was automatically generated"
	^ CAIRO_EXTEND_REPEAT
]

{ #category : #'enum declaration' }
AeCairoExtendMode class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_EXTEND_NONE 0
		CAIRO_EXTEND_REPEAT 1
		CAIRO_EXTEND_REFLECT 2
		CAIRO_EXTEND_PAD 3
	)
]
