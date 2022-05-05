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
