"
My subclasses are enums in Cairo API.
"
Class {
	#name : #AeEnumeration,
	#superclass : #FFIEnumeration,
	#category : #'Alexandrie-Cairo-Enumerations'
}

{ #category : #initialization }
AeEnumeration class >> initialize [

	self allSubclassesDo: [ :each | each initializeEnumeration ]
]
