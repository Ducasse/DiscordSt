"
A DSVoiceChannelTest is a test class for testing the behavior of DSVoiceChannel.
"
Class {
	#name : #DSGuildVoiceChannelTest,
	#superclass : #DSGuildChannelTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #defaults }
DSGuildVoiceChannelTest >> correctType [
	^ 'voice'
]

{ #category : #defaults }
DSGuildVoiceChannelTest >> incorrectType [
	^ 'text'
]

{ #category : #'instance creation' }
DSGuildVoiceChannelTest >> newChannel [
	^ DSGuildVoiceChannel new
]

{ #category : #tests }
DSGuildVoiceChannelTest >> testBitrate [
	channel := self newChannel.
	channel bitrate: 1234.
	self assert: channel bitrate equals: 1234.
]

{ #category : #tests }
DSGuildVoiceChannelTest >> testUserLimit [
	channel := self newChannel.
	channel userLimit: 1234.
	self assert: channel userLimit equals: 1234.
]

{ #category : #defaults }
DSGuildVoiceChannelTest >> typeNameString [
	^ 'Voice'
]
