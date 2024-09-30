"
I represent Discord Guilds voice channel object .
Guild channels represent an isolated set of users and messages within a Guild.
See documentation at https://discordapp.com/developers/docs/resources/channel#guild-channel-object

"
Class {
	#name : 'DSGuildVoiceChannel',
	#superclass : 'DSChannel',
	#instVars : [
		'id',
		'guildId',
		'position',
		'permissionOverwrites',
		'name',
		'bitrate',
		'userLimit',
		'parentId'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'accessing' }
DSGuildVoiceChannel >> bitrate [
	^ bitrate
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> bitrate: anObject [
	bitrate := anObject
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> guildId [
	^ guildId
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> guildId: anObject [
	guildId := anObject
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> id [
	^ id
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> id: anObject [
	id := anObject
]

{ #category : 'testing' }
DSGuildVoiceChannel >> isGuildVoiceChannel [
	^ true
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> name [
	^ name
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> parentId [
	^ parentId
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> parentId: anObject [
	parentId := anObject
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> permissionOverwrites [
	^ permissionOverwrites
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> permissionOverwrites: anObject [
	permissionOverwrites := anObject
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> position [
	^ position
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> position: anObject [
	position := anObject
]

{ #category : 'printing' }
DSGuildVoiceChannel >> printOn: aStream [
	"Print channel name if available"
	aStream << 'Voice Channel: '.
	self name 
		ifNotNil: [ :string | aStream << string asString ]
		ifNil: [ aStream << '<nameless>' ].
	
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> type [
	^ DSChannelGuildVoiceType uniqueInstance
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> userLimit [
	^ userLimit
]

{ #category : 'accessing' }
DSGuildVoiceChannel >> userLimit: anObject [
	userLimit := anObject
]
