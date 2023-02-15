"
A DSChannelTest is a test class for testing the behavior of DSChannel.
"
Class {
	#name : #DSGuildChannelTest,
	#superclass : #DSObjectTest,
	#instVars : [
		'channel'
	],
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #testing }
DSGuildChannelTest class >> isAbstract [
	^ self = DSGuildChannelTest
]

{ #category : #defaults }
DSGuildChannelTest >> correctType [
	"Return correct channel type"
	^ self subclassResponsibility
]

{ #category : #defaults }
DSGuildChannelTest >> incorrectType [
	"Return incorrect channel type"
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
DSGuildChannelTest >> newChannel [
	"Return channel object"
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
DSGuildChannelTest >> newObjectToTest [
	^ self newChannel
]

{ #category : #tests }
DSGuildChannelTest >> testGuildId [
	channel := self newChannel.
	channel guildId: self anyString.
	self assert: channel guildId equals: self anyString.
]

{ #category : #tests }
DSGuildChannelTest >> testId [
	channel := self newChannel.
	channel id: self anyString.
	self assert: channel id equals: self anyString.
]

{ #category : #tests }
DSGuildChannelTest >> testIsGeneral2 [
	channel := self newChannel.
	channel id: self anyString; guildId: self anyStringTwo; yourself.
	self deny: channel isGeneral
]

{ #category : #tests }
DSGuildChannelTest >> testIsGeneralDefault [
	channel := self newChannel.
	self deny: channel isGeneral
]

{ #category : #tests }
DSGuildChannelTest >> testName [
	channel := self newChannel.
	channel name: self anyString.
	self assert: channel name equals: self anyString.
]

{ #category : #tests }
DSGuildChannelTest >> testPermissionOverwrites [
	channel := self newChannel.
	channel permissionOverwrites: #().
	self assert: channel permissionOverwrites equals: #().
]

{ #category : #tests }
DSGuildChannelTest >> testPosition [
	channel := self newChannel.
	channel position: 1234.
	self assert: channel position equals: 1234.
]

{ #category : #tests }
DSGuildChannelTest >> testPrintStringDefault [
	self assert: self newChannel printString equals: self typeNameString, ' Channel: <nameless>'.
]

{ #category : #defaults }
DSGuildChannelTest >> typeNameString [
	"Return channel type name used for printString"
	^ self subclassResponsibility
]
