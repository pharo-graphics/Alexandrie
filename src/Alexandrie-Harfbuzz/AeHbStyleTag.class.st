"
I represent FFI bindings to `hb_style_tag_t` enum: Defined by OpenType Design-Variation Axis Tag Registry.

Members:
* `HB_STYLE_TAG_ITALIC`: Used to vary between non-italic and italic. A value of 0 can be interpreted as ""Roman"" (non-italic); a value of 1 can be interpreted as (fully) italic.
* `HB_STYLE_TAG_OPTICAL_SIZE`: Used to vary design to suit different text sizes. Non-zero. Values can be interpreted as text size, in points.
* `HB_STYLE_TAG_SLANT_ANGLE`: Used to vary between upright and slanted text. Values must be greater than -90 and less than +90. Values can be interpreted as the angle, in counter-clockwise degrees, of oblique slant from whatever the designer considers to be upright for that font design. Typical right-leaning Italic fonts have a negative slant angle (typically around -12)
* `HB_STYLE_TAG_SLANT_RATIO`: same as `HB_STYLE_TAG_SLANT_ANGLE` expression as ratio. Typical right-leaning Italic fonts have a positive slant ratio (typically around 0.2)
* `HB_STYLE_TAG_WIDTH`: Used to vary width of text from narrower to wider. Non-zero. Values can be interpreted as a percentage of whatever the font designer considers “normal width” for that font design.
* `HB_STYLE_TAG_WEIGHT`: Used to vary stroke thicknesses or other design details to give variation from lighter to blacker. Values can be interpreted in direct comparison to values for usWeightClass in the OS/2 table, or the CSS font-weight property.

See: https://harfbuzz.github.io/harfbuzz-hb-style.html#hb-style-tag-t
See: https://docs.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg
"
Class {
	#name : 'AeHbStyleTag',
	#superclass : 'AeHbTagEnumeration',
	#classVars : [
		'HB_STYLE_TAG_ITALIC',
		'HB_STYLE_TAG_OPTICAL_SIZE',
		'HB_STYLE_TAG_SLANT_ANGLE',
		'HB_STYLE_TAG_SLANT_RATIO',
		'HB_STYLE_TAG_WEIGHT',
		'HB_STYLE_TAG_WIDTH'
	],
	#category : 'Alexandrie-Harfbuzz-Enumerations',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Enumerations'
}

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_ITALIC [
	"This method was automatically generated"
	^ HB_STYLE_TAG_ITALIC
]

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_OPTICAL_SIZE [
	"This method was automatically generated"
	^ HB_STYLE_TAG_OPTICAL_SIZE
]

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_SLANT_ANGLE [
	"This method was automatically generated"
	^ HB_STYLE_TAG_SLANT_ANGLE
]

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_SLANT_RATIO [
	"This method was automatically generated"
	^ HB_STYLE_TAG_SLANT_RATIO
]

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_WEIGHT [
	"This method was automatically generated"
	^ HB_STYLE_TAG_WEIGHT
]

{ #category : 'accessing enum' }
AeHbStyleTag class >> HB_STYLE_TAG_WIDTH [
	"This method was automatically generated"
	^ HB_STYLE_TAG_WIDTH
]

{ #category : 'enum declaration' }
AeHbStyleTag class >> enumDecl [

	^ #(
	HB_STYLE_TAG_ITALIC	 	1769234796
	HB_STYLE_TAG_OPTICAL_SIZE	 	1869640570
	HB_STYLE_TAG_SLANT_ANGLE	 	1936486004
	HB_STYLE_TAG_SLANT_RATIO	 	1399615092
	HB_STYLE_TAG_WIDTH	 	2003072104
	HB_STYLE_TAG_WEIGHT	 	2003265652
)
]

{ #category : 'enum declaration' }
AeHbStyleTag class >> generateEnumDecl [
	<script>
	"Based on 'hb-style.h' (Harfbuzz 8.2.0)."

	| pairsArray code |
	pairsArray := #(
HB_STYLE_TAG_ITALIC		  ital  
HB_STYLE_TAG_OPTICAL_SIZE	  opsz  
HB_STYLE_TAG_SLANT_ANGLE	  slnt  
HB_STYLE_TAG_SLANT_RATIO	  Slnt  
HB_STYLE_TAG_WIDTH		  wdth  
HB_STYLE_TAG_WEIGHT		  wght  
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

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> italic [

	^ self HB_STYLE_TAG_ITALIC
]

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> opticalSize [

	^ self HB_STYLE_TAG_OPTICAL_SIZE
]

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> slantAngle [

	^ self HB_STYLE_TAG_SLANT_ANGLE
]

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> slantRatio [

	^ self HB_STYLE_TAG_SLANT_RATIO
]

{ #category : 'hook' }
AeHbStyleTag class >> underlinedNamePrefix [
	
	^ 'HB_STYLE_TAG_'
]

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> weight [

	^ self HB_STYLE_TAG_WEIGHT
]

{ #category : 'accessing enum camelcased' }
AeHbStyleTag class >> width [

	^ self HB_STYLE_TAG_WIDTH
]
