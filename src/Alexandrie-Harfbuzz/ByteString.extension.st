Extension { #name : 'ByteString' }

{ #category : '*Alexandrie-Harfbuzz' }
ByteString >> asHbTagInteger [
	"Answer the integer representation of this Harfbuzz tag.
	
	Tags are four byte integers, each byte representing a character.

	Tags are used to identify tables, design-variation axes, scripts, languages, font features, and baselines with human-readable names.

See: https://harfbuzz.github.io/harfbuzz-hb-common.html#hb-tag-t"

	^ self asByteArray asInteger
]
