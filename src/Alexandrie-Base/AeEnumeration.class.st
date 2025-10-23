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

	| allValues |
	allValues := SortedCollection sortUsing: [ :a :b | a item < b item ].

	self withAllSuperclassesDo: [ :each |
		each = AeEnumeration
			ifFalse: [ allValues addAll: each classPool values ]
			ifTrue: [ ^ allValues asArray "done!" ] ]
]

{ #category : #accessing }
AeEnumeration class >> camelCaseNameFor: aUnderlinedName [

	| camelCaseName |
	camelCaseName := aUnderlinedName withoutPrefix: self underlinedNamePrefix.
	camelCaseName := String streamContents: [ :stringStream |
		($_ split: camelCaseName) do: [ :each |
			stringStream << each asLowercase asCamelCase ] ].
	^ camelCaseName uncapitalized
]

{ #category : #'class initialization' }
AeEnumeration class >> initialize [
	"We take the responsibility of initializing the whole hierarchy.
	Why? To avoid duplication of initialize on each subclass.
	However, we have to only initialize subclasses that define #enumDecl on classSide."

	self allSubclassesDo: [ :each |
		(each classSide includesSelector: #enumDecl)
			ifTrue: [ each initializeEnumeration ] ]
]

{ #category : #accessing }
AeEnumeration class >> underlineToCamelCaseDictionary [
	"
	Example of use:
		| aClass |
		aClass := AeCairoFontType.
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

{ #category : #accessing }
AeEnumeration >> camelCaseName [

	^ self class camelCaseNameFor: self item
]
