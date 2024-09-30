"
I keep setting for DSClient.
"
Class {
	#name : 'DSClientSettings',
	#superclass : 'Object',
	#classVars : [
		'DSClientEmail',
		'DSClientPassword',
		'DSClientToken'
	],
	#category : 'Discord-Client-Settings',
	#package : 'Discord-Client',
	#tag : 'Settings'
}

{ #category : 'accessing' }
DSClientSettings class >> cleanDiscordClientEmail [
	^ self discordClientEmail ifEmpty: [ nil ]
]

{ #category : 'accessing' }
DSClientSettings class >> cleanDiscordClientPassword [
	^ self discordClientPassword
]

{ #category : 'accessing' }
DSClientSettings class >> cleanDiscordClientToken [
	^ self discordClientToken
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientEmail [
	^ DSClientEmail ifNil: [ DSClientEmail := '' ]
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientEmail: anEmailOrEmptyString [ 
	DSClientEmail := anEmailOrEmptyString
]

{ #category : 'settings' }
DSClientSettings class >> discordClientEmailOn: aBuilder [  
	<systemsettings>  
	(aBuilder setting: #discordClientEmail)
		label: 'Discord User Email';
		iconName: #user;
		parent: #discord;
		description: 'A user email used to connect to Discord.';
		target: self;
		order: 3;
		type: #String;
		default: ''.
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientPassword [
	self ensureVolatileDiscordClientPassword.
	^ DSClientPassword value
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientPassword: passwordOrEmptyString [
	self ensureVolatileDiscordClientPassword.
	DSClientPassword value: passwordOrEmptyString
]

{ #category : 'settings' }
DSClientSettings class >> discordClientPasswordOn: aBuilder [  
	<systemsettings>  
	(aBuilder setting: #discordClientPassword)
		label: 'Discord User Password';
		parent: #discord;
		description: 'A user password used to connect to Discord. 
Notice that if you store the password on your local disk, it is unprotected.
You do not need to store the password as the authentication token is used after the first authentication.';
		target: self;
		type: #Password;
		default: '';
		order: 5.
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientToken [
	self ensureVolatileDiscordClientToken.
	^ DSClientToken value
]

{ #category : 'accessing' }
DSClientSettings class >> discordClientToken: tokenOrEmptyString [ 
	self ensureVolatileDiscordClientToken.
	DSClientToken value: tokenOrEmptyString
]

{ #category : 'settings' }
DSClientSettings class >> discordClientTokenOn: aBuilder [  
	<systemsettings>  
	(aBuilder setting: #discordClientToken)
		label: 'Discord Token';
		parent: #discord;
		description: 'An authentication token used for Discord communication. It is set by the client automatically. You likely do not want to change it.';
		order: 10;
		type: #Password;
		target: self;
		default: ''.
]

{ #category : 'settings' }
DSClientSettings class >> discordGroupOn: aBuilder [  
	<systemsettings>  
	(aBuilder group: #discord)
		label: 'Discord Communication';
		parent: #tools;
		description: 'All Discord Communication Settings. 
See https://discordapp.com do learn about Discord. 
The Pharo community uses it for on-line discussion.'.
]

{ #category : 'private' }
DSClientSettings class >> ensureVolatileDiscordClientPassword [
	DSClientPassword ifNil: [ 
		DSClientPassword := AutoReloadableVolatileSettingValue new
			settingId: #discordClientPassword;
			string: '';
			yourself ]
]

{ #category : 'private' }
DSClientSettings class >> ensureVolatileDiscordClientToken [
	DSClientToken ifNil: [ 
		DSClientToken := AutoReloadableVolatileSettingValue new
			settingId: #discordClientToken;
			string: '';
			yourself ]
]

{ #category : 'initialization' }
DSClientSettings class >> initialize [
	"Reinitialize class on 2018-03-21."
	self reset.
	self updateSettings.
]

{ #category : 'initialization' }
DSClientSettings class >> reset [
	DSClientPassword := nil.
	DSClientToken := nil.

]

{ #category : 'updating' }
DSClientSettings class >> storeDiscordClientSession: aDSClient [ 
	"Store all settings but password on a local disk."
	| tree nodes |
	tree := SystemSettingsPersistence default settingTree.
	nodes := tree deeplySelect: [ :node | 
		node settingReceiver = self and: [ 
			(node settingDeclaration name = #discordClientPassword) not ] ].
	self discordClientEmail: aDSClient email.
	self discordClientPassword: aDSClient password.
	self discordClientToken: aDSClient token.
	SystemSettingsPersistence storeSettingNodes: nodes.
]

{ #category : 'updating' }
DSClientSettings class >> updateSettings [
	"Load settings from the disk and update them in the image if they are not initialized."
	| tree nodes |
	tree := SystemSettingsPersistence default settingTree.
	nodes := tree deeplySelect: [ :node | node settingReceiver = self and: [ node realValue isEmptyOrNil ] ].
	SystemSettingsPersistence updateSettingNodes: nodes.

]
