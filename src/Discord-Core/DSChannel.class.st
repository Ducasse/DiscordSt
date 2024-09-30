"
I am an abstract class.
I represent a Discord channel .
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : 'DSChannel',
	#superclass : 'DSObject',
	#instVars : [
		'restApi'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'enumerating' }
DSChannel >> children [
	"Return empty collection because we do not want to expand messages in a tree view.
	There could be too many.
	Useful for tree view representations."
	^ self class defaultCollection
]

{ #category : 'enumerating' }
DSChannel >> detectChannel: conditionBlock [ 
	"Return a channel (itself) that satisfy the condition.
	Return nil, if there is no such channel.
	conditionBlock receives one argument, a channel, and return true if the channel satisfy the condition."
	^ (conditionBlock value: self) 
		ifTrue: [ self ]
		ifFalse: [nil ]
]

{ #category : 'accessing' }
DSChannel >> initialize [
	super initialize.
	restApi := DSRestBasic uniqueInstance.
]

{ #category : 'testing' }
DSChannel >> isAuthenticated [
	^ self restApi isAuthenticated
]

{ #category : 'testing' }
DSChannel >> isCategory [
	^ false
]

{ #category : 'testing' }
DSChannel >> isGeneral [
	^ false
]

{ #category : 'testing' }
DSChannel >> isGuildTextChannel [
	^ false
]

{ #category : 'testing' }
DSChannel >> isGuildVoiceChannel [
	^ false
]

{ #category : 'accessing - convenience' }
DSChannel >> parentId [
	"Category cannot have a parent"
	^ nil
]

{ #category : 'accessing' }
DSChannel >> restApi [
	^ restApi
]

{ #category : 'accessing' }
DSChannel >> restApi: anObject [
	restApi := anObject
]

{ #category : 'accessing' }
DSChannel >> type [
	<return: #DSChannelType>
	^ self subclassResponsibility
]
