Class {
	#name : #DSPackageSelection,
	#superclass : #DSSelection,
	#instVars : [
		'classes'
	],
	#category : 'Discord-Tools-Support'
}

{ #category : #visiting }
DSPackageSelection >> accept: aVisitor [
	^ aVisitor visitDSPackageSelection: self
]

{ #category : #adding }
DSPackageSelection >> addClassSelection: aClassSelection [
	^ self classes addLast: aClassSelection.
]

{ #category : #accessing }
DSPackageSelection >> children [
	^ self classes
]

{ #category : #accessing }
DSPackageSelection >> classes [
	^ classes
]

{ #category : #accessing }
DSPackageSelection >> classes: anObject [
	classes := anObject
]

{ #category : #initialization }
DSPackageSelection >> initialize [
	super initialize.
	classes := OrderedCollection new.
]
