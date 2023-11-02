"
I represent FFI bindings to `hb_ot_metrics_tag_t` enum: Metric tags corresponding to MVAR Value Tags.

* `HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER`: horizontal ascender.
* `HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER`: horizontal descender.
* `HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP`: horizontal line gap.
* `HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT`: horizontal clipping ascent.
* `HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT`: horizontal clipping descent.
* `HB_OT_METRICS_TAG_VERTICAL_ASCENDER`: vertical ascender.
* `HB_OT_METRICS_TAG_VERTICAL_DESCENDER`: vertical descender.
* `HB_OT_METRICS_TAG_VERTICAL_LINE_GAP`: vertical line gap.
* `HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE`: horizontal caret rise.
* `HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN`: horizontal caret run.
* `HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET`: horizontal caret offset.
* `HB_OT_METRICS_TAG_VERTICAL_CARET_RISE`: vertical caret rise.
* `HB_OT_METRICS_TAG_VERTICAL_CARET_RUN`: vertical caret run.
* `HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET`: vertical caret offset.
* `HB_OT_METRICS_TAG_X_HEIGHT`: x height.
* `HB_OT_METRICS_TAG_CAP_HEIGHT`: cap height.
* `HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE`: subscript em x size.
* `HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE`: subscript em y size.
* `HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET`: subscript em x offset.
* `HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET`: subscript em y offset.
* `HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE`: superscript em x size.
* `HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE`: superscript em y size.
* `HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET`: superscript em x offset.
* `HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET`: superscript em y offset.
* `HB_OT_METRICS_TAG_STRIKEOUT_SIZE`: strikeout size.
* `HB_OT_METRICS_TAG_STRIKEOUT_OFFSET`: strikeout offset.
* `HB_OT_METRICS_TAG_UNDERLINE_SIZE`: underline size.
* `HB_OT_METRICS_TAG_UNDERLINE_OFFSET`: underline offset.

See: https://harfbuzz.github.io/harfbuzz-hb-ot-metrics.html#hb-ot-metrics-tag-t
See: https://docs.microsoft.com/en-us/typography/opentype/spec/mvar#value-tags
"
Class {
	#name : #AeHbOpenTypeMetricsTag,
	#superclass : #AeHbTagEnumeration,
	#classVars : [
		'HB_OT_METRICS_TAG_CAP_HEIGHT',
		'HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER',
		'HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET',
		'HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE',
		'HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN',
		'HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT',
		'HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT',
		'HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER',
		'HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP',
		'HB_OT_METRICS_TAG_STRIKEOUT_OFFSET',
		'HB_OT_METRICS_TAG_STRIKEOUT_SIZE',
		'HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET',
		'HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE',
		'HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET',
		'HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE',
		'HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET',
		'HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE',
		'HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET',
		'HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE',
		'HB_OT_METRICS_TAG_UNDERLINE_OFFSET',
		'HB_OT_METRICS_TAG_UNDERLINE_SIZE',
		'HB_OT_METRICS_TAG_VERTICAL_ASCENDER',
		'HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET',
		'HB_OT_METRICS_TAG_VERTICAL_CARET_RISE',
		'HB_OT_METRICS_TAG_VERTICAL_CARET_RUN',
		'HB_OT_METRICS_TAG_VERTICAL_DESCENDER',
		'HB_OT_METRICS_TAG_VERTICAL_LINE_GAP',
		'HB_OT_METRICS_TAG_X_HEIGHT'
	],
	#category : #'Alexandrie-Harfbuzz-Enumerations'
}

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_CAP_HEIGHT [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_CAP_HEIGHT
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_STRIKEOUT_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_STRIKEOUT_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_STRIKEOUT_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_STRIKEOUT_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_UNDERLINE_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_UNDERLINE_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_UNDERLINE_SIZE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_UNDERLINE_SIZE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_ASCENDER [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_ASCENDER
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_CARET_RISE [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_CARET_RISE
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_CARET_RUN [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_CARET_RUN
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_DESCENDER [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_DESCENDER
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_VERTICAL_LINE_GAP [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_VERTICAL_LINE_GAP
]

{ #category : #'accessing enum' }
AeHbOpenTypeMetricsTag class >> HB_OT_METRICS_TAG_X_HEIGHT [
	"This method was automatically generated"
	^ HB_OT_METRICS_TAG_X_HEIGHT
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> allMetricTagsSelectors [
	"Answer all camelCased selectors that can be sent to me to get my enum items.
	
	Generated with: 
	AeHbOpenTypeMetricsTag classSide methods
		select: [ :each | each protocol endsWith: 'cased' ]
		thenCollect: [ :each | each selector ]"

	^ #( #capHeight #horizontalAscender #horizontalCaretOffset
	     #horizontalCaretRise #horizontalCaretRun #horizontalClippingAscent
	     #horizontalClippingDescent #horizontalDescender
	     #horizontalLineGap #strikeoutOffset #strikeoutSize
	     #subscriptEmXOffset #subscriptEmXSize #subscriptEmYOffset
	     #subscriptEmYSize #superscriptEmXOffset #superscriptEmXSize
	     #superscriptEmYOffset #superscriptEmYSize #underlineOffset
	     #underlineSize #verticalAscender #verticalCaretOffset
	     #verticalCaretRise #verticalCaretRun #verticalDescender
	     #verticalLineGap #xHeight )
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> capHeight [

	^ self HB_OT_METRICS_TAG_CAP_HEIGHT
]

{ #category : #'enum declaration' }
AeHbOpenTypeMetricsTag class >> enumDecl [

	^ #(
	HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER	 	1751216995
	HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER	 	1751413603
	HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP	 	1751934832
	HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT	 	1751346273
	HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT	 	1751346276
	HB_OT_METRICS_TAG_VERTICAL_ASCENDER	 	1986098019
	HB_OT_METRICS_TAG_VERTICAL_DESCENDER	 	1986294627
	HB_OT_METRICS_TAG_VERTICAL_LINE_GAP	 	1986815856
	HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE	 	1751347827
	HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN	 	1751347822
	HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET	 	1751347046
	HB_OT_METRICS_TAG_VERTICAL_CARET_RISE	 	1986228851
	HB_OT_METRICS_TAG_VERTICAL_CARET_RUN	 	1986228846
	HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET	 	1986228070
	HB_OT_METRICS_TAG_X_HEIGHT	 	2020108148
	HB_OT_METRICS_TAG_CAP_HEIGHT	 	1668311156
	HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE	 	1935833203
	HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE	 	1935833459
	HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET	 	1935833199
	HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET	 	1935833455
	HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE	 	1936750707
	HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE	 	1936750963
	HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET	 	1936750703
	HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET	 	1936750959
	HB_OT_METRICS_TAG_STRIKEOUT_SIZE	 	1937011315
	HB_OT_METRICS_TAG_STRIKEOUT_OFFSET	 	1937011311
	HB_OT_METRICS_TAG_UNDERLINE_SIZE	 	1970168947
	HB_OT_METRICS_TAG_UNDERLINE_OFFSET	 	1970168943
)
]

{ #category : #'enum declaration' }
AeHbOpenTypeMetricsTag class >> generateEnumDecl [
	<script>
	"Based on 'hb-ot-metrics.h' (Harfbuzz 8.2.0)."

	| pairsArray code |
	pairsArray := #( 
HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER		hasc
HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER	hdsc
HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP		hlgp
HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT	hcla
HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT	hcld
HB_OT_METRICS_TAG_VERTICAL_ASCENDER		vasc
HB_OT_METRICS_TAG_VERTICAL_DESCENDER		vdsc
HB_OT_METRICS_TAG_VERTICAL_LINE_GAP		vlgp
HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE	hcrs
HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN	hcrn
HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET	hcof
HB_OT_METRICS_TAG_VERTICAL_CARET_RISE		vcrs
HB_OT_METRICS_TAG_VERTICAL_CARET_RUN		vcrn
HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET	vcof
HB_OT_METRICS_TAG_X_HEIGHT			xhgt
HB_OT_METRICS_TAG_CAP_HEIGHT			cpht
HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE		sbxs
HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE		sbys
HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET	sbxo
HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET	sbyo
HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE	spxs
HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE	spys
HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET	spxo
HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET	spyo
HB_OT_METRICS_TAG_STRIKEOUT_SIZE		strs
HB_OT_METRICS_TAG_STRIKEOUT_OFFSET		stro
HB_OT_METRICS_TAG_UNDERLINE_SIZE		unds
HB_OT_METRICS_TAG_UNDERLINE_OFFSET		undo
	).

	code := String streamContents: [ :stream |

		stream nextPutAll: 'enumDecl

	^ #(
'.

		pairsArray pairsDo: [ :a :b |
			stream nextPutAll: ('	{1}	 	{2}' format: { a. b asHbTagInteger }); cr. ].

		stream nextPutAll: ')' ].

	self classSide compile: code.

	self rebuildEnumAccessors.

	pairsArray pairsDo: [ :a :b |
		self addClassVarNamed: a ].
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalAscender [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_ASCENDER
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalCaretOffset [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_CARET_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalCaretRise [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_CARET_RISE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalCaretRun [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_CARET_RUN
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalClippingAscent [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_ASCENT
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalClippingDescent [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_CLIPPING_DESCENT
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalDescender [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_DESCENDER
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> horizontalLineGap [

	^ self HB_OT_METRICS_TAG_HORIZONTAL_LINE_GAP
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> strikeoutOffset [

	^ self HB_OT_METRICS_TAG_STRIKEOUT_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> strikeoutSize [

	^ self HB_OT_METRICS_TAG_STRIKEOUT_SIZE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> subscriptEmXOffset [

	^ self HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> subscriptEmXSize [

	^ self HB_OT_METRICS_TAG_SUBSCRIPT_EM_X_SIZE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> subscriptEmYOffset [

	^ self HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> subscriptEmYSize [

	^ self HB_OT_METRICS_TAG_SUBSCRIPT_EM_Y_SIZE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> superscriptEmXOffset [

	^ self HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> superscriptEmXSize [

	^ self HB_OT_METRICS_TAG_SUPERSCRIPT_EM_X_SIZE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> superscriptEmYOffset [

	^ self HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> superscriptEmYSize [

	^ self HB_OT_METRICS_TAG_SUPERSCRIPT_EM_Y_SIZE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> underlineOffset [

	^ self HB_OT_METRICS_TAG_UNDERLINE_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> underlineSize [

	^ self HB_OT_METRICS_TAG_UNDERLINE_SIZE
]

{ #category : #hook }
AeHbOpenTypeMetricsTag class >> underlinedNamePrefix [
	
	^ 'HB_OT_METRICS_TAG_'
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalAscender [

	^ self HB_OT_METRICS_TAG_VERTICAL_ASCENDER
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalCaretOffset [

	^ self HB_OT_METRICS_TAG_VERTICAL_CARET_OFFSET
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalCaretRise [

	^ self HB_OT_METRICS_TAG_VERTICAL_CARET_RISE
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalCaretRun [

	^ self HB_OT_METRICS_TAG_VERTICAL_CARET_RUN
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalDescender [

	^ self HB_OT_METRICS_TAG_VERTICAL_DESCENDER
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> verticalLineGap [

	^ self HB_OT_METRICS_TAG_VERTICAL_LINE_GAP
]

{ #category : #'accessing enum camelcased' }
AeHbOpenTypeMetricsTag class >> xHeight [

	^ self HB_OT_METRICS_TAG_X_HEIGHT
]
