"
I represent user's presence as his or her current state on a guild.
This event is sent when a user's presence is updated for a guild.

See https://discordapp.com/developers/docs/topics/gateway#presence-update

The user object within this event can be partial, the only field which must be sent is the id field, everything else is optional. Along with this limitation, no fields are required, and the types of the fields are not validated. Your client should expect any combination of fields and types within this event.

Field	Type	Description
user	user object	the user presence is being updated for
roles	array of snowflakes	roles this user is in
game	?game object	null, or the user's current activity
guild_id	snowflake	id of the guild
status	string	either ""idle"", ""dnd"", ""online"", or ""offline""
"
Class {
	#name : #DSPresenceUpdate,
	#superclass : #DSObject,
	#instVars : [
		'user',
		'roleIds',
		'game',
		'guildId',
		'status'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSPresenceUpdate >> game [
	^ game
]

{ #category : #accessing }
DSPresenceUpdate >> game: anObject [
	game := anObject
]

{ #category : #accessing }
DSPresenceUpdate >> guildId [
	^ guildId
]

{ #category : #accessing }
DSPresenceUpdate >> guildId: anObject [
	guildId := anObject
]

{ #category : #accessing }
DSPresenceUpdate >> roleIds [
	^ roleIds
]

{ #category : #accessing }
DSPresenceUpdate >> roleIds: anObject [
	roleIds := anObject
]

{ #category : #accessing }
DSPresenceUpdate >> status [
	^ status
]

{ #category : #accessing }
DSPresenceUpdate >> status: anObject [
	status := anObject
]

{ #category : #accessing }
DSPresenceUpdate >> user [
	^ user
]

{ #category : #accessing }
DSPresenceUpdate >> user: anObject [
	user := anObject
]
