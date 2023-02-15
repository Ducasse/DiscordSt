"
I represent Discord Direct Message Group channel object .
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : #DSDirectMessageGroupChannel,
	#superclass : #DSChannel,
	#instVars : [
		'id',
		'lastMessageId',
		'recipients',
		'name',
		'ownerId',
		'icon'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSDirectMessageGroupChannel >> icon [
	^ icon
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> id [
	^ id
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> id: anObject [
	id := anObject
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> lastMessageId [
	^ lastMessageId
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> lastMessageId: anObject [
	lastMessageId := anObject
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> messages [
	<return: #DSMessages of: #DSMessage>
	^ self restApi messagesForChannel: self
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> name [
	^ name ifNil: [ self nameBasedOnRecipients ]
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> name: anObject [
	name := anObject
]

{ #category : #'accessing - computed' }
DSDirectMessageGroupChannel >> nameBasedOnRecipients [
	^ String streamContents: [ :aStream |
		self recipients 
			do: [ :eachRecipient | aStream << eachRecipient username ]
			separatedBy: [ aStream << ', ' ] ]
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> ownerId [
	^ ownerId
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> ownerId: anObject [
	ownerId := anObject
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> position [
	"Complement protocol of other channels."
	^ self lastMessageId asNumber negated
]

{ #category : #printing }
DSDirectMessageGroupChannel >> printOn: aStream [
	"Print channel name if available"
	aStream << 'DM Channel: '.
	self recipients 
		do: [ :eachRecipient | aStream << eachRecipient username ]
		separatedBy: [ aStream << ', ' ]
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> recipients [
	^ recipients
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> recipients: anObject [
	recipients := anObject
]

{ #category : #accessing }
DSDirectMessageGroupChannel >> type [
	^ DSChannelDirectMessageGroupType uniqueInstance
]
