"
I am an abstract class.
I represent user's and bot's connection status, that can be idle, dnd, online, or offline.

See https://discordapp.com/developers/docs/topics/gateway#presence-update-presence-update-event-fields
"
Class {
	#name : 'DSConnectionStatus',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'enumerating' }
DSConnectionStatus class >> allStatuses [
	^ self allSubclasses
]

{ #category : 'cleanup' }
DSConnectionStatus class >> cleanUp [
	self reset
]

{ #category : 'accessing' }
DSConnectionStatus class >> description [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : 'instance creation' }
DSConnectionStatus class >> newFromString: aString [
	^ (self allStatuses detect: [ :eachClass | eachClass statusString = aString ]) uniqueInstance
]

{ #category : 'accessing' }
DSConnectionStatus class >> reset [
	uniqueInstance := nil
]

{ #category : 'accessing' }
DSConnectionStatus class >> statusString [
	"Return a string that represents a particular status.
	The string has to coincide with Discord statuses."
	<return: #String>
	^ self subclassResponsibility
]

{ #category : 'accessing' }
DSConnectionStatus class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
DSConnectionStatus >> statusString [
	^ self class statusString
]
