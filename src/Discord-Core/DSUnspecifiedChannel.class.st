"
I represent a guild or DM channel within Discord.

See: https://discordapp.com/developers/docs/resources/channel#channel-object

Field	Type	Description
id	snowflake	the id of this channel
type	integer	the type of channel
guild_id?	snowflake	the id of the guild
position?	integer	sorting position of the channel
permission_overwrites?	array of overwrite objects	explicit permission overwrites for members and roles
name?	string	the name of the channel (2-100 characters)
topic?	string	the channel topic (0-1024 characters)
nsfw?	bool	if the channel is nsfw
last_message_id?	?snowflake	the id of the last message sent in this channel (may not point to an existing or valid message)
bitrate?	integer	the bitrate (in bits) of the voice channel
user_limit?	integer	the user limit of the voice channel
recipients?	array of user objects	the recipients of the DM
icon?	?string	icon hash
owner_id?	snowflake	id of the DM creator
application_id?	snowflake	application id of the group DM creator if it is bot-created
parent_id?	?snowflake	id of the parent category for a channel

"
Class {
	#name : 'DSUnspecifiedChannel',
	#superclass : 'DSObject',
	#instVars : [
		'id',
		'type',
		'guildId',
		'position',
		'permissionOverwrites',
		'name',
		'topic',
		'nsfw',
		'lastMessageId',
		'bitrate',
		'userLimit',
		'recipients',
		'icon',
		'ownerId',
		'applicationId',
		'parentId'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSUnspecifiedChannel >> applicationId [
	^ applicationId
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> applicationId: anObject [
	applicationId := anObject
]

{ #category : 'converting' }
DSUnspecifiedChannel >> asSpecifiedChannel [
	^ self type 
		ifNotNil: [ :aType | aType asSpecifiedChannel: self ]
		ifNil: #yourself
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> bitrate [
	^ bitrate
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> bitrate: anObject [
	bitrate := anObject
]

{ #category : 'enumerating' }
DSUnspecifiedChannel >> children [
	"Return empty collection because we do not want to expand messages in a tree view.
	There could be too many.
	Useful for tree view representations."
	^ self class defaultCollection
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> guildId [
	^ guildId
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> guildId: anObject [
	guildId := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> icon [
	^ icon
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> icon: anObject [
	icon := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> id [
	^ id
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> id: anObject [
	id := anObject
]

{ #category : 'testing' }
DSUnspecifiedChannel >> isCategory [
	^ false
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> lastMessageId [
	^ lastMessageId
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> lastMessageId: anObject [
	lastMessageId := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> name [
	^ name
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> nsfw [
	^ nsfw
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> nsfw: anObject [
	nsfw := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> ownerId [
	^ ownerId
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> ownerId: anObject [
	ownerId := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> parentId [
	^ parentId
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> parentId: anObject [
	parentId := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> permissionOverwrites [
	^ permissionOverwrites
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> permissionOverwrites: anObject [
	permissionOverwrites := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> position [
	^ position
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> position: anObject [
	position := anObject
]

{ #category : 'printing' }
DSUnspecifiedChannel >> printOn: aStream [
	aStream 
		<< self typeName
		<< ': '
		<< (self name ifNil: [ '<nameless>' ])
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> recipients [
	^ recipients
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> recipients: anObject [
	recipients := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> topic [
	^ topic
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> topic: anObject [
	topic := anObject
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> type [
	^ type
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> type: anObject [
	type := anObject
]

{ #category : 'accessing - convenience' }
DSUnspecifiedChannel >> typeName [
	^ self type
		ifNil: [ 'Unknown' ]
		ifNotNil: #name
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> userLimit [
	^ userLimit
]

{ #category : 'accessing' }
DSUnspecifiedChannel >> userLimit: anObject [
	userLimit := anObject
]
