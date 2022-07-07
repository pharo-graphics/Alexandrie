"
I am a Cairo FFI binding for `cairo_hint_metrics_t`.

Specifies whether to hint font metrics; hinting font metrics means quantizing them so that they are integer values in device space. Doing this improves the consistency of letter and line spacing, however it also means that text will be laid out differently at different zoom factors.

Members:

- `CAIRO_HINT_METRICS_DEFAULT`: Hint metrics in the default manner for the font backend and target device, since 1.0
- `CAIRO_HINT_METRICS_OFF`: Do not hint font metrics, since 1.0
- `CAIRO_HINT_METRICS_ON`: Hint font metrics, since 1.0

See: https://www.cairographics.org/manual/cairo-cairo-font-options-t.html#cairo-hint-metrics-t
"
Class {
	#name : #AeCairoHintMetrics,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_HINT_METRICS_DEFAULT',
		'CAIRO_HINT_METRICS_OFF',
		'CAIRO_HINT_METRICS_ON'
	],
	#category : #'Alexandrie-FFI-Enumerations'
}

{ #category : #'accessing enum' }
AeCairoHintMetrics class >> CAIRO_HINT_METRICS_DEFAULT [
	"This method was automatically generated"
	^ CAIRO_HINT_METRICS_DEFAULT
]

{ #category : #'accessing enum' }
AeCairoHintMetrics class >> CAIRO_HINT_METRICS_OFF [
	"This method was automatically generated"
	^ CAIRO_HINT_METRICS_OFF
]

{ #category : #'accessing enum' }
AeCairoHintMetrics class >> CAIRO_HINT_METRICS_ON [
	"This method was automatically generated"
	^ CAIRO_HINT_METRICS_ON
]

{ #category : #'enum declaration' }
AeCairoHintMetrics class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_HINT_METRICS_DEFAULT 0
		CAIRO_HINT_METRICS_OFF 1
		CAIRO_HINT_METRICS_ON 2
	)
]
