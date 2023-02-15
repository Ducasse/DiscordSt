"
A DSGuildTextChannelTest is a test class for testing the behavior of DSGuildTextChannel.

"
Class {
	#name : #DSGuildTextChannelTest,
	#superclass : #DSGuildChannelTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #defaults }
DSGuildTextChannelTest >> correctType [
	"Return correct channel type"
	^ 'text'
]

{ #category : #defaults }
DSGuildTextChannelTest >> incorrectType [
	^ 'voice'
]

{ #category : #'instance creation' }
DSGuildTextChannelTest >> newChannel [
	^ DSGuildTextChannel new
]

{ #category : #tests }
DSGuildTextChannelTest >> testIsGeneral [
	channel := self newChannel.
	channel id: self anyString; guildId: self anyString; yourself.
	self assert: channel isGeneral
]

{ #category : #tests }
DSGuildTextChannelTest >> testLastMessageId [
	channel := self newChannel.
	channel lastMessageId: self anyString.
	self assert: channel lastMessageId equals: self anyString.
]

{ #category : #tests }
DSGuildTextChannelTest >> testTopic [
	channel := self newChannel.
	channel topic: self anyString.
	self assert: channel topic equals: self anyString.
]

{ #category : #defaults }
DSGuildTextChannelTest >> typeNameString [
	^ 'Text'
]
