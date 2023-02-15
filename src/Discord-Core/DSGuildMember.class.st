"
I represent a Discord Guild Member object.

See https://discordapp.com/developers/docs/resources/guild#guild-member-object

Field	Type	Description
user	object	user object
nick?	string	this users guild nickname (if one is set)
roles	array of snowflakes	array of role object ids
joined_at	ISO8601 timestamp	when the user joined the guild
deaf	bool	if the user is deafened
mute	bool	if the user is muted

"
Class {
	#name : #DSGuildMember,
	#superclass : #DSObject,
	#instVars : [
		'user',
		'nick',
		'roleIds',
		'joinedAt',
		'deaf',
		'mute'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #examples }
DSGuildMember class >> basic [
	<gtExample>
	<label: 'Guild Member'>
	^ self jsonMappingClass
		read: DSGuildMember
		withMapping: #guildMemberMappingFor:
		on: self jsonMappingClass jsonGuildMember readStream
]

{ #category : #accessing }
DSGuildMember >> children [
	^ self user
		ifNil: [ #() ] 
		ifNotNil: [ :aUser | Array with: aUser ]
]

{ #category : #accessing }
DSGuildMember >> deaf [
	^ deaf
]

{ #category : #accessing }
DSGuildMember >> deaf: anObject [
	deaf := anObject
]

{ #category : #'accessing - defaults' }
DSGuildMember >> defaultUsername [
	^ '<unknown>'
]

{ #category : #accessing }
DSGuildMember >> joinedAt [
	^ joinedAt
]

{ #category : #accessing }
DSGuildMember >> joinedAt: anObject [
	joinedAt := anObject
]

{ #category : #accessing }
DSGuildMember >> members [
	"Convenience method for tree views"
	^ self children
]

{ #category : #'accessing - convenience' }
DSGuildMember >> message [
	^ self user message
]

{ #category : #accessing }
DSGuildMember >> mute [
	^ mute
]

{ #category : #accessing }
DSGuildMember >> mute: anObject [
	mute := anObject
]

{ #category : #accessing }
DSGuildMember >> nick [
	^ nick
]

{ #category : #accessing }
DSGuildMember >> nick: anObject [
	nick := anObject
]

{ #category : #'accessing - convenience' }
DSGuildMember >> nickOrUsername [
	"Return a nick or username"
	<return: #String>
	^ self nick ifNil: [ self username ]
]

{ #category : #printing }
DSGuildMember >> printOn: aStream [
	aStream nextPutAll: 'Member: '.
	self user ifNotNil: [ :aUser | 
		aStream print: aUser username ].
	self nick ifNotNil: [ :nickString | 
		aStream 
			nextPutAll: ' with nick ';
			print: nickString ].
	
]

{ #category : #accessing }
DSGuildMember >> roleIds [
	^ roleIds
]

{ #category : #accessing }
DSGuildMember >> roleIds: anObject [
	roleIds := anObject
]

{ #category : #accessing }
DSGuildMember >> user [
	^ user
]

{ #category : #accessing }
DSGuildMember >> user: anObject [
	user := anObject
]

{ #category : #'accessing - convenience' }
DSGuildMember >> username [
	<return: #String>
	^ self user ifNil: [ self defaultUsername ] ifNotNil: [ :aUser | aUser username ]
]
