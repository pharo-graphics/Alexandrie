"
I am a FreeType FFI binding to `FT_FACE_FLAG_XXX` bit flags.

These flags are used in the `face_flags` field of the `FT_FaceRec` structure. They inform client applications of properties of the corresponding face.

See: https://freetype.org/freetype2/docs/reference/ft2-base_interface.html#ft_face_flag_xxx
"
Class {
	#name : #AeFTFaceFlag,
	#superclass : #AeEnumeration,
	#classVars : [
		'FT_FACE_FLAG_CID_KEYED',
		'FT_FACE_FLAG_COLOR',
		'FT_FACE_FLAG_FIXED_SIZES',
		'FT_FACE_FLAG_FIXED_WIDTH',
		'FT_FACE_FLAG_GLYPH_NAMES',
		'FT_FACE_FLAG_HINTER',
		'FT_FACE_FLAG_HORIZONTAL',
		'FT_FACE_FLAG_KERNING',
		'FT_FACE_FLAG_MULTIPLE_MASTERS',
		'FT_FACE_FLAG_SBIX',
		'FT_FACE_FLAG_SBIX_OVERLAY',
		'FT_FACE_FLAG_SCALABLE',
		'FT_FACE_FLAG_SFNT',
		'FT_FACE_FLAG_SVG',
		'FT_FACE_FLAG_TRICKY',
		'FT_FACE_FLAG_VARIATION',
		'FT_FACE_FLAG_VERTICAL'
	],
	#category : #'Alexandrie-FreeType'
}

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_CID_KEYED [
	"This method was automatically generated"
	^ FT_FACE_FLAG_CID_KEYED
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_COLOR [
	"This method was automatically generated"
	^ FT_FACE_FLAG_COLOR
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_FIXED_SIZES [
	"This method was automatically generated"
	^ FT_FACE_FLAG_FIXED_SIZES
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_FIXED_WIDTH [
	"This method was automatically generated"
	^ FT_FACE_FLAG_FIXED_WIDTH
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_GLYPH_NAMES [
	"This method was automatically generated"
	^ FT_FACE_FLAG_GLYPH_NAMES
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_HINTER [
	"This method was automatically generated"
	^ FT_FACE_FLAG_HINTER
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_HORIZONTAL [
	"This method was automatically generated"
	^ FT_FACE_FLAG_HORIZONTAL
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_KERNING [
	"This method was automatically generated"
	^ FT_FACE_FLAG_KERNING
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_MULTIPLE_MASTERS [
	"This method was automatically generated"
	^ FT_FACE_FLAG_MULTIPLE_MASTERS
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_SBIX [
	"This method was automatically generated"
	^ FT_FACE_FLAG_SBIX
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_SBIX_OVERLAY [
	"This method was automatically generated"
	^ FT_FACE_FLAG_SBIX_OVERLAY
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_SCALABLE [
	"This method was automatically generated"
	^ FT_FACE_FLAG_SCALABLE
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_SFNT [
	"This method was automatically generated"
	^ FT_FACE_FLAG_SFNT
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_SVG [
	"This method was automatically generated"
	^ FT_FACE_FLAG_SVG
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_TRICKY [
	"This method was automatically generated"
	^ FT_FACE_FLAG_TRICKY
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_VARIATION [
	"This method was automatically generated"
	^ FT_FACE_FLAG_VARIATION
]

{ #category : #'accessing enum' }
AeFTFaceFlag class >> FT_FACE_FLAG_VERTICAL [
	"This method was automatically generated"
	^ FT_FACE_FLAG_VERTICAL
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> cidKeyed [

	^ self FT_FACE_FLAG_CID_KEYED
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> color [

	^ self FT_FACE_FLAG_COLOR
]

{ #category : #'enum declaration' }
AeFTFaceFlag class >> enumDecl [
	"
	self rebuildEnumAccessors
	"

	^ {
		#FT_FACE_FLAG_SCALABLE. 			1 <<  0. "The face contains outline glyphs."
		#FT_FACE_FLAG_FIXED_SIZES. 		1 <<  1. "The face contains bitmap strikes."
		#FT_FACE_FLAG_FIXED_WIDTH.			1 <<  2. "The face contains fixed-width characters (like Courier, Lucida, MonoType, etc.)."
		#FT_FACE_FLAG_SFNT. 					1 <<  3. "The face uses the SFNT storage scheme. For now, this means TrueType and OpenType."
		#FT_FACE_FLAG_HORIZONTAL. 			1 <<  4. "The face contains horizontal glyph metrics. This should be set for all common formats."
		#FT_FACE_FLAG_VERTICAL. 			1 <<  5. "The face contains vertical glyph metrics. This is only available in some formats, not all of them."
		#FT_FACE_FLAG_KERNING. 				1 <<  6. "The face contains kerning information. If set, the kerning distance can be retrieved using the function FT_Get_Kerning."
		"#FT_FACE_FLAG_FAST_GLYPHS. 		1 <<  7.  Deprecated."
		#FT_FACE_FLAG_MULTIPLE_MASTERS. 	1 <<  8. "The face contains multiple masters and is capable of interpolating between them."
		#FT_FACE_FLAG_GLYPH_NAMES. 		1 <<  9. "The face contains glyph names, which can be retrieved using FT_Get_Glyph_Name."
		"#FT_FACE_FLAG_EXTERNAL_STREAM. 	1 << 10.  Used internally by FreeType"
		#FT_FACE_FLAG_HINTER. 				1 << 11. "The font driver has a hinting machine of its own."
		#FT_FACE_FLAG_CID_KEYED. 			1 << 12. "The face is CID-keyed."
		#FT_FACE_FLAG_TRICKY. 				1 << 13. "The face is 'tricky', this is, it always needs the font format's native hinting engine to get a reasonable result."
		#FT_FACE_FLAG_COLOR. 				1 << 14. "[Since 2.5.1] The face has color glyph tables."
		#FT_FACE_FLAG_VARIATION. 			1 << 15. "[Since 2.9] Set if the current face (or named instance) has been altered"
		#FT_FACE_FLAG_SVG. 					1 << 16. "[Since 2.12] The face has an ‘SVG ’ OpenType table."
		#FT_FACE_FLAG_SBIX. 					1 << 17. "[Since 2.12] The face has an ‘sbix’ OpenType table and outlines."
		#FT_FACE_FLAG_SBIX_OVERLAY. 		1 << 18. "[Since 2.12] The face has an ‘sbix’ OpenType table where outlines should be drawn on top of bitmap strikes."
	}
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> fixedSizes [

	^ self FT_FACE_FLAG_FIXED_SIZES
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> fixedWidth [

	^ self FT_FACE_FLAG_FIXED_WIDTH
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> glyphNames [

	^ self FT_FACE_FLAG_GLYPH_NAMES
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> hinter [

	^ self FT_FACE_FLAG_HINTER
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> horizontal [

	^ self FT_FACE_FLAG_HORIZONTAL
]

{ #category : #'enum declaration' }
AeFTFaceFlag class >> initialize [

	self initializeEnumeration
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> kerning [

	^ self FT_FACE_FLAG_KERNING
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> multipleMasters [

	^ self FT_FACE_FLAG_MULTIPLE_MASTERS
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> sbix [

	^ self FT_FACE_FLAG_SBIX
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> sbixOverlay [

	^ self FT_FACE_FLAG_SBIX_OVERLAY
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> scalable [

	^ self FT_FACE_FLAG_SCALABLE
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> sfnt [

	^ self FT_FACE_FLAG_SFNT
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> svg [

	^ self FT_FACE_FLAG_SVG
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> tricky [

	^ self FT_FACE_FLAG_TRICKY
]

{ #category : #hook }
AeFTFaceFlag class >> underlinedNamePrefix [
	
	^ 'FT_FACE_FLAG'
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> variation [

	^ self FT_FACE_FLAG_VARIATION
]

{ #category : #'accessing enum camelcased' }
AeFTFaceFlag class >> vertical [

	^ self FT_FACE_FLAG_VERTICAL
]
