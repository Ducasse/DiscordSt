"
I represent Discord Direct Message channel object .
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : #DSDirectMessageChannel,
	#superclass : #DSChannel,
	#instVars : [
		'id',
		'lastMessageId',
		'recipients',
		'messages'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #examples }
DSDirectMessageChannel class >> oneRecipient [
	<gtExample>
	<label: 'A direct message'>
	^ self jsonMappingClass 
		read: self 
		withMapping: #specifiedChannelMappingFor:
		on: self jsonMappingClass jsonChannelDirectMessage readStream
]

{ #category : #comparing }
DSDirectMessageChannel >> = anObject [
	^ self class = anObject class and: [ 
		self id = anObject id ]
]

{ #category : #'gt-inspector-extension' }
DSDirectMessageChannel >> gtInspectorMessages: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite with: [ :aComposite |
			self messages gtInspectorMessages: composite ]
]

{ #category : #comparing }
DSDirectMessageChannel >> hash [
	^ self class hash bitXor: self id
]

{ #category : #accessing }
DSDirectMessageChannel >> id [
	^ id
]

{ #category : #accessing }
DSDirectMessageChannel >> id: anObject [
	id := anObject
]

{ #category : #initialization }
DSDirectMessageChannel >> initialize [
	super initialize.
	recipients := #().
]

{ #category : #accessing }
DSDirectMessageChannel >> lastMessageId [
	^ lastMessageId
]

{ #category : #accessing }
DSDirectMessageChannel >> lastMessageId: anObject [
	lastMessageId := anObject
]

{ #category : #'accessing - convenience' }
DSDirectMessageChannel >> messages [
	<return: #DSMessages of: #DSMessage>
	^ messages ifNil: [ self restApi messagesForChannel: self ]
]

{ #category : #accessing }
DSDirectMessageChannel >> name [
	^ String streamContents: [ :aStream |
		self recipients 
			do: [ :eachRecipient | aStream << eachRecipient username ]
			separatedBy: [ aStream << ', ' ] ]
]

{ #category : #position }
DSDirectMessageChannel >> position [
	"Complement protocol of other channels."
	^ self lastMessageId 
		ifNil: [ 0 ] 
		ifNotNil: [ :anId | anId asNumber negated ]
]

{ #category : #printing }
DSDirectMessageChannel >> printOn: aStream [
	"Print channel name if available"
	aStream << 'DM Channel: '.
	self recipients 
		do: [ :eachRecipient | aStream << eachRecipient username ]
		separatedBy: [ aStream << ', ' ]
]

{ #category : #accessing }
DSDirectMessageChannel >> recipients [
	^ recipients
]

{ #category : #accessing }
DSDirectMessageChannel >> recipients: anObject [
	recipients := anObject
]

{ #category : #accessing }
DSDirectMessageChannel >> type [
	^ DSChannelDirectMessageType uniqueInstance
]
