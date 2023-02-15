Class {
	#name : #DSMessagesElementHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'message'
	],
	#category : 'Discord-UI-Brick'
}

{ #category : #initialization }
DSMessagesElementHolder >> initialize [
	super initialize.
	itemElement := DSMessageElement new.
]

{ #category : #accessing }
DSMessagesElementHolder >> message [
	^ message
]

{ #category : #accessing }
DSMessagesElementHolder >> message: anObject [
	message = anObject ifTrue: [ ^ self ].
	message := anObject.
	itemElement message: anObject.
]
