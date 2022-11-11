"
My subclasses are enums in Cairo API.
"
Class {
	#name : #AeEnumeration,
	#superclass : #FFIEnumeration,
	#category : #'Alexandrie-Base'
}

{ #category : #initialization }
AeEnumeration class >> initialize [

	self allSubclassesDo: [ :each | each initializeEnumeration ]
]

{ #category : #accessing }
AeEnumeration class >> underlineToCamelCaseDictionary [
	"
	Examples:
		AeCairoContent underlineToCamelCaseDictionary.
		AeCairoCompositionOp underlineToCamelCaseDictionary.
		self allSubclasses collect: [ :each | each underlineToCamelCaseDictionary ].
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
