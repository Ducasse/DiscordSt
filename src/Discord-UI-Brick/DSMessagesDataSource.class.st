Class {
	#name : #DSMessagesDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'messages'
	],
	#category : 'Discord-UI-Brick'
}

{ #category : #initialization }
DSMessagesDataSource >> initialize [
	super initialize.
	messages := DSMessages new.
]

{ #category : #accessing }
DSMessagesDataSource >> itemCount [
	^ messages size
]

{ #category : #accessing }
DSMessagesDataSource >> messages [
	^ messages
]

{ #category : #accessing }
DSMessagesDataSource >> messages: anObject [
	messages := anObject.
	self notifyChanged.
]

{ #category : #'instance creation' }
DSMessagesDataSource >> onBindHolder: anElementHolder at: aPosition [
	"Update holder's model"
	anElementHolder message: (messages at: aPosition)
]

{ #category : #'instance creation' }
DSMessagesDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ DSMessagesElementHolder new
]
