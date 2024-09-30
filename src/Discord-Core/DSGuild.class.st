"
I represent Discord Guild Object, a brief version of a guild object.
See https://discordapp.com/developers/docs/resources/user#user-guild-object

"
Class {
	#name : 'DSGuild',
	#superclass : 'DSObject',
	#instVars : [
		'restApi',
		'id',
		'name',
		'iconHash',
		'splashHash',
		'ownerId',
		'region',
		'afkChannelId',
		'afkTimeout',
		'embedEnabled',
		'embedChannelId',
		'verificationLevel',
		'defaultMessageNotifications',
		'explicitContentFilter',
		'roles',
		'emojis',
		'features',
		'mfaLevel',
		'applicationId',
		'widgetEnabled',
		'widgetChannelId',
		'joinedAt',
		'large',
		'unavailable',
		'memberCount',
		'voiceStates',
		'members',
		'channels',
		'presences'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'defaults' }
DSGuild class >> defaultCollection [
	"A collection class used for creation of instances"
	^ DSGuilds new
]

{ #category : 'accessing' }
DSGuild >> afkChannelId [
	^ afkChannelId
]

{ #category : 'accessing' }
DSGuild >> afkChannelId: anObject [
	afkChannelId := anObject
]

{ #category : 'accessing' }
DSGuild >> afkTimeout [
	^ afkTimeout
]

{ #category : 'accessing' }
DSGuild >> afkTimeout: anObject [
	afkTimeout := anObject
]

{ #category : 'accessing' }
DSGuild >> applicationId [
	^ applicationId
]

{ #category : 'accessing' }
DSGuild >> applicationId: anObject [
	applicationId := anObject
]

{ #category : 'enumerating' }
DSGuild >> channelNamed: aString [ 
	"Return channel of a particular name."
	^ self channelSatisfying: [ :eachChannel | eachChannel name = aString ]
]

{ #category : 'enumerating' }
DSGuild >> channelSatisfying: conditionBlock [ 
	"Return a channel that satisfy the condition."
	<return: #DSChannel>
	^ DSDetectChannelCommand new
		channels: self channels;
		satisfiedBy: conditionBlock;
		execute;
		satisfyingChannel.
]

{ #category : 'accessing' }
DSGuild >> channels [
	"Return channels registered to this server."
	^ channels ifNil: [ channels := self restApi guildChannelsOf: self ]
]

{ #category : 'accessing' }
DSGuild >> channels: anObject [
	channels := anObject
]

{ #category : 'enumerating' }
DSGuild >> children [
	"Return channels if authenticated.
	Useful for tree view representations."
	^ self isAuthenticated 
		ifTrue: [ self channels ] 
		ifFalse: [ 
			self hasChannels 
				ifTrue: [ self channels ]
				ifFalse: [ self class defaultCollection ] ]
]

{ #category : 'accessing' }
DSGuild >> defaultMessageNotifications [
	^ defaultMessageNotifications
]

{ #category : 'accessing' }
DSGuild >> defaultMessageNotifications: anObject [
	defaultMessageNotifications := anObject
]

{ #category : 'accessing' }
DSGuild >> embedChannelId [
	^ embedChannelId
]

{ #category : 'accessing' }
DSGuild >> embedChannelId: anObject [
	embedChannelId := anObject
]

{ #category : 'accessing' }
DSGuild >> embedEnabled [
	^ embedEnabled
]

{ #category : 'accessing' }
DSGuild >> embedEnabled: anObject [
	embedEnabled := anObject
]

{ #category : 'accessing' }
DSGuild >> emojis [
	^ emojis
]

{ #category : 'accessing' }
DSGuild >> emojis: anObject [
	emojis := anObject
]

{ #category : 'accessing' }
DSGuild >> explicitContentFilter [
	^ explicitContentFilter
]

{ #category : 'accessing' }
DSGuild >> explicitContentFilter: anObject [
	explicitContentFilter := anObject
]

{ #category : 'accessing' }
DSGuild >> features [
	^ features
]

{ #category : 'accessing' }
DSGuild >> features: anObject [
	features := anObject
]

{ #category : 'enumerating' }
DSGuild >> flattenedChannels [
	^ DSFlattenChannelsKeepOrderCommand new
			channels: self channels;
			execute;
			flattenedChannels.
]

{ #category : 'enumerating' }
DSGuild >> general [
	"Return general channel.
	General channel has the same id as the guild."
	^ self channelSatisfying: #isGeneral
]

{ #category : 'gt-inspector-extension' }
DSGuild >> gtInspectorChannels: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Channels' translated ];
		display: [ self channels ];
		when: [ self hasChannels or: [ self isAuthenticated ] ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : 'gt-inspector-extension' }
DSGuild >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self members ];
		when: [ self hasMembers or: [ self isAuthenticated ] ];
		children: [ :item | item members ];
		yourself
]

{ #category : 'testing' }
DSGuild >> hasChannels [
	"Return true if the currently logged user is the server owner;
	false otherwise."
	^ channels isEmptyOrNil not
]

{ #category : 'testing' }
DSGuild >> hasMembers [
	^ members notNil
]

{ #category : 'accessing' }
DSGuild >> iconHash [
	^ iconHash
]

{ #category : 'accessing' }
DSGuild >> iconHash: anObject [
	iconHash := anObject
]

{ #category : 'accessing' }
DSGuild >> id [
	^ id
]

{ #category : 'accessing' }
DSGuild >> id: anObject [
	id := anObject
]

{ #category : 'initialization' }
DSGuild >> initialize [
	super initialize.
	restApi := DSRestBasic uniqueInstance.
]

{ #category : 'testing' }
DSGuild >> isAuthenticated [
	^ self restApi isAuthenticated
]

{ #category : 'testing' }
DSGuild >> isOwner [
	"Return true if the currently logged user is the server owner;
	false otherwise."
	^ self owner ifNil: false
]

{ #category : 'accessing' }
DSGuild >> joinedAt [
	^ joinedAt
]

{ #category : 'accessing' }
DSGuild >> joinedAt: anObject [
	joinedAt := anObject
]

{ #category : 'accessing' }
DSGuild >> large [
	^ large
]

{ #category : 'accessing' }
DSGuild >> large: anObject [
	large := anObject
]

{ #category : 'accessing' }
DSGuild >> memberCount [
	^ memberCount
]

{ #category : 'accessing' }
DSGuild >> memberCount: anObject [
	memberCount := anObject
]

{ #category : 'accessing' }
DSGuild >> members [
	^ members ifNil: [ members := self restApi listGuildMembersOfGuildId: self id ]
]

{ #category : 'accessing' }
DSGuild >> members: anObject [
	members := anObject
]

{ #category : 'accessing' }
DSGuild >> mfaLevel [
	^ mfaLevel
]

{ #category : 'accessing' }
DSGuild >> mfaLevel: anObject [
	mfaLevel := anObject
]

{ #category : 'accessing' }
DSGuild >> name [
	^ name
]

{ #category : 'accessing' }
DSGuild >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
DSGuild >> ownerId [
	^ ownerId
]

{ #category : 'accessing' }
DSGuild >> ownerId: anObject [
	ownerId := anObject
]

{ #category : 'accessing' }
DSGuild >> presences [
	^ presences
]

{ #category : 'accessing' }
DSGuild >> presences: anObject [
	presences := anObject
]

{ #category : 'printing' }
DSGuild >> printOn: aStream [
	"Print server name if available"
	aStream << 'User Guild: '.
	self name 
		ifNotNil: [ :string | aStream << string asString ]
		ifNil: [ aStream << '<nameless>' ].
]

{ #category : 'accessing' }
DSGuild >> region [
	^ region
]

{ #category : 'accessing' }
DSGuild >> region: anObject [
	region := anObject
]

{ #category : 'accessing' }
DSGuild >> restApi [
	^ restApi
]

{ #category : 'accessing' }
DSGuild >> restApi: anObject [
	restApi := anObject
]

{ #category : 'accessing' }
DSGuild >> roles [
	^ roles
]

{ #category : 'accessing' }
DSGuild >> roles: anObject [
	roles := anObject
]

{ #category : 'accessing' }
DSGuild >> splashHash [
	^ splashHash
]

{ #category : 'accessing' }
DSGuild >> splashHash: anObject [
	splashHash := anObject
]

{ #category : 'enumerating' }
DSGuild >> textChannels [
	"Return text channels."
	^ self flattenedChannels select: #isGuildTextChannel
]

{ #category : 'accessing' }
DSGuild >> unavailable [
	^ unavailable
]

{ #category : 'accessing' }
DSGuild >> unavailable: anObject [
	unavailable := anObject
]

{ #category : 'accessing' }
DSGuild >> verificationLevel [
	^ verificationLevel
]

{ #category : 'accessing' }
DSGuild >> verificationLevel: anObject [
	verificationLevel := anObject
]

{ #category : 'accessing' }
DSGuild >> voiceStates [
	^ voiceStates
]

{ #category : 'accessing' }
DSGuild >> voiceStates: anObject [
	voiceStates := anObject
]

{ #category : 'accessing' }
DSGuild >> widgetChannelId [
	^ widgetChannelId
]

{ #category : 'accessing' }
DSGuild >> widgetChannelId: anObject [
	widgetChannelId := anObject
]

{ #category : 'accessing' }
DSGuild >> widgetEnabled [
	^ widgetEnabled
]

{ #category : 'accessing' }
DSGuild >> widgetEnabled: anObject [
	widgetEnabled := anObject
]
