"
I represent a Discord Reaction Object.

See https://discordapp.com/developers/docs/resources/channel#reaction-object

count	integer	times this emoji has been used to react
me		bool	whether the current user reacted using this emoji
emoji	partial emoji object	emoji information

"
Class {
	#name : #DSReaction,
	#superclass : #DSObject,
	#instVars : [
		'count',
		'me',
		'emoji'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSReaction >> count [
	"times this emoji has been used to react"
	^ count
]

{ #category : #accessing }
DSReaction >> count: anObject [
	count := anObject
]

{ #category : #accessing }
DSReaction >> emoji [
	"emoji information"
	^ emoji
]

{ #category : #accessing }
DSReaction >> emoji: anObject [
	emoji := anObject
]

{ #category : #accessing }
DSReaction >> me [
	"whether the current user reacted using this emoji"
	^ me
]

{ #category : #accessing }
DSReaction >> me: anObject [
	me := anObject
]
