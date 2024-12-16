"
I am a Cairo FFI binding for `cairo_line_cap_t`.

Specifies how to render the endpoints of the path when stroking.

Members:

- `CAIRO_LINE_CAP_BUTT`: start(stop) the line exactly at the start(end) point (Since 1.0)
- `CAIRO_LINE_CAP_ROUND`: use a round ending, the center of the circle is the end point (Since 1.0)
- `CAIRO_LINE_CAP_SQUARE`: use squared ending, the center of the square is the end point (Since 1.0)

See: https://www.cairographics.org/manual/cairo-cairo-t.html#cairo-line-cap-t
"
Class {
	#name : #AeCairoStrokeCap,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_LINE_CAP_BUTT',
		'CAIRO_LINE_CAP_ROUND',
		'CAIRO_LINE_CAP_SQUARE'
	],
	#category : #'Alexandrie-Cairo-Context'
}

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> CAIRO_LINE_CAP_BUTT [
	"This method was automatically generated"
	^ CAIRO_LINE_CAP_BUTT
]

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> CAIRO_LINE_CAP_ROUND [
	"This method was automatically generated"
	^ CAIRO_LINE_CAP_ROUND
]

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> CAIRO_LINE_CAP_SQUARE [
	"This method was automatically generated"
	^ CAIRO_LINE_CAP_SQUARE
]

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> butt [

	^ CAIRO_LINE_CAP_BUTT
]

{ #category : #'enum declaration' }
AeCairoStrokeCap class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_LINE_CAP_BUTT 0
		CAIRO_LINE_CAP_ROUND 1
		CAIRO_LINE_CAP_SQUARE 2
	)
]

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> round [

	^ CAIRO_LINE_CAP_ROUND
]

{ #category : #'accessing enum' }
AeCairoStrokeCap class >> square [

	^ CAIRO_LINE_CAP_SQUARE
]

{ #category : #hook }
AeCairoStrokeCap class >> underlinedNamePrefix [
	
	^ 'CAIRO_LINE_CAP_'
]
