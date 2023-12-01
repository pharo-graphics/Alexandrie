Extension { #name : 'AeHbBuffer' }

{ #category : '*Alexandrie-HarfbuzzCairo' }
AeHbBuffer >> unownedGlyphsFrom: utf8 length: utf8Length xScaleFactor: xScaleFactor yScaleFactor: yScaleFactor intoGlyphs: glyphArrayAddress num: glyphArrayLengthAddress [
	"See: https://harfbuzz.github.io/harfbuzz-hb-cairo.html#hb-cairo-glyphs-from-buffer"

	^ self
		ffiCall: #(
			void
			hb_cairo_glyphs_from_buffer (
				self,
				false,
				double xScaleFactor,
				double yScaleFactor,
				double 0.0,
				double 0.0,
				const char *utf8,
				int utf8Length,
				void **glyphArrayAddress,
				uint *glyphArrayLengthAddress,
				nil,
				nil,
				nil ) )
		library: AeHarfbuzzCairoLibrary
]
