"
I am an abstract class for all Discord channel types.

See https://discordapp.com/developers/docs/resources/channel#channel-object-channel-types

Type	ID
GUILD_TEXT	0
DM	1
GUILD_VOICE	2
GROUP_DM	3
GUILD_CATEGORY	4

"
Class {
	#name : #DSChannelType,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #enumerating }
DSChannelType class >> allChannelTypes [
	^ self allSubclasses
]

{ #category : #cleanup }
DSChannelType class >> cleanUp [
	self reset
]

{ #category : #'instance creation' }
DSChannelType class >> newFromNumber: anInteger [
	"Return a corresponding instance,
	see https://discordapp.com/developers/docs/resources/channel#channel-object-channel-types"

	| aClass |
	aClass := self allChannelTypes
		detect: [ :eachClass | eachClass typeNumber = anInteger ].
	^ aClass uniqueInstance
]

{ #category : #accessing }
DSChannelType class >> reset [
	uniqueInstance := nil
]

{ #category : #accessing }
DSChannelType class >> typeNumber [
	"Return an integer that represents the channel type.
	See https://discordapp.com/developers/docs/resources/channel#channel-object-channel-types"
	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #accessing }
DSChannelType class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #converting }
DSChannelType >> asSpecifiedChannel: aDSUnspecifiedChannel [ 
	"Convert an unspecified channel to a specific one, e.g., text channel, voice channel."
	<return: #DSChannel>
	^ self subclassResponsibility
]

{ #category : #accessing }
DSChannelType >> typeNumber [
	^ self class typeNumber
]
