"
A DSGuildTest is a test class for testing the behavior of DSGuild
"
Class {
	#name : 'DSGuildTest',
	#superclass : 'DSObjectTest',
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
DSGuildTest >> classToTest [
	^ DSGuild
]

{ #category : 'tests-enumerating' }
DSGuildTest >> testTextChannels [
	| channels |
	channels := self coreModelJsonMapping 
		read: #CollectionOfSortedChannels 
		withMapping: #collectionOfSortedChannelsMappingFor: 
		on: self coreModelJsonMapping jsonCollectionOfChannelsThree readStream.
	object := self classToTest new.
	object channels: channels.
	self assert: object textChannels notNil.
	self assert: object textChannels size equals: 1.
	self assert: object textChannels first name equals: 'general'.	
]
