"
I represent FFI bindings to `hb_font_t`: Font objects.

A font object represents a font face at a specific size and with certain other parameters (pixels-per-em, points-per-em, variation settings) specified. Font objects are created from font face objects, and are used as input to `hb_shape()`, among other things.

See: https://harfbuzz.github.io/harfbuzz-hb-font.html
"
Class {
	#name : #AeHbFont,
	#superclass : #FFIExternalObject,
	#traits : 'AeTHarfbuzzLibrary + AeTExternalFree',
	#classTraits : 'AeTHarfbuzzLibrary classTrait + AeTExternalFree classTrait',
	#pools : [
		'AeHbTypes'
	],
	#category : #'Alexandrie-Harfbuzz-Core'
}

{ #category : #finalization }
AeHbFont class >> externallyFree: aHandle [

	self ffiCall: #( void hb_font_destroy ( void * aHandle ) )
]

{ #category : #'instance creation' }
AeHbFont class >> newForFTFaceReferenced: ft_face [

	^ (self unownedNewFTFaceReferenced: ft_face)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFont class >> newForHbFace: anHbFace [
	"Answer a new font from the specified `AeHbFace` instance."

	^ (self unownedNewForHbFace: anHbFace)
		  autoRelease;
		  yourself
]

{ #category : #'instance creation' }
AeHbFont class >> unownedNewFTFaceReferenced: aFTFace [
	"Answer a new instance from a `AeFTFace`.

	Precondition: The received face must already have the size set.

	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-create-referenced"

	^ self ffiCall: #(
		hb_font_t
		hb_ft_font_create_referenced (AeFTFace * aFTFace)
	)
]

{ #category : #'instance creation' }
AeHbFont class >> unownedNewForHbFace: anHbFace [
	"Answer a new font from the specified `AeHbFace` instance.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-create"

	^ self ffiCall: #(
		hb_font_t 
		hb_font_create (hb_face_t anHbFace)
		)
]

{ #category : #metrics }
AeHbFont >> allMetricsAsDictionary [

	| result |
	result := OrderedDictionary new.
	
	AeHbOpenTypeMetricsTag allValues do: [ :each |
		result at: each item put: (self positionWithFallback: each) ].

	^ result 
]

{ #category : #accessing }
AeHbFont >> face [
	"Answer my associated face.

	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-face"

	^ self ffiCall: #( AeHbFace hb_font_get_face ( self ) )
]

{ #category : #accessing }
AeHbFont >> getPointsPerEmIntoX: xAddress y: yAddress [
	"Fetches the horizontal and vertical points-per-em (ppem) of this font.
	
	Zero values means unset.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-ppem"

	self ffiCall: #(
		void
		hb_font_get_ppem (
			self,
			uint *xAddress,
			uint *yAddress ) )
]

{ #category : #metrics }
AeHbFont >> getPositionWithFallback: metricsTag into: positionAddress [
	"Fetches metrics value corresponding to a tag, and synthesizes a value if it the value is missing in this font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-metrics.html#hb-ot-metrics-get-position-with-fallback"

	self ffiCall: #(
		void
		hb_ot_metrics_get_position_with_fallback (
			self,
			AeHbOpenTypeMetricsTag metricsTag,
			int32 * positionAddress ) )
]

{ #category : #accessing }
AeHbFont >> getScaleIntoX: xAddress y: yAddress [
	"Fetches the horizontal and vertical scale of this font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-scale"

	self ffiCall: #(
		void
		hb_font_get_scale (
			self,
			int *xAddress,
			int *yAddress ) )
]

{ #category : #accessing }
AeHbFont >> italic [

	^ self styleValueAt: AeHbStyleTag italic

]

{ #category : #concurrency }
AeHbFont >> lock [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-lock-face"
	
	^ self ffiCall: #(
		AeFTFace *
		hb_ft_font_lock_face ( self ) )
]

{ #category : #accessing }
AeHbFont >> opticalSize [

	^ self styleValueAt: AeHbStyleTag opticalSize

]

{ #category : #accessing }
AeHbFont >> pointSize [
	"Fetches the 'point size' of a font. Zero means unset value.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-ptem"

	^ self ffiCall: #( float hb_font_get_ptem ( self ) )
]

{ #category : #accessing }
AeHbFont >> pointSize: ptem [
	"Sets the 'point size' of a font. Set to zero to unset.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-set-ptem"

	self ffiCall: #(
		void
		hb_font_set_ptem (
			self,
			float ptem ) )
]

{ #category : #accessing }
AeHbFont >> pointsPerEm [
	"Fetches the horizontal and vertical points-per-em (ppem) of this font.
	
	Zero values means unset.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-ppem"

	| xAddress yAddress |
	xAddress := FFIInt32 newBuffer.
	yAddress := FFIInt32 newBuffer.

	self getPointsPerEmIntoX: xAddress y: yAddress.

	^ (xAddress int32AtOffset: 0) @ (yAddress int32AtOffset: 0)
]

{ #category : #accessing }
AeHbFont >> positionWithFallback: metricsTag [
	"Fetches metrics value corresponding to a tag, and synthesizes a value if it the value is missing in this font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ot-metrics.html#hb-ot-metrics-get-position-with-fallback"

	| positionAddress |
	positionAddress := FFIInt32 newBuffer.

	self
		getPositionWithFallback: metricsTag
		into: positionAddress.

	^ (positionAddress int32AtOffset: 0) from26Dot6FractionalPoint
]

{ #category : #printing }
AeHbFont >> printOn: aStream [

	| myFace |
	self isNull ifTrue: [ ^ super printOn: aStream ].

	myFace := self face.
	aStream
		nextPutAll: 'an ';
		nextPutAll: self className;
		nextPutAll: '(';
		nextPutAll: myFace openTypeFontFamily;
		nextPutAll: ', ';
		nextPutAll: myFace openTypeFontSubfamily;
		nextPutAll: ', ';
		print: self scale;
		nextPutAll: ')'
]

{ #category : #refreshing }
AeHbFont >> refreshOnFTFontChanged [
	"Refreshes the state of font when the underlying `FT_Face` has changed.
	
	This function should be called after changing the size or variation-axis settings on the `FT_Face`.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-changed"

	self ffiCall: #(
		void
		hb_ft_font_changed ( self ) )
]

{ #category : #refreshing }
AeHbFont >> refreshOnHbFontChanged [
	"Refreshes the state of the underlying `FT_Face` of font when the `hb_font_t` font has changed. 

	Answer true if changed, false otherwise.
	
	This function should be called after changing the size or variation-axis settings on the font. 
	This call is fast if nothing has changed on font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-hb-font-changed"

	^ self ffiCall: #(
		hb_bool_t
		hb_ft_hb_font_changed ( self ) )
]

{ #category : #accessing }
AeHbFont >> scale [
	"Answer the horizontal and vertical scale of this font.
	
	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-get-scale"

	| xAddress yAddress |
	xAddress := FFIInt32 newBuffer.
	yAddress := FFIInt32 newBuffer.

	self getScaleIntoX: xAddress y: yAddress.

	^ Point
		x: (xAddress int32AtOffset: 0)
		y: (yAddress int32AtOffset: 0)
]

{ #category : #accessing }
AeHbFont >> scale: aPoint [
	"Sets the horizontal and vertical scale of this font.

	The font scale is a number related to, but not the same as, font size.
	
	Fonts default to a scale equal to the UPEM value of their face. A font with this setting is sometimes called an 'unscaled' font."

	self scaleX: aPoint x y: aPoint y
]

{ #category : #accessing }
AeHbFont >> scaleX: x y: y [
	"Sets the horizontal and vertical scale of this font.

	The font scale is a number related to, but not the same as, font size.
	
	Fonts default to a scale equal to the UPEM value of their face. A font with this setting is sometimes called an 'unscaled' font.

	See: https://harfbuzz.github.io/harfbuzz-hb-font.html#hb-font-set-scale"

	self ffiCall: #(
		void
		hb_font_set_scale (
			self,
			int x,
			int y ) )
]

{ #category : #accessing }
AeHbFont >> slantAngle [

	^ self styleValueAt: AeHbStyleTag slantAngle
]

{ #category : #accessing }
AeHbFont >> slantRatio [

	^ self styleValueAt: AeHbStyleTag slantRatio

]

{ #category : #metrics }
AeHbFont >> strikeoutOffset [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag strikeoutOffset
]

{ #category : #metrics }
AeHbFont >> strikeoutSize [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag strikeoutSize
]

{ #category : #accessing }
AeHbFont >> styleValueAt: styleTag [
	"Answer style information from fonts.

	See: https://harfbuzz.github.io/harfbuzz-hb-style.html#hb-style-get-value"

	^ self ffiCall: #(
		float
		hb_style_get_value (
			self,
			AeHbStyleTag styleTag) )
]

{ #category : #metrics }
AeHbFont >> underlineOffset [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag underlineOffset
]

{ #category : #metrics }
AeHbFont >> underlineSize [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag underlineSize
]

{ #category : #concurrency }
AeHbFont >> unlock [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ft.html#hb-ft-font-unlock-face"
	
	self ffiCall: #(
		void
		hb_ft_font_unlock_face ( self ) )
]

{ #category : #metrics }
AeHbFont >> verticalAscender [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag verticalAscender
]

{ #category : #metrics }
AeHbFont >> verticalDescender [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag verticalDescender
]

{ #category : #metrics }
AeHbFont >> verticalLineGap [

	^ self positionWithFallback: AeHbOpenTypeMetricsTag verticalLineGap
]

{ #category : #accessing }
AeHbFont >> weight [

	^ self styleValueAt: AeHbStyleTag weight
]

{ #category : #accessing }
AeHbFont >> width [

	^ self styleValueAt: AeHbStyleTag width
]
