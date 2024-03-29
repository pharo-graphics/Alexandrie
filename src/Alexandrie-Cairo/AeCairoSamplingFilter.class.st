"
I am a Cairo FFI binding for `cairo_filter_t`.

It is used to indicate what filtering should be applied when reading pixel values from patterns. See `cairo_pattern_set_filter()` for indicating the desired filter to be used with a particular pattern.

See: https://cairographics.org/manual/cairo-cairo-pattern-t.html#cairo-filter-t
"
Class {
	#name : #AeCairoSamplingFilter,
	#superclass : #AeEnumeration,
	#classVars : [
		'CAIRO_FILTER_BEST',
		'CAIRO_FILTER_BILINEAR',
		'CAIRO_FILTER_FAST',
		'CAIRO_FILTER_GAUSSIAN',
		'CAIRO_FILTER_GOOD',
		'CAIRO_FILTER_NEAREST'
	],
	#category : #'Alexandrie-Cairo-Context'
}

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_BEST [
	"This method was automatically generated"
	^ CAIRO_FILTER_BEST
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_BILINEAR [
	"This method was automatically generated"
	^ CAIRO_FILTER_BILINEAR
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_FAST [
	"This method was automatically generated"
	^ CAIRO_FILTER_FAST
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_GAUSSIAN [
	"This method was automatically generated"
	^ CAIRO_FILTER_GAUSSIAN
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_GOOD [
	"This method was automatically generated"
	^ CAIRO_FILTER_GOOD
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> CAIRO_FILTER_NEAREST [
	"This method was automatically generated"
	^ CAIRO_FILTER_NEAREST
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> best [

	^ CAIRO_FILTER_BEST
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> bilinear [

	^ CAIRO_FILTER_BILINEAR
]

{ #category : #'enum declaration' }
AeCairoSamplingFilter class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ #(
		CAIRO_FILTER_FAST 0
		CAIRO_FILTER_GOOD 1
		CAIRO_FILTER_BEST 2
		CAIRO_FILTER_NEAREST 3
		CAIRO_FILTER_BILINEAR 4
		CAIRO_FILTER_GAUSSIAN 5
	)
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> fast [

	^ CAIRO_FILTER_FAST
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> gaussian [

	^ CAIRO_FILTER_GAUSSIAN
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> good [

	^ CAIRO_FILTER_GOOD
]

{ #category : #'accessing enum' }
AeCairoSamplingFilter class >> nearest [

	^ CAIRO_FILTER_NEAREST
]

{ #category : #hook }
AeCairoSamplingFilter class >> underlinedNamePrefix [
	
	^ 'CAIRO_FILTER_'
]
