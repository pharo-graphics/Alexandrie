"
I am a Cairo FFI binding for `cairo_hint_style_t`.

Specifies the type of hinting to do on font outlines. Hinting is the process of fitting outlines to the pixel grid in order to improve the appearance of the result. Since hinting outlines involves distorting them, it also reduces the faithfulness to the original outline shapes. Not all of the outline hinting styles are supported by all font backends.

Members:

- `CAIRO_HINT_STYLE_DEFAULT`: Use the default hint style for font backend and target device, since 1.0
- `CAIRO_HINT_STYLE_NONE`: Do not hint outlines, since 1.0
- `CAIRO_HINT_STYLE_SLIGHT`: Hint outlines slightly to improve contrast while retaining good fidelity to the original shapes, since 1.0
- `CAIRO_HINT_STYLE_MEDIUM`: Hint outlines with medium strength giving a compromise between fidelity to the original shapes and contrast, since 1.0
- `CAIRO_HINT_STYLE_FULL`: Hint outlines to maximize contrast, since 1.0

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html#cairo-hint-style-t
"
Class {
	#name : #AeCairoHintStyle,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_HINT_STYLE_DEFAULT',
		'CAIRO_HINT_STYLE_FULL',
		'CAIRO_HINT_STYLE_MEDIUM',
		'CAIRO_HINT_STYLE_NONE',
		'CAIRO_HINT_STYLE_SLIGHT'
	],
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_FULL [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_FULL
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_MEDIUM [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_MEDIUM
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_NONE [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_NONE
]

{ #category : #'accessing enum' }
AeCairoHintStyle class >> CAIRO_HINT_STYLE_SLIGHT [
	"This method was automatically generated"
	^ CAIRO_HINT_STYLE_SLIGHT
]

{ #category : #'enum declaration' }
AeCairoHintStyle class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_HINT_STYLE_DEFAULT 0
		CAIRO_HINT_STYLE_NONE 1
		CAIRO_HINT_STYLE_SLIGHT 2
		CAIRO_HINT_STYLE_MEDIUM 3
		CAIRO_HINT_STYLE_FULL 4
	)
]
