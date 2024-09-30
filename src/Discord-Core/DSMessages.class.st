"
I represent collection of DSMessage
"
Class {
	#name : 'DSMessages',
	#superclass : 'DSOrderedCollection',
	#category : 'Discord-Core-Collections',
	#package : 'Discord-Core',
	#tag : 'Collections'
}

{ #category : 'example' }
DSMessages class >> threeItems [
	
	^ self new
		add: DSMessage content;
		add: DSMessage empty;
		add: DSMessage embedDescription;
		yourself
]

{ #category : 'enumerating' }
DSMessages >> fuels [
	"Return messages with isFuel status."
	^ self select: #isFuel
]

{ #category : 'printing' }
DSMessages >> printShortTime: aDateAndTime [
	| local |
	aDateAndTime ifNil: [ ^ aDateAndTime ].
	local := aDateAndTime asDateAndTime asLocal.
	^ local asDate = Date today
	ifTrue: [ local asTime print24 ]
	ifFalse: [ local asDate asString ]
]
