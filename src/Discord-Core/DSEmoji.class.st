"
I represent a Discord Emoji Object.

See https://discordapp.com/developers/docs/resources/emoji#emoji-object

id				snowflake				emoji id
name			string					emoji name
roles			array of role object ids	roles this emoji is whitelisted to
user?			user object				user that created this emoji
require_colons	bool					whether this emoji must be wrapped in colons
managed		bool					whether this emoji is managed
							
Emoji Resource

Routes for controlling emojis do not follow the normal rate limit conventions. These routes are specifically limited on a per-guild basis to prevent abuse. This means that the quota returned by our APIs may be inaccurate, and you may encounter 429s.

"
Class {
	#name : #DSEmoji,
	#superclass : #DSObject,
	#instVars : [
		'id',
		'name',
		'roles',
		'user',
		'managed',
		'requireColons'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSEmoji >> id [
	^ id
]

{ #category : #accessing }
DSEmoji >> id: anObject [
	id := anObject
]

{ #category : #accessing }
DSEmoji >> managed [
	^ managed
]

{ #category : #accessing }
DSEmoji >> managed: anObject [
	managed := anObject
]

{ #category : #accessing }
DSEmoji >> name [
	^ name
]

{ #category : #accessing }
DSEmoji >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSEmoji >> requireColons [
	^ requireColons
]

{ #category : #accessing }
DSEmoji >> requireColons: anObject [
	requireColons := anObject
]

{ #category : #accessing }
DSEmoji >> roles [
	^ roles
]

{ #category : #accessing }
DSEmoji >> roles: anObject [
	roles := anObject
]

{ #category : #accessing }
DSEmoji >> user [
	^ user
]

{ #category : #accessing }
DSEmoji >> user: anObject [
	user := anObject
]
