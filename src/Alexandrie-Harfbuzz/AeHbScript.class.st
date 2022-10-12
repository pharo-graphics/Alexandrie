"
I represent FFI bindings to `hb_script_t` enum: Data type for scripts.

Each value is a hash from the four-letter values defined by [ISO 15924](https://unicode.org/iso15924/).

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-script-t

"
Class {
	#name : #AeHbScript,
	#superclass : #FFIEnumeration,
	#classVars : [
		'HB_SCRIPT_ADLAM',
		'HB_SCRIPT_AHOM',
		'HB_SCRIPT_ANATOLIAN_HIEROGLYPHS',
		'HB_SCRIPT_ARABIC',
		'HB_SCRIPT_ARMENIAN',
		'HB_SCRIPT_AVESTAN',
		'HB_SCRIPT_BALINESE',
		'HB_SCRIPT_BAMUM',
		'HB_SCRIPT_BASSA_VAH',
		'HB_SCRIPT_BATAK',
		'HB_SCRIPT_BENGALI',
		'HB_SCRIPT_BHAIKSUKI',
		'HB_SCRIPT_BOPOMOFO',
		'HB_SCRIPT_BRAHMI',
		'HB_SCRIPT_BRAILLE',
		'HB_SCRIPT_BUGINESE',
		'HB_SCRIPT_BUHID',
		'HB_SCRIPT_CANADIAN_SYLLABICS',
		'HB_SCRIPT_CARIAN',
		'HB_SCRIPT_CAUCASIAN_ALBANIAN',
		'HB_SCRIPT_CHAKMA',
		'HB_SCRIPT_CHAM',
		'HB_SCRIPT_CHEROKEE',
		'HB_SCRIPT_CHORASMIAN',
		'HB_SCRIPT_COMMON',
		'HB_SCRIPT_COPTIC',
		'HB_SCRIPT_CUNEIFORM',
		'HB_SCRIPT_CYPRIOT',
		'HB_SCRIPT_CYPRO_MINOAN',
		'HB_SCRIPT_CYRILLIC',
		'HB_SCRIPT_DESERET',
		'HB_SCRIPT_DEVANAGARI',
		'HB_SCRIPT_DIVES_AKURU',
		'HB_SCRIPT_DOGRA',
		'HB_SCRIPT_DUPLOYAN',
		'HB_SCRIPT_EGYPTIAN_HIEROGLYPHS',
		'HB_SCRIPT_ELBASAN',
		'HB_SCRIPT_ELYMAIC',
		'HB_SCRIPT_ETHIOPIC',
		'HB_SCRIPT_GEORGIAN',
		'HB_SCRIPT_GLAGOLITIC',
		'HB_SCRIPT_GOTHIC',
		'HB_SCRIPT_GRANTHA',
		'HB_SCRIPT_GREEK',
		'HB_SCRIPT_GUJARATI',
		'HB_SCRIPT_GUNJALA_GONDI',
		'HB_SCRIPT_GURMUKHI',
		'HB_SCRIPT_HAN',
		'HB_SCRIPT_HANGUL',
		'HB_SCRIPT_HANIFI_ROHINGYA',
		'HB_SCRIPT_HANUNOO',
		'HB_SCRIPT_HATRAN',
		'HB_SCRIPT_HEBREW',
		'HB_SCRIPT_HIRAGANA',
		'HB_SCRIPT_IMPERIAL_ARAMAIC',
		'HB_SCRIPT_INHERITED',
		'HB_SCRIPT_INSCRIPTIONAL_PAHLAVI',
		'HB_SCRIPT_INSCRIPTIONAL_PARTHIAN',
		'HB_SCRIPT_INVALID',
		'HB_SCRIPT_JAVANESE',
		'HB_SCRIPT_KAITHI',
		'HB_SCRIPT_KANNADA',
		'HB_SCRIPT_KATAKANA',
		'HB_SCRIPT_KAYAH_LI',
		'HB_SCRIPT_KHAROSHTHI',
		'HB_SCRIPT_KHITAN_SMALL_SCRIPT',
		'HB_SCRIPT_KHMER',
		'HB_SCRIPT_KHOJKI',
		'HB_SCRIPT_KHUDAWADI',
		'HB_SCRIPT_LAO',
		'HB_SCRIPT_LATIN',
		'HB_SCRIPT_LEPCHA',
		'HB_SCRIPT_LIMBU',
		'HB_SCRIPT_LINEAR_A',
		'HB_SCRIPT_LINEAR_B',
		'HB_SCRIPT_LISU',
		'HB_SCRIPT_LYCIAN',
		'HB_SCRIPT_LYDIAN',
		'HB_SCRIPT_MAHAJANI',
		'HB_SCRIPT_MAKASAR',
		'HB_SCRIPT_MALAYALAM',
		'HB_SCRIPT_MANDAIC',
		'HB_SCRIPT_MANICHAEAN',
		'HB_SCRIPT_MARCHEN',
		'HB_SCRIPT_MASARAM_GONDI',
		'HB_SCRIPT_MATH',
		'HB_SCRIPT_MEDEFAIDRIN',
		'HB_SCRIPT_MEETEI_MAYEK',
		'HB_SCRIPT_MENDE_KIKAKUI',
		'HB_SCRIPT_MEROITIC_CURSIVE',
		'HB_SCRIPT_MEROITIC_HIEROGLYPHS',
		'HB_SCRIPT_MIAO',
		'HB_SCRIPT_MODI',
		'HB_SCRIPT_MONGOLIAN',
		'HB_SCRIPT_MRO',
		'HB_SCRIPT_MULTANI',
		'HB_SCRIPT_MYANMAR',
		'HB_SCRIPT_NABATAEAN',
		'HB_SCRIPT_NANDINAGARI',
		'HB_SCRIPT_NEWA',
		'HB_SCRIPT_NEW_TAI_LUE',
		'HB_SCRIPT_NKO',
		'HB_SCRIPT_NUSHU',
		'HB_SCRIPT_NYIAKENG_PUACHUE_HMONG',
		'HB_SCRIPT_OGHAM',
		'HB_SCRIPT_OLD_HUNGARIAN',
		'HB_SCRIPT_OLD_ITALIC',
		'HB_SCRIPT_OLD_NORTH_ARABIAN',
		'HB_SCRIPT_OLD_PERMIC',
		'HB_SCRIPT_OLD_PERSIAN',
		'HB_SCRIPT_OLD_SOGDIAN',
		'HB_SCRIPT_OLD_SOUTH_ARABIAN',
		'HB_SCRIPT_OLD_TURKIC',
		'HB_SCRIPT_OLD_UYGHUR',
		'HB_SCRIPT_OL_CHIKI',
		'HB_SCRIPT_ORIYA',
		'HB_SCRIPT_OSAGE',
		'HB_SCRIPT_OSMANYA',
		'HB_SCRIPT_PAHAWH_HMONG',
		'HB_SCRIPT_PALMYRENE',
		'HB_SCRIPT_PAU_CIN_HAU',
		'HB_SCRIPT_PHAGS_PA',
		'HB_SCRIPT_PHOENICIAN',
		'HB_SCRIPT_PSALTER_PAHLAVI',
		'HB_SCRIPT_REJANG',
		'HB_SCRIPT_RUNIC',
		'HB_SCRIPT_SAMARITAN',
		'HB_SCRIPT_SAURASHTRA',
		'HB_SCRIPT_SHARADA',
		'HB_SCRIPT_SHAVIAN',
		'HB_SCRIPT_SIDDHAM',
		'HB_SCRIPT_SIGNWRITING',
		'HB_SCRIPT_SINHALA',
		'HB_SCRIPT_SOGDIAN',
		'HB_SCRIPT_SORA_SOMPENG',
		'HB_SCRIPT_SOYOMBO',
		'HB_SCRIPT_SUNDANESE',
		'HB_SCRIPT_SYLOTI_NAGRI',
		'HB_SCRIPT_SYRIAC',
		'HB_SCRIPT_TAGALOG',
		'HB_SCRIPT_TAGBANWA',
		'HB_SCRIPT_TAI_LE',
		'HB_SCRIPT_TAI_THAM',
		'HB_SCRIPT_TAI_VIET',
		'HB_SCRIPT_TAKRI',
		'HB_SCRIPT_TAMIL',
		'HB_SCRIPT_TANGSA',
		'HB_SCRIPT_TANGUT',
		'HB_SCRIPT_TELUGU',
		'HB_SCRIPT_THAANA',
		'HB_SCRIPT_THAI',
		'HB_SCRIPT_TIBETAN',
		'HB_SCRIPT_TIFINAGH',
		'HB_SCRIPT_TIRHUTA',
		'HB_SCRIPT_TOTO',
		'HB_SCRIPT_UGARITIC',
		'HB_SCRIPT_UNKNOWN',
		'HB_SCRIPT_VAI',
		'HB_SCRIPT_VITHKUQI',
		'HB_SCRIPT_WANCHO',
		'HB_SCRIPT_WARANG_CITI',
		'HB_SCRIPT_YEZIDI',
		'HB_SCRIPT_YI',
		'HB_SCRIPT_ZANABAZAR_SQUARE'
	],
	#category : #'Alexandrie-Harfbuzz-Enumerations'
}

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ADLAM [
	"This method was automatically generated"
	^ HB_SCRIPT_ADLAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_AHOM [
	"This method was automatically generated"
	^ HB_SCRIPT_AHOM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ANATOLIAN_HIEROGLYPHS [
	"This method was automatically generated"
	^ HB_SCRIPT_ANATOLIAN_HIEROGLYPHS
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ARABIC [
	"This method was automatically generated"
	^ HB_SCRIPT_ARABIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ARMENIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_ARMENIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_AVESTAN [
	"This method was automatically generated"
	^ HB_SCRIPT_AVESTAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BALINESE [
	"This method was automatically generated"
	^ HB_SCRIPT_BALINESE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BAMUM [
	"This method was automatically generated"
	^ HB_SCRIPT_BAMUM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BASSA_VAH [
	"This method was automatically generated"
	^ HB_SCRIPT_BASSA_VAH
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BATAK [
	"This method was automatically generated"
	^ HB_SCRIPT_BATAK
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BENGALI [
	"This method was automatically generated"
	^ HB_SCRIPT_BENGALI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BHAIKSUKI [
	"This method was automatically generated"
	^ HB_SCRIPT_BHAIKSUKI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BOPOMOFO [
	"This method was automatically generated"
	^ HB_SCRIPT_BOPOMOFO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BRAHMI [
	"This method was automatically generated"
	^ HB_SCRIPT_BRAHMI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BRAILLE [
	"This method was automatically generated"
	^ HB_SCRIPT_BRAILLE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BUGINESE [
	"This method was automatically generated"
	^ HB_SCRIPT_BUGINESE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_BUHID [
	"This method was automatically generated"
	^ HB_SCRIPT_BUHID
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CANADIAN_SYLLABICS [
	"This method was automatically generated"
	^ HB_SCRIPT_CANADIAN_SYLLABICS
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CARIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_CARIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CAUCASIAN_ALBANIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_CAUCASIAN_ALBANIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CHAKMA [
	"This method was automatically generated"
	^ HB_SCRIPT_CHAKMA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CHAM [
	"This method was automatically generated"
	^ HB_SCRIPT_CHAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CHEROKEE [
	"This method was automatically generated"
	^ HB_SCRIPT_CHEROKEE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CHORASMIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_CHORASMIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_COMMON [
	"This method was automatically generated"
	^ HB_SCRIPT_COMMON
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_COPTIC [
	"This method was automatically generated"
	^ HB_SCRIPT_COPTIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CUNEIFORM [
	"This method was automatically generated"
	^ HB_SCRIPT_CUNEIFORM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CYPRIOT [
	"This method was automatically generated"
	^ HB_SCRIPT_CYPRIOT
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CYPRO_MINOAN [
	"This method was automatically generated"
	^ HB_SCRIPT_CYPRO_MINOAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_CYRILLIC [
	"This method was automatically generated"
	^ HB_SCRIPT_CYRILLIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_DESERET [
	"This method was automatically generated"
	^ HB_SCRIPT_DESERET
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_DEVANAGARI [
	"This method was automatically generated"
	^ HB_SCRIPT_DEVANAGARI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_DIVES_AKURU [
	"This method was automatically generated"
	^ HB_SCRIPT_DIVES_AKURU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_DOGRA [
	"This method was automatically generated"
	^ HB_SCRIPT_DOGRA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_DUPLOYAN [
	"This method was automatically generated"
	^ HB_SCRIPT_DUPLOYAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_EGYPTIAN_HIEROGLYPHS [
	"This method was automatically generated"
	^ HB_SCRIPT_EGYPTIAN_HIEROGLYPHS
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ELBASAN [
	"This method was automatically generated"
	^ HB_SCRIPT_ELBASAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ELYMAIC [
	"This method was automatically generated"
	^ HB_SCRIPT_ELYMAIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ETHIOPIC [
	"This method was automatically generated"
	^ HB_SCRIPT_ETHIOPIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GEORGIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_GEORGIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GLAGOLITIC [
	"This method was automatically generated"
	^ HB_SCRIPT_GLAGOLITIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GOTHIC [
	"This method was automatically generated"
	^ HB_SCRIPT_GOTHIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GRANTHA [
	"This method was automatically generated"
	^ HB_SCRIPT_GRANTHA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GREEK [
	"This method was automatically generated"
	^ HB_SCRIPT_GREEK
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GUJARATI [
	"This method was automatically generated"
	^ HB_SCRIPT_GUJARATI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GUNJALA_GONDI [
	"This method was automatically generated"
	^ HB_SCRIPT_GUNJALA_GONDI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_GURMUKHI [
	"This method was automatically generated"
	^ HB_SCRIPT_GURMUKHI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HAN [
	"This method was automatically generated"
	^ HB_SCRIPT_HAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HANGUL [
	"This method was automatically generated"
	^ HB_SCRIPT_HANGUL
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HANIFI_ROHINGYA [
	"This method was automatically generated"
	^ HB_SCRIPT_HANIFI_ROHINGYA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HANUNOO [
	"This method was automatically generated"
	^ HB_SCRIPT_HANUNOO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HATRAN [
	"This method was automatically generated"
	^ HB_SCRIPT_HATRAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HEBREW [
	"This method was automatically generated"
	^ HB_SCRIPT_HEBREW
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_HIRAGANA [
	"This method was automatically generated"
	^ HB_SCRIPT_HIRAGANA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_IMPERIAL_ARAMAIC [
	"This method was automatically generated"
	^ HB_SCRIPT_IMPERIAL_ARAMAIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_INHERITED [
	"This method was automatically generated"
	^ HB_SCRIPT_INHERITED
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_INSCRIPTIONAL_PAHLAVI [
	"This method was automatically generated"
	^ HB_SCRIPT_INSCRIPTIONAL_PAHLAVI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_INSCRIPTIONAL_PARTHIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_INSCRIPTIONAL_PARTHIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_INVALID [
	"This method was automatically generated"
	^ HB_SCRIPT_INVALID
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_JAVANESE [
	"This method was automatically generated"
	^ HB_SCRIPT_JAVANESE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KAITHI [
	"This method was automatically generated"
	^ HB_SCRIPT_KAITHI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KANNADA [
	"This method was automatically generated"
	^ HB_SCRIPT_KANNADA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KATAKANA [
	"This method was automatically generated"
	^ HB_SCRIPT_KATAKANA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KAYAH_LI [
	"This method was automatically generated"
	^ HB_SCRIPT_KAYAH_LI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KHAROSHTHI [
	"This method was automatically generated"
	^ HB_SCRIPT_KHAROSHTHI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KHITAN_SMALL_SCRIPT [
	"This method was automatically generated"
	^ HB_SCRIPT_KHITAN_SMALL_SCRIPT
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KHMER [
	"This method was automatically generated"
	^ HB_SCRIPT_KHMER
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KHOJKI [
	"This method was automatically generated"
	^ HB_SCRIPT_KHOJKI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_KHUDAWADI [
	"This method was automatically generated"
	^ HB_SCRIPT_KHUDAWADI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LAO [
	"This method was automatically generated"
	^ HB_SCRIPT_LAO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LATIN [
	"This method was automatically generated"
	^ HB_SCRIPT_LATIN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LEPCHA [
	"This method was automatically generated"
	^ HB_SCRIPT_LEPCHA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LIMBU [
	"This method was automatically generated"
	^ HB_SCRIPT_LIMBU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LINEAR_A [
	"This method was automatically generated"
	^ HB_SCRIPT_LINEAR_A
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LINEAR_B [
	"This method was automatically generated"
	^ HB_SCRIPT_LINEAR_B
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LISU [
	"This method was automatically generated"
	^ HB_SCRIPT_LISU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LYCIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_LYCIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_LYDIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_LYDIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MAHAJANI [
	"This method was automatically generated"
	^ HB_SCRIPT_MAHAJANI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MAKASAR [
	"This method was automatically generated"
	^ HB_SCRIPT_MAKASAR
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MALAYALAM [
	"This method was automatically generated"
	^ HB_SCRIPT_MALAYALAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MANDAIC [
	"This method was automatically generated"
	^ HB_SCRIPT_MANDAIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MANICHAEAN [
	"This method was automatically generated"
	^ HB_SCRIPT_MANICHAEAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MARCHEN [
	"This method was automatically generated"
	^ HB_SCRIPT_MARCHEN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MASARAM_GONDI [
	"This method was automatically generated"
	^ HB_SCRIPT_MASARAM_GONDI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MATH [
	"This method was automatically generated"
	^ HB_SCRIPT_MATH
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MEDEFAIDRIN [
	"This method was automatically generated"
	^ HB_SCRIPT_MEDEFAIDRIN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MEETEI_MAYEK [
	"This method was automatically generated"
	^ HB_SCRIPT_MEETEI_MAYEK
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MENDE_KIKAKUI [
	"This method was automatically generated"
	^ HB_SCRIPT_MENDE_KIKAKUI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MEROITIC_CURSIVE [
	"This method was automatically generated"
	^ HB_SCRIPT_MEROITIC_CURSIVE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MEROITIC_HIEROGLYPHS [
	"This method was automatically generated"
	^ HB_SCRIPT_MEROITIC_HIEROGLYPHS
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MIAO [
	"This method was automatically generated"
	^ HB_SCRIPT_MIAO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MODI [
	"This method was automatically generated"
	^ HB_SCRIPT_MODI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MONGOLIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_MONGOLIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MRO [
	"This method was automatically generated"
	^ HB_SCRIPT_MRO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MULTANI [
	"This method was automatically generated"
	^ HB_SCRIPT_MULTANI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_MYANMAR [
	"This method was automatically generated"
	^ HB_SCRIPT_MYANMAR
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NABATAEAN [
	"This method was automatically generated"
	^ HB_SCRIPT_NABATAEAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NANDINAGARI [
	"This method was automatically generated"
	^ HB_SCRIPT_NANDINAGARI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NEWA [
	"This method was automatically generated"
	^ HB_SCRIPT_NEWA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NEW_TAI_LUE [
	"This method was automatically generated"
	^ HB_SCRIPT_NEW_TAI_LUE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NKO [
	"This method was automatically generated"
	^ HB_SCRIPT_NKO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NUSHU [
	"This method was automatically generated"
	^ HB_SCRIPT_NUSHU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_NYIAKENG_PUACHUE_HMONG [
	"This method was automatically generated"
	^ HB_SCRIPT_NYIAKENG_PUACHUE_HMONG
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OGHAM [
	"This method was automatically generated"
	^ HB_SCRIPT_OGHAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_HUNGARIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_HUNGARIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_ITALIC [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_ITALIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_NORTH_ARABIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_NORTH_ARABIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_PERMIC [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_PERMIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_PERSIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_PERSIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_SOGDIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_SOGDIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_SOUTH_ARABIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_SOUTH_ARABIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_TURKIC [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_TURKIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OLD_UYGHUR [
	"This method was automatically generated"
	^ HB_SCRIPT_OLD_UYGHUR
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OL_CHIKI [
	"This method was automatically generated"
	^ HB_SCRIPT_OL_CHIKI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ORIYA [
	"This method was automatically generated"
	^ HB_SCRIPT_ORIYA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OSAGE [
	"This method was automatically generated"
	^ HB_SCRIPT_OSAGE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_OSMANYA [
	"This method was automatically generated"
	^ HB_SCRIPT_OSMANYA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PAHAWH_HMONG [
	"This method was automatically generated"
	^ HB_SCRIPT_PAHAWH_HMONG
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PALMYRENE [
	"This method was automatically generated"
	^ HB_SCRIPT_PALMYRENE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PAU_CIN_HAU [
	"This method was automatically generated"
	^ HB_SCRIPT_PAU_CIN_HAU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PHAGS_PA [
	"This method was automatically generated"
	^ HB_SCRIPT_PHAGS_PA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PHOENICIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_PHOENICIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_PSALTER_PAHLAVI [
	"This method was automatically generated"
	^ HB_SCRIPT_PSALTER_PAHLAVI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_REJANG [
	"This method was automatically generated"
	^ HB_SCRIPT_REJANG
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_RUNIC [
	"This method was automatically generated"
	^ HB_SCRIPT_RUNIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SAMARITAN [
	"This method was automatically generated"
	^ HB_SCRIPT_SAMARITAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SAURASHTRA [
	"This method was automatically generated"
	^ HB_SCRIPT_SAURASHTRA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SHARADA [
	"This method was automatically generated"
	^ HB_SCRIPT_SHARADA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SHAVIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_SHAVIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SIDDHAM [
	"This method was automatically generated"
	^ HB_SCRIPT_SIDDHAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SIGNWRITING [
	"This method was automatically generated"
	^ HB_SCRIPT_SIGNWRITING
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SINHALA [
	"This method was automatically generated"
	^ HB_SCRIPT_SINHALA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SOGDIAN [
	"This method was automatically generated"
	^ HB_SCRIPT_SOGDIAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SORA_SOMPENG [
	"This method was automatically generated"
	^ HB_SCRIPT_SORA_SOMPENG
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SOYOMBO [
	"This method was automatically generated"
	^ HB_SCRIPT_SOYOMBO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SUNDANESE [
	"This method was automatically generated"
	^ HB_SCRIPT_SUNDANESE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SYLOTI_NAGRI [
	"This method was automatically generated"
	^ HB_SCRIPT_SYLOTI_NAGRI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_SYRIAC [
	"This method was automatically generated"
	^ HB_SCRIPT_SYRIAC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAGALOG [
	"This method was automatically generated"
	^ HB_SCRIPT_TAGALOG
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAGBANWA [
	"This method was automatically generated"
	^ HB_SCRIPT_TAGBANWA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAI_LE [
	"This method was automatically generated"
	^ HB_SCRIPT_TAI_LE
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAI_THAM [
	"This method was automatically generated"
	^ HB_SCRIPT_TAI_THAM
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAI_VIET [
	"This method was automatically generated"
	^ HB_SCRIPT_TAI_VIET
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAKRI [
	"This method was automatically generated"
	^ HB_SCRIPT_TAKRI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TAMIL [
	"This method was automatically generated"
	^ HB_SCRIPT_TAMIL
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TANGSA [
	"This method was automatically generated"
	^ HB_SCRIPT_TANGSA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TANGUT [
	"This method was automatically generated"
	^ HB_SCRIPT_TANGUT
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TELUGU [
	"This method was automatically generated"
	^ HB_SCRIPT_TELUGU
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_THAANA [
	"This method was automatically generated"
	^ HB_SCRIPT_THAANA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_THAI [
	"This method was automatically generated"
	^ HB_SCRIPT_THAI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TIBETAN [
	"This method was automatically generated"
	^ HB_SCRIPT_TIBETAN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TIFINAGH [
	"This method was automatically generated"
	^ HB_SCRIPT_TIFINAGH
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TIRHUTA [
	"This method was automatically generated"
	^ HB_SCRIPT_TIRHUTA
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_TOTO [
	"This method was automatically generated"
	^ HB_SCRIPT_TOTO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_UGARITIC [
	"This method was automatically generated"
	^ HB_SCRIPT_UGARITIC
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_UNKNOWN [
	"This method was automatically generated"
	^ HB_SCRIPT_UNKNOWN
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_VAI [
	"This method was automatically generated"
	^ HB_SCRIPT_VAI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_VITHKUQI [
	"This method was automatically generated"
	^ HB_SCRIPT_VITHKUQI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_WANCHO [
	"This method was automatically generated"
	^ HB_SCRIPT_WANCHO
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_WARANG_CITI [
	"This method was automatically generated"
	^ HB_SCRIPT_WARANG_CITI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_YEZIDI [
	"This method was automatically generated"
	^ HB_SCRIPT_YEZIDI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_YI [
	"This method was automatically generated"
	^ HB_SCRIPT_YI
]

{ #category : #'accessing enum' }
AeHbScript class >> HB_SCRIPT_ZANABAZAR_SQUARE [
	"This method was automatically generated"
	^ HB_SCRIPT_ZANABAZAR_SQUARE
]

{ #category : #'enum declaration' }
AeHbScript class >> enumDecl [

	^ #(
	HB_SCRIPT_COMMON	 	1517910393
	HB_SCRIPT_INHERITED	 	1516858984
	HB_SCRIPT_UNKNOWN	 	1517976186
	HB_SCRIPT_ARABIC	 	1098015074
	HB_SCRIPT_ARMENIAN	 	1098018158
	HB_SCRIPT_BENGALI	 	1113943655
	HB_SCRIPT_CYRILLIC	 	1132032620
	HB_SCRIPT_DEVANAGARI	 	1147500129
	HB_SCRIPT_GEORGIAN	 	1197830002
	HB_SCRIPT_GREEK	 	1198679403
	HB_SCRIPT_GUJARATI	 	1198877298
	HB_SCRIPT_GURMUKHI	 	1198879349
	HB_SCRIPT_HANGUL	 	1214344807
	HB_SCRIPT_HAN	 	1214344809
	HB_SCRIPT_HEBREW	 	1214603890
	HB_SCRIPT_HIRAGANA	 	1214870113
	HB_SCRIPT_KANNADA	 	1265525857
	HB_SCRIPT_KATAKANA	 	1264676449
	HB_SCRIPT_LAO	 	1281453935
	HB_SCRIPT_LATIN	 	1281455214
	HB_SCRIPT_MALAYALAM	 	1298954605
	HB_SCRIPT_ORIYA	 	1332902241
	HB_SCRIPT_TAMIL	 	1415671148
	HB_SCRIPT_TELUGU	 	1415933045
	HB_SCRIPT_THAI	 	1416126825
	HB_SCRIPT_TIBETAN	 	1416192628
	HB_SCRIPT_BOPOMOFO	 	1114599535
	HB_SCRIPT_BRAILLE	 	1114792297
	HB_SCRIPT_CANADIAN_SYLLABICS	 	1130458739
	HB_SCRIPT_CHEROKEE	 	1130915186
	HB_SCRIPT_ETHIOPIC	 	1165256809
	HB_SCRIPT_KHMER	 	1265134962
	HB_SCRIPT_MONGOLIAN	 	1299148391
	HB_SCRIPT_MYANMAR	 	1299803506
	HB_SCRIPT_OGHAM	 	1332175213
	HB_SCRIPT_RUNIC	 	1383427698
	HB_SCRIPT_SINHALA	 	1399418472
	HB_SCRIPT_SYRIAC	 	1400468067
	HB_SCRIPT_THAANA	 	1416126817
	HB_SCRIPT_YI	 	1500080489
	HB_SCRIPT_DESERET	 	1148416628
	HB_SCRIPT_GOTHIC	 	1198486632
	HB_SCRIPT_OLD_ITALIC	 	1232363884
	HB_SCRIPT_BUHID	 	1114990692
	HB_SCRIPT_HANUNOO	 	1214344815
	HB_SCRIPT_TAGALOG	 	1416064103
	HB_SCRIPT_TAGBANWA	 	1415669602
	HB_SCRIPT_CYPRIOT	 	1131442804
	HB_SCRIPT_LIMBU	 	1281977698
	HB_SCRIPT_LINEAR_B	 	1281977954
	HB_SCRIPT_OSMANYA	 	1332964705
	HB_SCRIPT_SHAVIAN	 	1399349623
	HB_SCRIPT_TAI_LE	 	1415670885
	HB_SCRIPT_UGARITIC	 	1432838514
	HB_SCRIPT_BUGINESE	 	1114990441
	HB_SCRIPT_COPTIC	 	1131376756
	HB_SCRIPT_GLAGOLITIC	 	1198285159
	HB_SCRIPT_KHAROSHTHI	 	1265131890
	HB_SCRIPT_NEW_TAI_LUE	 	1415670901
	HB_SCRIPT_OLD_PERSIAN	 	1483761007
	HB_SCRIPT_SYLOTI_NAGRI	 	1400466543
	HB_SCRIPT_TIFINAGH	 	1415999079
	HB_SCRIPT_BALINESE	 	1113681001
	HB_SCRIPT_CUNEIFORM	 	1483961720
	HB_SCRIPT_NKO	 	1315663727
	HB_SCRIPT_PHAGS_PA	 	1349017959
	HB_SCRIPT_PHOENICIAN	 	1349021304
	HB_SCRIPT_CARIAN	 	1130459753
	HB_SCRIPT_CHAM	 	1130914157
	HB_SCRIPT_KAYAH_LI	 	1264675945
	HB_SCRIPT_LEPCHA	 	1281716323
	HB_SCRIPT_LYCIAN	 	1283023721
	HB_SCRIPT_LYDIAN	 	1283023977
	HB_SCRIPT_OL_CHIKI	 	1332503403
	HB_SCRIPT_REJANG	 	1382706791
	HB_SCRIPT_SAURASHTRA	 	1398895986
	HB_SCRIPT_SUNDANESE	 	1400204900
	HB_SCRIPT_VAI	 	1449224553
	HB_SCRIPT_AVESTAN	 	1098281844
	HB_SCRIPT_BAMUM	 	1113681269
	HB_SCRIPT_EGYPTIAN_HIEROGLYPHS	 	1164409200
	HB_SCRIPT_IMPERIAL_ARAMAIC	 	1098018153
	HB_SCRIPT_INSCRIPTIONAL_PAHLAVI	 	1349020777
	HB_SCRIPT_INSCRIPTIONAL_PARTHIAN	 	1349678185
	HB_SCRIPT_JAVANESE	 	1247901281
	HB_SCRIPT_KAITHI	 	1265920105
	HB_SCRIPT_LISU	 	1281979253
	HB_SCRIPT_MEETEI_MAYEK	 	1299473769
	HB_SCRIPT_OLD_SOUTH_ARABIAN	 	1398895202
	HB_SCRIPT_OLD_TURKIC	 	1332898664
	HB_SCRIPT_SAMARITAN	 	1398893938
	HB_SCRIPT_TAI_THAM	 	1281453665
	HB_SCRIPT_TAI_VIET	 	1415673460
	HB_SCRIPT_BATAK	 	1113683051
	HB_SCRIPT_BRAHMI	 	1114792296
	HB_SCRIPT_MANDAIC	 	1298230884
	HB_SCRIPT_CHAKMA	 	1130457965
	HB_SCRIPT_MEROITIC_CURSIVE	 	1298494051
	HB_SCRIPT_MEROITIC_HIEROGLYPHS	 	1298494063
	HB_SCRIPT_MIAO	 	1349284452
	HB_SCRIPT_SHARADA	 	1399353956
	HB_SCRIPT_SORA_SOMPENG	 	1399812705
	HB_SCRIPT_TAKRI	 	1415670642
	HB_SCRIPT_BASSA_VAH	 	1113682803
	HB_SCRIPT_CAUCASIAN_ALBANIAN	 	1097295970
	HB_SCRIPT_DUPLOYAN	 	1148547180
	HB_SCRIPT_ELBASAN	 	1164730977
	HB_SCRIPT_GRANTHA	 	1198678382
	HB_SCRIPT_KHOJKI	 	1265135466
	HB_SCRIPT_KHUDAWADI	 	1399418468
	HB_SCRIPT_LINEAR_A	 	1281977953
	HB_SCRIPT_MAHAJANI	 	1298229354
	HB_SCRIPT_MANICHAEAN	 	1298230889
	HB_SCRIPT_MENDE_KIKAKUI	 	1298493028
	HB_SCRIPT_MODI	 	1299145833
	HB_SCRIPT_MRO	 	1299345263
	HB_SCRIPT_NABATAEAN	 	1315070324
	HB_SCRIPT_OLD_NORTH_ARABIAN	 	1315009122
	HB_SCRIPT_OLD_PERMIC	 	1348825709
	HB_SCRIPT_PAHAWH_HMONG	 	1215131239
	HB_SCRIPT_PALMYRENE	 	1348562029
	HB_SCRIPT_PAU_CIN_HAU	 	1348564323
	HB_SCRIPT_PSALTER_PAHLAVI	 	1349020784
	HB_SCRIPT_SIDDHAM	 	1399415908
	HB_SCRIPT_TIRHUTA	 	1416196712
	HB_SCRIPT_WARANG_CITI	 	1466004065
	HB_SCRIPT_AHOM	 	1097363309
	HB_SCRIPT_ANATOLIAN_HIEROGLYPHS	 	1215067511
	HB_SCRIPT_HATRAN	 	1214346354
	HB_SCRIPT_MULTANI	 	1299541108
	HB_SCRIPT_OLD_HUNGARIAN	 	1215655527
	HB_SCRIPT_SIGNWRITING	 	1399287415
	HB_SCRIPT_ADLAM	 	1097100397
	HB_SCRIPT_BHAIKSUKI	 	1114139507
	HB_SCRIPT_MARCHEN	 	1298231907
	HB_SCRIPT_OSAGE	 	1332963173
	HB_SCRIPT_TANGUT	 	1415671399
	HB_SCRIPT_NEWA	 	1315272545
	HB_SCRIPT_MASARAM_GONDI	 	1198485101
	HB_SCRIPT_NUSHU	 	1316186229
	HB_SCRIPT_SOYOMBO	 	1399814511
	HB_SCRIPT_ZANABAZAR_SQUARE	 	1516334690
	HB_SCRIPT_DOGRA	 	1148151666
	HB_SCRIPT_GUNJALA_GONDI	 	1198485095
	HB_SCRIPT_HANIFI_ROHINGYA	 	1383032935
	HB_SCRIPT_MAKASAR	 	1298230113
	HB_SCRIPT_MEDEFAIDRIN	 	1298490470
	HB_SCRIPT_OLD_SOGDIAN	 	1399809903
	HB_SCRIPT_SOGDIAN	 	1399809892
	HB_SCRIPT_ELYMAIC	 	1164736877
	HB_SCRIPT_NANDINAGARI	 	1315008100
	HB_SCRIPT_NYIAKENG_PUACHUE_HMONG	 	1215131248
	HB_SCRIPT_WANCHO	 	1466132591
	HB_SCRIPT_CHORASMIAN	 	1130918515
	HB_SCRIPT_DIVES_AKURU	 	1147756907
	HB_SCRIPT_KHITAN_SMALL_SCRIPT	 	1265202291
	HB_SCRIPT_YEZIDI	 	1499822697
	HB_SCRIPT_CYPRO_MINOAN	 	1131441518
	HB_SCRIPT_OLD_UYGHUR	 	1333094258
	HB_SCRIPT_TANGSA	 	1416524641
	HB_SCRIPT_TOTO	 	1416590447
	HB_SCRIPT_VITHKUQI	 	1449751656
	HB_SCRIPT_MATH	 	1517122664
	HB_SCRIPT_INVALID 0)
]

{ #category : #'enum declaration' }
AeHbScript class >> generateEnumDecl [
	<script>
	"Based on 'hb-common.h' (Harfbuzz 5.1.0)."

	| pairsArray code |
	pairsArray := #( 
HB_SCRIPT_COMMON Zyyy
HB_SCRIPT_INHERITED Zinh
HB_SCRIPT_UNKNOWN Zzzz
HB_SCRIPT_ARABIC Arab
HB_SCRIPT_ARMENIAN Armn
HB_SCRIPT_BENGALI Beng
HB_SCRIPT_CYRILLIC Cyrl
HB_SCRIPT_DEVANAGARI Deva
HB_SCRIPT_GEORGIAN Geor
HB_SCRIPT_GREEK Grek
HB_SCRIPT_GUJARATI Gujr
HB_SCRIPT_GURMUKHI Guru
HB_SCRIPT_HANGUL Hang
HB_SCRIPT_HAN Hani
HB_SCRIPT_HEBREW Hebr
HB_SCRIPT_HIRAGANA Hira
HB_SCRIPT_KANNADA Knda
HB_SCRIPT_KATAKANA Kana
HB_SCRIPT_LAO Laoo
HB_SCRIPT_LATIN Latn
HB_SCRIPT_MALAYALAM Mlym
HB_SCRIPT_ORIYA Orya
HB_SCRIPT_TAMIL Taml
HB_SCRIPT_TELUGU Telu
HB_SCRIPT_THAI Thai
HB_SCRIPT_TIBETAN Tibt
HB_SCRIPT_BOPOMOFO Bopo
HB_SCRIPT_BRAILLE Brai
HB_SCRIPT_CANADIAN_SYLLABICS Cans
HB_SCRIPT_CHEROKEE Cher
HB_SCRIPT_ETHIOPIC Ethi
HB_SCRIPT_KHMER Khmr
HB_SCRIPT_MONGOLIAN Mong
HB_SCRIPT_MYANMAR Mymr
HB_SCRIPT_OGHAM Ogam
HB_SCRIPT_RUNIC Runr
HB_SCRIPT_SINHALA Sinh
HB_SCRIPT_SYRIAC Syrc
HB_SCRIPT_THAANA Thaa
HB_SCRIPT_YI Yiii
HB_SCRIPT_DESERET Dsrt
HB_SCRIPT_GOTHIC Goth
HB_SCRIPT_OLD_ITALIC Ital
HB_SCRIPT_BUHID Buhd
HB_SCRIPT_HANUNOO Hano
HB_SCRIPT_TAGALOG Tglg
HB_SCRIPT_TAGBANWA Tagb
HB_SCRIPT_CYPRIOT Cprt
HB_SCRIPT_LIMBU Limb
HB_SCRIPT_LINEAR_B Linb
HB_SCRIPT_OSMANYA Osma
HB_SCRIPT_SHAVIAN Shaw
HB_SCRIPT_TAI_LE Tale
HB_SCRIPT_UGARITIC Ugar
HB_SCRIPT_BUGINESE Bugi
HB_SCRIPT_COPTIC Copt
HB_SCRIPT_GLAGOLITIC Glag
HB_SCRIPT_KHAROSHTHI Khar
HB_SCRIPT_NEW_TAI_LUE Talu
HB_SCRIPT_OLD_PERSIAN Xpeo
HB_SCRIPT_SYLOTI_NAGRI Sylo
HB_SCRIPT_TIFINAGH Tfng
HB_SCRIPT_BALINESE Bali
HB_SCRIPT_CUNEIFORM Xsux
HB_SCRIPT_NKO Nkoo
HB_SCRIPT_PHAGS_PA Phag
HB_SCRIPT_PHOENICIAN Phnx
HB_SCRIPT_CARIAN Cari
HB_SCRIPT_CHAM Cham
HB_SCRIPT_KAYAH_LI Kali
HB_SCRIPT_LEPCHA Lepc
HB_SCRIPT_LYCIAN Lyci
HB_SCRIPT_LYDIAN Lydi
HB_SCRIPT_OL_CHIKI Olck
HB_SCRIPT_REJANG Rjng
HB_SCRIPT_SAURASHTRA Saur
HB_SCRIPT_SUNDANESE Sund
HB_SCRIPT_VAI Vaii
HB_SCRIPT_AVESTAN Avst
HB_SCRIPT_BAMUM Bamu
HB_SCRIPT_EGYPTIAN_HIEROGLYPHS Egyp
HB_SCRIPT_IMPERIAL_ARAMAIC Armi
HB_SCRIPT_INSCRIPTIONAL_PAHLAVI Phli
HB_SCRIPT_INSCRIPTIONAL_PARTHIAN Prti
HB_SCRIPT_JAVANESE Java
HB_SCRIPT_KAITHI Kthi
HB_SCRIPT_LISU Lisu
HB_SCRIPT_MEETEI_MAYEK Mtei
HB_SCRIPT_OLD_SOUTH_ARABIAN Sarb
HB_SCRIPT_OLD_TURKIC Orkh
HB_SCRIPT_SAMARITAN Samr
HB_SCRIPT_TAI_THAM Lana
HB_SCRIPT_TAI_VIET Tavt
HB_SCRIPT_BATAK Batk
HB_SCRIPT_BRAHMI Brah
HB_SCRIPT_MANDAIC Mand
HB_SCRIPT_CHAKMA Cakm
HB_SCRIPT_MEROITIC_CURSIVE Merc
HB_SCRIPT_MEROITIC_HIEROGLYPHS Mero
HB_SCRIPT_MIAO Plrd
HB_SCRIPT_SHARADA Shrd
HB_SCRIPT_SORA_SOMPENG Sora
HB_SCRIPT_TAKRI Takr
HB_SCRIPT_BASSA_VAH Bass
HB_SCRIPT_CAUCASIAN_ALBANIAN Aghb
HB_SCRIPT_DUPLOYAN Dupl
HB_SCRIPT_ELBASAN Elba
HB_SCRIPT_GRANTHA Gran
HB_SCRIPT_KHOJKI Khoj
HB_SCRIPT_KHUDAWADI Sind
HB_SCRIPT_LINEAR_A Lina
HB_SCRIPT_MAHAJANI Mahj
HB_SCRIPT_MANICHAEAN Mani
HB_SCRIPT_MENDE_KIKAKUI Mend
HB_SCRIPT_MODI Modi
HB_SCRIPT_MRO Mroo
HB_SCRIPT_NABATAEAN Nbat
HB_SCRIPT_OLD_NORTH_ARABIAN Narb
HB_SCRIPT_OLD_PERMIC Perm
HB_SCRIPT_PAHAWH_HMONG Hmng
HB_SCRIPT_PALMYRENE Palm
HB_SCRIPT_PAU_CIN_HAU Pauc
HB_SCRIPT_PSALTER_PAHLAVI Phlp
HB_SCRIPT_SIDDHAM Sidd
HB_SCRIPT_TIRHUTA Tirh
HB_SCRIPT_WARANG_CITI Wara
HB_SCRIPT_AHOM Ahom
HB_SCRIPT_ANATOLIAN_HIEROGLYPHS Hluw
HB_SCRIPT_HATRAN Hatr
HB_SCRIPT_MULTANI Mult
HB_SCRIPT_OLD_HUNGARIAN Hung
HB_SCRIPT_SIGNWRITING Sgnw
HB_SCRIPT_ADLAM Adlm
HB_SCRIPT_BHAIKSUKI Bhks
HB_SCRIPT_MARCHEN Marc
HB_SCRIPT_OSAGE Osge
HB_SCRIPT_TANGUT Tang
HB_SCRIPT_NEWA Newa
HB_SCRIPT_MASARAM_GONDI Gonm
HB_SCRIPT_NUSHU Nshu
HB_SCRIPT_SOYOMBO Soyo
HB_SCRIPT_ZANABAZAR_SQUARE Zanb
HB_SCRIPT_DOGRA Dogr
HB_SCRIPT_GUNJALA_GONDI Gong
HB_SCRIPT_HANIFI_ROHINGYA Rohg
HB_SCRIPT_MAKASAR Maka
HB_SCRIPT_MEDEFAIDRIN Medf
HB_SCRIPT_OLD_SOGDIAN Sogo
HB_SCRIPT_SOGDIAN Sogd
HB_SCRIPT_ELYMAIC Elym
HB_SCRIPT_NANDINAGARI Nand
HB_SCRIPT_NYIAKENG_PUACHUE_HMONG Hmnp
HB_SCRIPT_WANCHO Wcho
HB_SCRIPT_CHORASMIAN Chrs
HB_SCRIPT_DIVES_AKURU Diak
HB_SCRIPT_KHITAN_SMALL_SCRIPT Kits
HB_SCRIPT_YEZIDI Yezi
HB_SCRIPT_CYPRO_MINOAN Cpmn
HB_SCRIPT_OLD_UYGHUR Ougr
HB_SCRIPT_TANGSA Tnsa
HB_SCRIPT_TOTO Toto
HB_SCRIPT_VITHKUQI Vith
HB_SCRIPT_MATH Zmth
	).

	code := String streamContents: [ :stream |

		stream nextPutAll: 'enumDecl

	^ #(
'.

		pairsArray pairsDo: [ :a :b |
			stream nextPutAll: ('	{1}	 	{2}' format: { a. b asByteArray asInteger }); cr. ].

		stream nextPutAll: '	HB_SCRIPT_INVALID 0)' ].

	self classSide compile: code.

	self rebuildEnumAccessors.

]

{ #category : #'enum declaration' }
AeHbScript class >> initialize [

	self initializeEnumeration
]

{ #category : #'accessing enum' }
AeHbScript class >> latin [

	^ self HB_SCRIPT_LATIN
]
