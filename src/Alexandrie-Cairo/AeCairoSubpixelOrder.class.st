"
I am a Cairo FFI binding for `cairo_subpixel_order_t`.

The subpixel order specifies the order of color elements within each pixel on the display device when rendering with an antialiasing mode of `CAIRO_ANTIALIAS_SUBPIXEL`.

Members:

- `CAIRO_SUBPIXEL_ORDER_DEFAULT`: Use the default subpixel order for for the target device, since 1.0
- `CAIRO_SUBPIXEL_ORDER_RGB`: Subpixel elements are arranged horizontally with red at the left, since 1.0
- `CAIRO_SUBPIXEL_ORDER_BGR`: Subpixel elements are arranged horizontally with blue at the left, since 1.0
- `CAIRO_SUBPIXEL_ORDER_VRGB`: Subpixel elements are arranged vertically with red at the top, since 1.0
- `CAIRO_SUBPIXEL_ORDER_VBGR`: Subpixel elements are arranged vertically with blue at the top, since 1.0

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html#cairo-subpixel-order-t
"
Class {
	#name : #AeCairoSubpixelOrder,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_SUBPIXEL_ORDER_BGR',
		'CAIRO_SUBPIXEL_ORDER_DEFAULT',
		'CAIRO_SUBPIXEL_ORDER_RGB',
		'CAIRO_SUBPIXEL_ORDER_VBGR',
		'CAIRO_SUBPIXEL_ORDER_VRGB'
	],
	#category : #'Alexandrie-Cairo-Context'
}

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> CAIRO_SUBPIXEL_ORDER_BGR [
	"This method was automatically generated"
	^ CAIRO_SUBPIXEL_ORDER_BGR
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> CAIRO_SUBPIXEL_ORDER_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_SUBPIXEL_ORDER_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> CAIRO_SUBPIXEL_ORDER_RGB [
	"This method was automatically generated"
	^ CAIRO_SUBPIXEL_ORDER_RGB
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> CAIRO_SUBPIXEL_ORDER_VBGR [
	"This method was automatically generated"
	^ CAIRO_SUBPIXEL_ORDER_VBGR
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> CAIRO_SUBPIXEL_ORDER_VRGB [
	"This method was automatically generated"
	^ CAIRO_SUBPIXEL_ORDER_VRGB
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> bgr [

	^ CAIRO_SUBPIXEL_ORDER_BGR
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> default [

	^ CAIRO_SUBPIXEL_ORDER_DEFAULT
]

{ #category : #'enum declaration' }
AeCairoSubpixelOrder class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_SUBPIXEL_ORDER_DEFAULT 0
		CAIRO_SUBPIXEL_ORDER_RGB 1
		CAIRO_SUBPIXEL_ORDER_BGR 2
		CAIRO_SUBPIXEL_ORDER_VRGB 3
		CAIRO_SUBPIXEL_ORDER_VBGR 4
	)
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> rgb [

	^ CAIRO_SUBPIXEL_ORDER_RGB
]

{ #category : #hook }
AeCairoSubpixelOrder class >> underlinedNamePrefix [
	
	^ 'CAIRO_SUBPIXEL_'
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> vbgr [

	^ CAIRO_SUBPIXEL_ORDER_VBGR
]

{ #category : #'accessing enum' }
AeCairoSubpixelOrder class >> vrgb [

	^ CAIRO_SUBPIXEL_ORDER_VRGB
]
