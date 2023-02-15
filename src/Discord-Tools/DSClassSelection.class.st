Class {
	#name : #DSClassSelection,
	#superclass : #DSSelection,
	#instVars : [
		'concreteClass'
	],
	#category : 'Discord-Tools-Support'
}

{ #category : #visiting }
DSClassSelection >> accept: aVisitor [
	^ aVisitor visitDSClassSelection: self
]

{ #category : #accessing }
DSClassSelection >> children [
	^ #()
]
