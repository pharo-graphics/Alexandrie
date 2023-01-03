"
I am a Cairo FFI binding for `cairo_rectangle_t`.

`cairo_rectangle_t` is a data structure for holding a rectangle.

See: https://cairographics.org/manual/cairo-cairo-t.html#cairo-rectangle-t
"
Class {
	#name : #AeCairoRectangle,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_HEIGHT',
		'OFFSET_WIDTH',
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'Alexandrie-Cairo-Structures'
}

{ #category : #'field definition' }
AeCairoRectangle class >> fieldsDesc [
	"
	self rebuildFieldAccessors
	"

	^ #(
		double x;
		double y;
		double width;
		double height;
	)
]

{ #category : #'instance creation' }
AeCairoRectangle class >> origin: originPoint extent: extentPoint [

	^ self new
		x: originPoint x;
		y: originPoint y;
		width: extentPoint x;
		height: extentPoint y;
		yourself
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> height [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_HEIGHT
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> height: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_HEIGHT put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> width [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_WIDTH
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> width: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_WIDTH put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : #'accessing - structure variables' }
AeCairoRectangle >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
