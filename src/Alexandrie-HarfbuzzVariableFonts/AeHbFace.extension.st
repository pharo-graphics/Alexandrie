Extension { #name : 'AeHbFace' }

{ #category : '*Alexandrie-HarfbuzzVariableFonts' }
AeHbFace >> axisInfos [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-get-axis-infos"

	| infosArray axisCount axisCountAddress |
	axisCount := self variableFontAxisCount.
	infosArray := FFIExternalArray
		newType: AeHbVariableFontAxisInfo
		size: axisCount.
	axisCountAddress := FFIUInt32 newBuffer.
	axisCountAddress unsignedLongAt: 1 put: axisCount.
	self getAxisInfosInto: infosArray size: axisCountAddress.
	^ infosArray
]

{ #category : '*Alexandrie-HarfbuzzVariableFonts' }
AeHbFace >> getAxisInfosInto: axisArray size: axisCountAddress [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-get-axis-infos"

	^ self ffiCall: #(
		uint
		hb_ot_var_get_axis_infos (
			self,
			uint "start_offset" 0,
			uint *"axes_count" axisCountAddress,
			FFIExternalArray axisArray ) )
]

{ #category : '*Alexandrie-HarfbuzzVariableFonts' }
AeHbFace >> hasVariableFontsData [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-has-data"

	^ self ffiCall: #(
		hb_bool_t
		hb_ot_var_has_data ( self ) )
]

{ #category : '*Alexandrie-HarfbuzzVariableFonts' }
AeHbFace >> variableFontAxisCount [
	"See: https://harfbuzz.github.io/harfbuzz-hb-ot-var.html#hb-ot-var-get-axis-count"

	^ self ffiCall: #(
		uint
		hb_ot_var_get_axis_count ( self ) )
]
