"
I convert from String to UTF-8 (byte and wide variants of String), with focus on performance in situations without concurrency.

Use like:
``` 
aConverter := AeUTF8Converter new.
aConverter convert: 'abc'.
aFFIObject string: aConverter buffer length: aConverter bufferLength
```

Inspired on `CairoUTF8Converter`.

"
Class {
	#name : #AeUTF8Converter,
	#superclass : #Object,
	#instVars : [
		'encoder',
		'buffer',
		'bufferStream',
		'stringSizeLimit'
	],
	#category : #'Alexandrie-Cairo-Text'
}

{ #category : #benchmarking }
AeUTF8Converter class >> exampleCompareBenchs [

	| converters zincEncoder cairoConverter aeConverter string |
	converters := OrderedCollection new.

	converters add: [ :aString |
		aString utf8Encoded ].

	converters add: [ :aString |
		aString asUTF8Bytes ].

	converters add: [ :aString |
		aString nullTerminatedEncodeWith: #utf8 ].

	zincEncoder := ZnUTF8Encoder new.
	converters add: [ :aString |
		zincEncoder encodeString: aString ].

	zincEncoder := ZnUTF8Encoder new.
	converters add: [ :aString |
		| buffer |
		buffer := ByteArray new: (aString size + 2) * 4.
		zincEncoder
			next: aString size
			putAll: aString
			startingAt: 1
			toStream: buffer writeStream.
		buffer ].

"--> Would add an unnecessary dependency to cairo

	cairoConverter := CairoUTF8Converter new.
	converters add: [ :aString |
		cairoConverter
			convert: aString
			from: 1
			to: aString size.
		cairoConverter buffer ]."

	aeConverter := AeUTF8Converter new.
	converters add: [ :aString |
		aeConverter convert: aString.
		aeConverter buffer ].


	string := String loremIpsum.
	(converters collect: [ :eachBlock |
		 [ eachBlock value: string ] bench ]) inspect

]

{ #category : #accessing }
AeUTF8Converter >> buffer [

	^ buffer
]

{ #category : #accessing }
AeUTF8Converter >> bufferLength [

	^ bufferStream position
]

{ #category : #converting }
AeUTF8Converter >> convert: aString [

	| length |
	length := aString size.

	length > stringSizeLimit
		ifTrue: [ 
			stringSizeLimit := length.
			buffer := ByteArray new: 4 * (length + 1).
			bufferStream := buffer writeStream ]
		ifFalse: [
			bufferStream reset ].
	
	encoder
		next: length
		putAll: aString 
		startingAt: 1
		toStream: bufferStream.

]

{ #category : #initialization }
AeUTF8Converter >> initialize [

	super initialize.

	encoder := ZnUTF8Encoder new.
	stringSizeLimit := -1 "Lazy initialization on first use"
]
