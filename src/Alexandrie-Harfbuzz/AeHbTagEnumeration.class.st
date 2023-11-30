Class {
	#name : 'AeHbTagEnumeration',
	#superclass : 'AeEnumeration',
	#category : 'Alexandrie-Harfbuzz-Enumerations',
	#package : 'Alexandrie-Harfbuzz',
	#tag : 'Enumerations'
}

{ #category : 'printing' }
AeHbTagEnumeration >> printOn: stream [

	stream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self item;
		space;
		nextPutAll: self value asHbTagString;
		nextPut: $)
]
