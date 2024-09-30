"
I represent Discord Category channel object .
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : 'DSCategoryChannel',
	#superclass : 'DSChannel',
	#instVars : [
		'id',
		'guildId',
		'position',
		'permissionOverwrites',
		'name',
		'nsfw',
		'subordinateChannels'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'examples' }
DSCategoryChannel class >> withTwoChannels [
	<gtExample>
	^ DSModelJsonMapping 
		read: #CollectionOfSortedChannels 
		withMapping: #collectionOfSortedChannelsMappingFor: 
		on: DSModelJsonMapping jsonCollectionOfChannelsThree readStream.
]

{ #category : 'enumerating' }
DSCategoryChannel >> children [
	"Return empty collection because we do not want to expand messages in a tree view.
	There could be too many.
	Useful for tree view representations."
	^ self subordinateChannels
]

{ #category : 'enumerating' }
DSCategoryChannel >> detectChannel: conditionBlock [ 
	"Return a channel (itself or any subordinate channel) that satisfy the condition.
	Return nil, if there is no such channel.
	conditionBlock receives one argument, a channel, and return true if the channel satisfy the condition."
	(conditionBlock value: self) 
		ifTrue: [ ^ self ]
		ifFalse: [ 
			self subordinateChannels
				do: [ :eachChannel | | channel |
					channel := (eachChannel detectChannel: conditionBlock).
					channel ifNotNil: [ ^ channel ] ]. 
				^ nil ]
]

{ #category : 'accessing' }
DSCategoryChannel >> guildId [
	^ guildId
]

{ #category : 'accessing' }
DSCategoryChannel >> guildId: anObject [
	guildId := anObject
]

{ #category : 'accessing' }
DSCategoryChannel >> id [
	^ id
]

{ #category : 'accessing' }
DSCategoryChannel >> id: anObject [
	id := anObject
]

{ #category : 'testing' }
DSCategoryChannel >> isCategory [
	^ true
]

{ #category : 'accessing' }
DSCategoryChannel >> name [
	^ name
]

{ #category : 'accessing' }
DSCategoryChannel >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
DSCategoryChannel >> nsfw [
	^ nsfw
]

{ #category : 'accessing' }
DSCategoryChannel >> nsfw: anObject [
	nsfw := anObject
]

{ #category : 'accessing' }
DSCategoryChannel >> permissionOverwrites [
	^ permissionOverwrites
]

{ #category : 'accessing' }
DSCategoryChannel >> permissionOverwrites: anObject [
	permissionOverwrites := anObject
]

{ #category : 'accessing' }
DSCategoryChannel >> position [
	^ position
]

{ #category : 'accessing' }
DSCategoryChannel >> position: anObject [
	position := anObject
]

{ #category : 'printing' }
DSCategoryChannel >> printOn: aStream [
	"Print channel name if available"
	aStream << 'Category: '.
	self name 
		ifNotNil: [ :string | aStream << string asString ]
		ifNil: [ aStream << '<nameless>' ].
	
]

{ #category : 'accessing' }
DSCategoryChannel >> restApi: aRestApi [
	super restApi: aRestApi.
	self updateRestApi
]

{ #category : 'accessing - children' }
DSCategoryChannel >> subordinateChannels [
	^ subordinateChannels
]

{ #category : 'accessing - children' }
DSCategoryChannel >> subordinateChannels: aCollection [ 
	subordinateChannels := aCollection.
	self updateRestApi.
]

{ #category : 'accessing' }
DSCategoryChannel >> type [
	^ DSChannelGuildCategoryType uniqueInstance
]

{ #category : 'private' }
DSCategoryChannel >> updateRestApi [
	self subordinateChannels ifNotNil: [ :aCollection | 
		aCollection do: [ :eachChannel | eachChannel restApi: self restApi ] ]
]
