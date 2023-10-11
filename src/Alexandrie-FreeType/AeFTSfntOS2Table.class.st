"
I am a FreeType FFI binding to `TT_OS2`.

A `TT_OS2` is a structure to model a TrueType ‘OS/2’ table. All fields comply to the OpenType specification.

For an OpenType variation font, the values of the following fields can change after a call to `FT_Set_Var_Design_Coordinates` (and friends) if the font contains an ‘MVAR’ table.

See: https://freetype.org/freetype2/docs/reference/ft2-truetype_tables.html#tt_os2
"
Class {
	#name : #AeFTSfntOS2Table,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_FSTYPE',
		'OFFSET_SFAMILYCLASS',
		'OFFSET_USWEIGHTCLASS',
		'OFFSET_USWIDTHCLASS',
		'OFFSET_VERSION',
		'OFFSET_XAVGCHARWIDTH',
		'OFFSET_YSTRIKEOUTPOSITION',
		'OFFSET_YSTRIKEOUTSIZE',
		'OFFSET_YSUBSCRIPTXOFFSET',
		'OFFSET_YSUBSCRIPTXSIZE',
		'OFFSET_YSUBSCRIPTYOFFSET',
		'OFFSET_YSUBSCRIPTYSIZE',
		'OFFSET_YSUPERSCRIPTXOFFSET',
		'OFFSET_YSUPERSCRIPTXSIZE',
		'OFFSET_YSUPERSCRIPTYOFFSET',
		'OFFSET_YSUPERSCRIPTYSIZE'
	],
	#category : #'Alexandrie-FreeType-FFI'
}

{ #category : #'field definition' }
AeFTSfntOS2Table class >> fieldsDesc [
	"See: https://freetype.org/freetype2/docs/reference/ft2-truetype_tables.html#tt_os2
	
	self rebuildFieldAccessors
	"

	^ #(
    ushort  version
    short   xAvgCharWidth
    ushort  usWeightClass
    ushort  usWidthClass
    ushort  fsType
    short   ySubscriptXSize
    short   ySubscriptYSize
    short   ySubscriptXOffset
    short   ySubscriptYOffset
    short   ySuperscriptXSize
    short   ySuperscriptYSize
    short   ySuperscriptXOffset
    short   ySuperscriptYOffset
    short   yStrikeoutSize
    short   yStrikeoutPosition
    short   sFamilyClass
	)
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> fsType [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_FSTYPE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> fsType: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_FSTYPE put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> sFamilyClass [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_SFAMILYCLASS
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> sFamilyClass: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_SFAMILYCLASS put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> usWeightClass [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_USWEIGHTCLASS
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> usWeightClass: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_USWEIGHTCLASS put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> usWidthClass [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_USWIDTHCLASS
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> usWidthClass: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_USWIDTHCLASS put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> version [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_VERSION
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> version: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_VERSION put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> xAvgCharWidth [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_XAVGCHARWIDTH
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> xAvgCharWidth: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_XAVGCHARWIDTH put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> yStrikeoutPosition [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSTRIKEOUTPOSITION
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> yStrikeoutPosition: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSTRIKEOUTPOSITION put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> yStrikeoutSize [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSTRIKEOUTSIZE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> yStrikeoutSize: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSTRIKEOUTSIZE put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptXOffset [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUBSCRIPTXOFFSET
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptXOffset: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUBSCRIPTXOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptXSize [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUBSCRIPTXSIZE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptXSize: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUBSCRIPTXSIZE put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptYOffset [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUBSCRIPTYOFFSET
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptYOffset: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUBSCRIPTYOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptYSize [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUBSCRIPTYSIZE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySubscriptYSize: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUBSCRIPTYSIZE put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptXOffset [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUPERSCRIPTXOFFSET
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptXOffset: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUPERSCRIPTXOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptXSize [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUPERSCRIPTXSIZE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptXSize: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUPERSCRIPTXSIZE put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptYOffset [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUPERSCRIPTYOFFSET
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptYOffset: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUPERSCRIPTYOFFSET put: anObject
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptYSize [
	"This method was automatically generated"
	^handle signedShortAt: OFFSET_YSUPERSCRIPTYSIZE
]

{ #category : #'accessing - structure variables' }
AeFTSfntOS2Table >> ySuperscriptYSize: anObject [
	"This method was automatically generated"
	handle signedShortAt: OFFSET_YSUPERSCRIPTYSIZE put: anObject
]
