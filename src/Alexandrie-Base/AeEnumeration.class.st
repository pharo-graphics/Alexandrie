"
My subclasses are enums in Cairo API.
"
Class {
	#name : #AeEnumeration,
	#superclass : #FFIEnumeration,
	#category : #'Alexandrie-Base'
}

{ #category : #accessing }
AeEnumeration class >> allValues [

	^ self classPool values sorted: [ :a :b | a item < b item ]
]

{ #category : #initialization }
AeEnumeration class >> initialize [

	self allSubclassesDo: [ :each | each initializeEnumeration ]
]

{ #category : #accessing }
AeEnumeration class >> underlineToCamelCaseDictionary [
	"
	Example of use:
		| aClass |
		aClass := AeCairoCompositionOp.
		aClass underlineToCamelCaseDictionary keysAndValuesDo: [ :k :v |
		aClass class compile: ('{2}

	^ {1}' format: { k. v }) classified: 'accessing enum camelcased' ]
	"

	| result |
	result := "Ordered"Dictionary new.
	
	self enumerationDictionary keysAndValuesDo: [ :eachName :eachValue |
		| camelCaseName |
		camelCaseName := eachName withoutPrefix: self underlinedNamePrefix.
		camelCaseName := String streamContents: [ :stringStream |
			($_ split: camelCaseName) do: [ :each |
				stringStream << each asLowercase asCamelCase ] ].
		camelCaseName := camelCaseName uncapitalized.
		result at: eachName put: camelCaseName ].
	
	^ result
]

{ #category : #hook }
AeEnumeration class >> underlinedNamePrefix [
	
	^ self subclassResponsibility
]
