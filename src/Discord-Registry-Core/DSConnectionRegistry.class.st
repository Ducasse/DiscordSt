Class {
	#name : #DSConnectionRegistry,
	#superclass : #Object,
	#instVars : [
		'icon',
		'origin'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #visiting }
DSConnectionRegistry >> accept: aVisitor [
	^ self subclassResponsibility
]

{ #category : #accessing }
DSConnectionRegistry >> children [
	^ #()
]

{ #category : #initialization }
DSConnectionRegistry >> defaultIcon [
	^ self iconNamed: #empty
]

{ #category : #accessing }
DSConnectionRegistry >> icon [
	^ icon
]

{ #category : #accessing }
DSConnectionRegistry >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
DSConnectionRegistry >> initialize [
	super initialize.
	icon := self defaultIcon.
]

{ #category : #accessing }
DSConnectionRegistry >> origin [
	^ origin
]

{ #category : #accessing }
DSConnectionRegistry >> origin: anObject [
	origin := anObject
]

{ #category : #actions }
DSConnectionRegistry >> send: aDSSendItems [ 
	"Send items to the given communication channel."
	^ self subclassResponsibility
]
