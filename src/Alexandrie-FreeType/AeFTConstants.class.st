"
I contain constants of the FreeType C API.
"
Class {
	#name : #AeFTConstants,
	#superclass : #SharedPool,
	#classVars : [
		'FaceFlagCIDKeyed',
		'FaceFlagColor',
		'FaceFlagFixedSizes',
		'FaceFlagFixedWidth',
		'FaceFlagGlyphNames',
		'FaceFlagHinter',
		'FaceFlagHorizontal',
		'FaceFlagKerning',
		'FaceFlagMultipleMasters',
		'FaceFlagSBIX',
		'FaceFlagSBIXOverlay',
		'FaceFlagSFNT',
		'FaceFlagSVG',
		'FaceFlagScalable',
		'FaceFlagTricky',
		'FaceFlagVariation',
		'FaceFlagVertical',
		'StyleFlagBold',
		'StyleFlagItalic'
	],
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #initialization }
AeFTConstants class >> initialize [

	"See https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_style_flag_xxx"
	StyleFlagItalic := 1.	"FT_STYLE_FLAG_ITALIC 	The face style is italic or oblique."
	StyleFlagBold := 2.	"FT_STYLE_FLAG_BOLD 		The face is bold."

	"See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_face_flag_xxx"
	FaceFlagScalable        := 1 <<  0. "FT_FACE_FLAG_SCALABLE          The face contains outline glyphs."
	FaceFlagFixedSizes      := 1 <<  1. "FT_FACE_FLAG_FIXED_SIZES       The face contains bitmap strikes."
	FaceFlagFixedWidth      := 1 <<  2. "FT_FACE_FLAG_FIXED_WIDTH       The face contains fixed-width characters (like Courier, Lucida, MonoType, etc.)."
	FaceFlagSFNT            := 1 <<  3. "FT_FACE_FLAG_SFNT              The face uses the SFNT storage scheme. For now, this means TrueType and OpenType."
	FaceFlagHorizontal      := 1 <<  4. "FT_FACE_FLAG_HORIZONTAL        The face contains horizontal glyph metrics. This should be set for all common formats."
	FaceFlagVertical        := 1 <<  5. "FT_FACE_FLAG_VERTICAL          The face contains vertical glyph metrics. This is only available in some formats, not all of them."
	FaceFlagKerning         := 1 <<  6. "FT_FACE_FLAG_KERNING           The face contains kerning information. If set, the kerning distance can be retrieved using the function FT_Get_Kerning."
	"FaceFlagFastGlyphs     := 1 <<  7.  FT_FACE_FLAG_FAST_GLYPHS       Deprecated."
	FaceFlagMultipleMasters := 1 <<  8. "FT_FACE_FLAG_MULTIPLE_MASTERS  The face contains multiple masters and is capable of interpolating between them."
	FaceFlagGlyphNames 			:= 1 <<  9. "FT_FACE_FLAG_GLYPH_NAMES       The face contains glyph names, which can be retrieved using FT_Get_Glyph_Name."
	"FaceFlagExternalStream := 1 << 10.  FT_FACE_FLAG_EXTERNAL_STREAM   Used internally by FreeType"
	FaceFlagHinter          := 1 << 11. "FT_FACE_FLAG_HINTER            The font driver has a hinting machine of its own."
	FaceFlagCIDKeyed        := 1 << 12. "FT_FACE_FLAG_CID_KEYED         The face is CID-keyed."
	FaceFlagTricky          := 1 << 13. "FT_FACE_FLAG_TRICKY            The face is 'tricky', this is, it always needs the font format's native hinting engine to get a reasonable result."
	FaceFlagColor           := 1 << 14. "FT_FACE_FLAG_COLOR             [Since 2.5.1] The face has color glyph tables."
	FaceFlagVariation       := 1 << 15. "FT_FACE_FLAG_VARIATION         [Since 2.9] Set if the current face (or named instance) has been altered"
	FaceFlagSVG             := 1 << 16. "FT_FACE_FLAG_SVG               [Since 2.12] The face has an ‘SVG ’ OpenType table."
	FaceFlagSBIX            := 1 << 17. "FT_FACE_FLAG_SBIX              [Since 2.12] The face has an ‘sbix’ OpenType table and outlines."
	FaceFlagSBIXOverlay     := 1 << 18. "FT_FACE_FLAG_SBIX_OVERLAY      [Since 2.12] The face has an ‘sbix’ OpenType table where outlines should be drawn on top of bitmap strikes."
	FaceFlagScalable        := 1 <<  0. "FT_FACE_FLAG_SCALABLE          The face contains outline glyphs."
	FaceFlagFixedSizes      := 1 <<  1. "FT_FACE_FLAG_FIXED_SIZES       The face contains bitmap strikes."
	FaceFlagFixedWidth      := 1 <<  2. "FT_FACE_FLAG_FIXED_WIDTH       The face contains fixed-width characters (like Courier, Lucida, MonoType, etc.)."
	FaceFlagSFNT            := 1 <<  3. "FT_FACE_FLAG_SFNT              The face uses the SFNT storage scheme. For now, this means TrueType and OpenType."
	FaceFlagHorizontal      := 1 <<  4. "FT_FACE_FLAG_HORIZONTAL        The face contains horizontal glyph metrics. This should be set for all common formats."
	FaceFlagVertical        := 1 <<  5. "FT_FACE_FLAG_VERTICAL          The face contains vertical glyph metrics. This is only available in some formats, not all of them."
	FaceFlagKerning         := 1 <<  6. "FT_FACE_FLAG_KERNING           The face contains kerning information. If set, the kerning distance can be retrieved using the function FT_Get_Kerning."
	"FaceFlagFastGlyphs     := 1 <<  7.  FT_FACE_FLAG_FAST_GLYPHS       Deprecated."
	FaceFlagMultipleMasters := 1 <<  8. "FT_FACE_FLAG_MULTIPLE_MASTERS  The face contains multiple masters and is capable of interpolating between them."
	FaceFlagGlyphNames 			:= 1 <<  9. "FT_FACE_FLAG_GLYPH_NAMES       The face contains glyph names, which can be retrieved using FT_Get_Glyph_Name."
	"FaceFlagExternalStream := 1 << 10.  FT_FACE_FLAG_EXTERNAL_STREAM   Used internally by FreeType"
	FaceFlagHinter          := 1 << 11. "FT_FACE_FLAG_HINTER            The font driver has a hinting machine of its own."
	FaceFlagCIDKeyed        := 1 << 12. "FT_FACE_FLAG_CID_KEYED         The face is CID-keyed."
	FaceFlagTricky          := 1 << 13. "FT_FACE_FLAG_TRICKY            The face is 'tricky', this is, it always needs the font format's native hinting engine to get a reasonable result."
	FaceFlagColor           := 1 << 14. "FT_FACE_FLAG_COLOR             [Since 2.5.1] The face has color glyph tables."
	FaceFlagVariation       := 1 << 15. "FT_FACE_FLAG_VARIATION         [Since 2.9] Set if the current face (or named instance) has been altered"
	FaceFlagSVG             := 1 << 16. "FT_FACE_FLAG_SVG               [Since 2.12] The face has an ‘SVG ’ OpenType table."
	FaceFlagSBIX            := 1 << 17. "FT_FACE_FLAG_SBIX              [Since 2.12] The face has an ‘sbix’ OpenType table and outlines."
	FaceFlagSBIXOverlay     := 1 << 18. "FT_FACE_FLAG_SBIX_OVERLAY      [Since 2.12] The face has an ‘sbix’ OpenType table where outlines should be drawn on top of bitmap strikes."

]
