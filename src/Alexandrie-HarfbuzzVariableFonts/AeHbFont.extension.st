Extension { #name : #AeHbFont }

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variations: variations [

	self variations: variations size: variations size
]

{ #category : #'*Alexandrie-HarfbuzzVariableFonts' }
AeHbFont >> variations: variations size: variationsSize [

	self ffiCall: #(
		void
		hb_font_set_variations (
			self,
			"hb_variation_t*" FFIExternalArray* variations,
			uint variationsSize) )
]
