Extension { #name : #AeHbFont }

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> getVariationCoordinatesWritingSizeInto: sizeAddress [ 

	^ self ffiCall: #(
		void *
		hb_font_get_var_coords_design (
			self,
			uint *sizeAddress ) )
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variationAtTagInteger: tagAsInteger put: valueAsFloat [
	"Change the value of one variation axis on this font.

	Note: This function is expensive to be called repeatedly. If you want to set multiple variation axes at the same time, use `hb_font_set_variations()` instead.

	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-set-variation"

	self ffiCall: #(
		void
		hb_font_set_variation (
			self,
			hb_tag_t tagAsInteger,
			float valueAsFloat) )
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variationAtTagString: tagAsString put: valueAsFloat [ 
	
	self variationAtTagInteger: tagAsString asHbTagInteger put: valueAsFloat
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variationCoordinates [

	| sizeAddress arrayAddress arraySize |
	sizeAddress := FFIUInt32 newBuffer.
	arrayAddress := self getVariationCoordinatesWritingSizeInto: sizeAddress.
	arraySize := sizeAddress unsignedLongAt: 1.

	^ arraySize isZero
		ifTrue: [ #() ]
		ifFalse: [
			FFIExternalArray
				fromHandle: arrayAddress
				type: FFIFloat32
				size: arraySize ]
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variations: variations [

	self variations: variations size: variations size
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variations: variations size: variationsSize [
	"Applies a list of font-variation settings to this font.

	Note that this overrides all existing variations set on this font. Axes not included in variations will be effectively set to their default values.

	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-set-variations"

	self ffiCall: #(
		void
		hb_font_set_variations (
			self,
			"hb_variation_t*" FFIExternalArray* variations,
			uint variationsSize) )
]
