"
I represent a user's voice connection status.

See https://discordapp.com/developers/docs/resources/voice#voice-state-object

Field	Type	Description
guild_id?	snowflake	the guild id this voice state is for
channel_id	snowflake	the channel id this user is connected to
user_id	snowflake	the user id this voice state is for
session_id	string	the session id for this voice state
deaf	bool	whether this user is deafened by the server
mute	bool	whether this user is muted by the server
self_deaf	bool	whether this user is locally deafened
self_mute	bool	whether this user is locally muted
suppress	bool	whether this user is muted by the current user
"
Class {
	#name : #DSVoiceState,
	#superclass : #DSObject,
	#instVars : [
		'guildId',
		'channelId',
		'userId',
		'sessionId',
		'deaf',
		'mute',
		'selfDeaf',
		'selfMute',
		'suppress'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSVoiceState >> channelId [
	^ channelId
]

{ #category : #accessing }
DSVoiceState >> channelId: anObject [
	channelId := anObject
]

{ #category : #accessing }
DSVoiceState >> deaf [
	^ deaf
]

{ #category : #accessing }
DSVoiceState >> deaf: anObject [
	deaf := anObject
]

{ #category : #accessing }
DSVoiceState >> guildId [
	^ guildId
]

{ #category : #accessing }
DSVoiceState >> guildId: anObject [
	guildId := anObject
]

{ #category : #accessing }
DSVoiceState >> mute [
	^ mute
]

{ #category : #accessing }
DSVoiceState >> mute: anObject [
	mute := anObject
]

{ #category : #accessing }
DSVoiceState >> selfDeaf [
	^ selfDeaf
]

{ #category : #accessing }
DSVoiceState >> selfDeaf: anObject [
	selfDeaf := anObject
]

{ #category : #accessing }
DSVoiceState >> selfMute [
	^ selfMute
]

{ #category : #accessing }
DSVoiceState >> selfMute: anObject [
	selfMute := anObject
]

{ #category : #accessing }
DSVoiceState >> sessionId [
	^ sessionId
]

{ #category : #accessing }
DSVoiceState >> sessionId: anObject [
	sessionId := anObject
]

{ #category : #accessing }
DSVoiceState >> suppress [
	^ suppress
]

{ #category : #accessing }
DSVoiceState >> suppress: anObject [
	suppress := anObject
]

{ #category : #accessing }
DSVoiceState >> userId [
	^ userId
]

{ #category : #accessing }
DSVoiceState >> userId: anObject [
	userId := anObject
]
