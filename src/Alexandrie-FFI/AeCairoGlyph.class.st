"
I am a Cairo FFI binding for `cairo_glyph_t`.

The `cairo_glyph_t` structure holds information about a single glyph when drawing or measuring text. A font is (in simple terms) a collection of shapes used to draw text. A glyph is one of these shapes. There can be multiple glyphs for a single character (alternates to be used in different contexts, for example), or a glyph can be a ligature of multiple characters. Cairo doesn't expose any way of converting input text into glyphs, so in order to use the Cairo interfaces that take arrays of glyphs, you must directly access the appropriate underlying font system.

See: https://www.cairographics.org/manual/cairo-text.html#cairo-glyph-t
"
Class {
	#name : #AeCairoGlyph,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_INDEX',
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'Alexandrie-FFI-Text'
}

{ #category : #'field definition' }
AeCairoGlyph class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"
	^ #(
		ulong index;
		double x;
		double y;	
	)
]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> index [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_INDEX
]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> index: anObject [
	"This method was automatically generated"
	^handle platformUnsignedLongAt: OFFSET_INDEX put: anObject
]

{ #category : #accessing }
AeCairoGlyph >> position [ 

	^ self x @ self y
]

{ #category : #printing }
AeCairoGlyph >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: '(position: ';
		print: self position;
		nextPutAll: ' index: ';
		print: self index;
		nextPut: $)

]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing structure variables' }
AeCairoGlyph >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
