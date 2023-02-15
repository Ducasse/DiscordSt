"
I represent Discord Guilds text channel object .
Guild channels represent an isolated set of users and messages within a Guild.
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : #DSGuildTextChannel,
	#superclass : #DSChannel,
	#instVars : [
		'id',
		'guildId',
		'position',
		'permissionOverwrites',
		'name',
		'topic',
		'nsfw',
		'lastMessageId',
		'icon',
		'parentId',
		'messages'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #'gt-inspector-extension' }
DSGuildTextChannel >> gtInspectorMessages: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite with: [ :aComposite |
		self isAuthenticated ifTrue: [ 
			self messages gtInspectorMessages: composite ] ]
]

{ #category : #accessing }
DSGuildTextChannel >> guildId [
	^ guildId
]

{ #category : #accessing }
DSGuildTextChannel >> guildId: anObject [
	guildId := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> icon [
	^ icon
]

{ #category : #accessing }
DSGuildTextChannel >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> id [
	^ id
]

{ #category : #accessing }
DSGuildTextChannel >> id: anObject [
	id := anObject
]

{ #category : #testing }
DSGuildTextChannel >> isGeneral [
	"Return true, if this is a general channel."
	^ self id notNil and: [ self id = self guildId ]
]

{ #category : #testing }
DSGuildTextChannel >> isGuildTextChannel [
	^ true
]

{ #category : #accessing }
DSGuildTextChannel >> lastMessageId [
	^ lastMessageId
]

{ #category : #accessing }
DSGuildTextChannel >> lastMessageId: anObject [
	lastMessageId := anObject
]

{ #category : #'accessing - convenience' }
DSGuildTextChannel >> messages [
	"Returns the messages for a channel. If operating on a guild channel, 
	this endpoint requires the 'READ_MESSAGES' permission to be present on the current user. 
	Returns an array of message objects on success.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-messages"

	^ messages ifNil: [ self restApi messagesForChannel: self ]
]

{ #category : #accessing }
DSGuildTextChannel >> name [
	^ name
]

{ #category : #accessing }
DSGuildTextChannel >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> nsfw [
	^ nsfw
]

{ #category : #accessing }
DSGuildTextChannel >> nsfw: anObject [
	nsfw := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> parentId [
	^ parentId
]

{ #category : #accessing }
DSGuildTextChannel >> parentId: anObject [
	parentId := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> permissionOverwrites [
	^ permissionOverwrites
]

{ #category : #accessing }
DSGuildTextChannel >> permissionOverwrites: anObject [
	permissionOverwrites := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> position [
	^ position
]

{ #category : #accessing }
DSGuildTextChannel >> position: anObject [
	position := anObject
]

{ #category : #printing }
DSGuildTextChannel >> printOn: aStream [
	"Print channel name if available"
	aStream << 'Text Channel: '.
	self name 
		ifNotNil: [ :string | aStream << string asString ]
		ifNil: [ aStream << '<nameless>' ].
	
]

{ #category : #public }
DSGuildTextChannel >> queryMessagesAfter: aDSMessage [ 
	"Return messages that are newer then the given message."
	<return: #DSMessages of: #DSMessage>
	^ self restApi messagesAfter: aDSMessage inChannel: self
]

{ #category : #public }
DSGuildTextChannel >> queryMessagesBefore: aDSMessage [ 
	"Return messages that are older then the given message."
	<return: #DSMessages of: #DSMessage>
	^ self restApi messagesBefore: aDSMessage inChannel: self
]

{ #category : #accessing }
DSGuildTextChannel >> topic [
	^ topic
]

{ #category : #accessing }
DSGuildTextChannel >> topic: anObject [
	topic := anObject
]

{ #category : #accessing }
DSGuildTextChannel >> type [
	^ DSChannelGuildTextType uniqueInstance
]
