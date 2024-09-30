"
A DSGuildTest is a test class for testing the behavior of DSGuild
"
Class {
	#name : 'DSUserGuildTest',
	#superclass : 'DSObjectTest',
	#instVars : [
		'guild',
		'guildChannels'
	],
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'helpers' }
DSUserGuildTest >> guildChannelsOf: aDSUserGuild [ 
	"Return some channels."
	^ guildChannels
]

{ #category : 'instance creation' }
DSUserGuildTest >> newGuildChannelsInCategory [
	"Return some channels."
	^ { 
		self newCategoryChannel 
			name: 'Category One'; id: '251136000'; guildId: self anyString;
			subordinateChannels: {
				self newTextChannel name: 'general'; id: self anyString; guildId: self anyString; yourself.
				self newTextChannel name: 'sprint'; id: '251136000'; guildId: self anyString; yourself }.
		}
]

{ #category : 'instance creation' }
DSUserGuildTest >> newGuildChannelsTwo [
	"Return some channels."
	^ { 
		self newTextChannel name: 'general'; id: self anyString; guildId: self anyString; yourself.
		self newTextChannel name: 'sprint'; id: '251136000'; guildId: self anyString; yourself.
		}
]

{ #category : 'instance creation' }
DSUserGuildTest >> newObjectToTest [
	^ self newUserGuild 
]

{ #category : 'tests' }
DSUserGuildTest >> testChannelNamed [
	| channel |
	guild := self newUserGuild.
	guild id: self anyString.
	guild restApi: self.
	guildChannels := self newGuildChannelsTwo.
	channel := guild channelNamed: 'sprint'.
	self assert: channel name equals: 'sprint'.
]

{ #category : 'tests' }
DSUserGuildTest >> testChannelNamedInCategory [
	| channel |
	guildChannels := self newGuildChannelsInCategory.
	guild := self newUserGuild.
	guild id: self anyString.
	guild restApi: self.
	channel := guild channelNamed: 'sprint'.
	self assert: channel name equals: 'sprint'.
]

{ #category : 'tests' }
DSUserGuildTest >> testGeneral [
	guildChannels := self newGuildChannelsInCategory.
	guild := self newUserGuild.
	guild id: self anyString.
	guild restApi: self.
	self assert: guild general notNil.
]

{ #category : 'tests' }
DSUserGuildTest >> testPrintString [
	guild := self newUserGuild.
	guild name: self anyString.
	self assert: guild printString equals: 'User Guild: ', self anyString.
]

{ #category : 'tests' }
DSUserGuildTest >> testPrintStringDefault [
	self assert: self newUserGuild printString equals: 'User Guild: <nameless>'.
]
