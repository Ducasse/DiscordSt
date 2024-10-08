"
I represent a Game object that informs about user's game activity.

See https://discordapp.com/developers/docs/topics/gateway#game-object

Field	Type	Description	Present
name	string	the game's name	Always
type	integer	see Game Types	Always
url	?string	stream url, is validated when type is 1	When type is 1

Game Types:
ID	Name	Format	Example
0	Game	Playing {name}	""Playing Rocket League""
1	Streaming	Streaming {name}	""Streaming Rocket League""
			
The streaming type currently only supports Twitch. Only https://twitch.tv/ urls will work.
"
Class {
	#name : 'DSGame',
	#superclass : 'DSObject',
	#instVars : [
		'name',
		'type',
		'url'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGame >> name [
	^ name
]

{ #category : 'accessing' }
DSGame >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
DSGame >> type [
	^ type
]

{ #category : 'accessing' }
DSGame >> type: anObject [
	type := anObject
]

{ #category : 'accessing' }
DSGame >> url [
	^ url
]

{ #category : 'accessing' }
DSGame >> url: anObject [
	url := anObject
]
