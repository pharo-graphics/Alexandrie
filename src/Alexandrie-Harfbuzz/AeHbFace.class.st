"
I represent FFI bindings to `hb_face_t`: Font face objects.

A font face is an object that represents a single face from within a font family.

More precisely, a font face represents a single face in a binary font file. Font faces are typically built from a binary blob and a face index. Font faces are used to create fonts.

See: https://harfbuzz.github.io/harfbuzz-hb-face.html
"
Class {
	#name : #AeHbFace,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFace class >> externallyFree: aHandle [

	self ffiCall: #( void hb_face_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbFace class >> newForBlob: blob index: index [

	^ (self unownedNewForBlob: blob index: index)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> newForFTFaceCached: ft_face [

	^ (self unownedNewForFTFaceCached: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> newForFTFaceReferenced: ft_face [

	^ (self unownedNewForFTFaceReferenced: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForBlob: blob index: index [
	"Constructs a new face object from the specified blob and a face index into that blob.

	The face index is used for blobs of file formats such as TTC and and DFont that can contain more than one face. Face indices within such collections are zero-based.

	See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-create"

	^ self ffiCall: #(
		hb_face_t *
		hb_face_create (
			hb_blob_t blob,
			uint index)
		)
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForFTFaceCached: ft_face [
	"Creates an `hb_face_t` face object from the specified `FT_Face`.

	This variant of the function caches the newly created `hb_face_t` face object, using the generic pointer of `ft_face`.
	Subsequent function calls that are passed the same `ft_face` parameter will have the same `hb_face_t` returned to them, and that `hb_face_t` will be correctly reference counted.

	However, client programs are still responsible for destroying `ft_face` after the last `hb_face_t` face object has been destroyed.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-face-create-cached"

	^ self ffiCall: #(
		hb_face_t
		hb_ft_face_create_cached (AeFTFace * ft_face)
		)
]

{ #category : #'instance creation' }
AeHbFace class >> unownedNewForFTFaceReferenced: ft_face [
	"Creates an `hb_face_t` face object from the specified `FT_Face`.

	This is the preferred variant of the `hb_ft_font_create`* function family, because it calls `FT_Reference_Face()` on ft_face , ensuring that ft_face remains alive as long as the resulting `hb_font_t` font object remains alive.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-create-referenced"

	^ self ffiCall: #(
		hb_face_t
		hb_ft_face_create_referenced (AeFTFace * ft_face)
		)
]

{ #category : #accessing }
AeHbFace >> glyphCount [
	"See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-get-glyph-count"

	^ self ffiCall: #(
		uint
		hb_face_get_glyph_count ( self ) )
]

{ #category : #accessing }
AeHbFace >> hasColor [
	"Answer whether this font can have colors.
	
	Based on helper_cairo_scaled_font_has_color function in harfbuzz/util/helper-cairo.hh"

	^ self hasPng or: [ self hasLayers or: [ self hasPaint ] ]
]

{ #category : #accessing }
AeHbFace >> hasLayers [
	"Answer whether this face includes a COLR table with data according to COLRv0.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-layers"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_layers ( self ) )
]

{ #category : #accessing }
AeHbFace >> hasPaint [
	"Answer whether this face includes a COLR table with data according to COLRv1.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-paint"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_paint ( self ) )
]

{ #category : #accessing }
AeHbFace >> hasPng [
	"Answer whether this face has PNG glyph images (either in CBDT or sbix tables).
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-color.html#hb-ot-color-has-png"

	^ self ffiCall: #(
		Boolean
		hb_ot_color_has_png ( self ) )
]

{ #category : #accessing }
AeHbFace >> newHbFont [
	"Answer a new `AeHbFont` from me"

	^ AeHbFont newForHbFace: self
]

{ #category : #accessing }
AeHbFace >> unitsPerEm [
	"Answer my units-per-em (UPEM) value.

	Typical UPEM values for fonts are 1000, or 2048, but any value in between 16 and 16,384 is allowed for OpenType fonts.

	See: https://harfbuzz.github.io/harfbuzz-hb-face.html#hb-face-get-upem"

	^ self ffiCall: #(
		uint
		hb_face_get_upem ( self ) )
]
