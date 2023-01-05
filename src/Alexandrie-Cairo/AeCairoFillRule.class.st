"
I am a Cairo FFI binding for `cairo_fill_rule_t`.

It is used to select how paths are filled. For both fill rules, whether or not a point is included in the fill is determined by taking a ray from that point to infinity and looking at intersections with the path. The ray can be in any direction, as long as it doesn't pass through the end point of a segment or have a tricky intersection such as intersecting tangent to the path. (Note that filling is not actually implemented in this way. This is just a description of the rule that is applied.)

The default fill rule is `CAIRO_FILL_RULE_WINDING`.

Members:

- `CAIRO_FILL_RULE_WINDING`: If the path crosses the ray from left-to-right, counts +1. If the path crosses the ray from right to left, counts -1. (Left and right are determined from the perspective of looking along the ray from the starting point.) If the total count is non-zero, the point will be filled. (Since 1.0)
- `CAIRO_FILL_RULE_EVEN_ODD`: Counts the total number of intersections, without regard to the orientation of the contour. If the total number of intersections is odd, the point will be filled. (Since 1.0)

See: https://cairographics.org/manual/cairo-cairo-t.html#cairo-fill-rule-t
"
Class {
	#name : #AeCairoFillRule,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FILL_RULE_EVEN_ODD',
		'CAIRO_FILL_RULE_WINDING'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoFillRule class >> CAIRO_FILL_RULE_EVEN_ODD [
	"This method was automatically generated"
	^ CAIRO_FILL_RULE_EVEN_ODD
]

{ #category : #'accessing enum' }
AeCairoFillRule class >> CAIRO_FILL_RULE_WINDING [
	"This method was automatically generated"
	^ CAIRO_FILL_RULE_WINDING
]

{ #category : #'enum declaration' }
AeCairoFillRule class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FILL_RULE_WINDING 0
		CAIRO_FILL_RULE_EVEN_ODD 1
	)
]

{ #category : #'accessing enum' }
AeCairoFillRule class >> evenOdd [

	^ CAIRO_FILL_RULE_EVEN_ODD
]

{ #category : #hook }
AeCairoFillRule class >> underlinedNamePrefix [
	
	^ 'CAIRO_FILL_'
]

{ #category : #'accessing enum' }
AeCairoFillRule class >> winding [

	^ CAIRO_FILL_RULE_WINDING
]
