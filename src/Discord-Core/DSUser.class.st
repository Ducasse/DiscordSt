"
I represent a Discord user. 
See https://discordapp.com/developers/docs/resources/user#user-object

Field	Type	Description	Required OAuth2 Scope
id	snowflake	the user's id	identify
username	string	the user's username, not unique across the platform	identify
discriminator	string	the user's 4-digit discord-tag	identify
avatar	string	the user's avatar hash	identify
bot?	bool	whether the user belongs to an OAuth2 application	identify
mfa_enabled?	bool	whether the user has two factor enabled on their account	identify
verified?	bool	whether the email on this account has been verified	email
email?	string	the user's email	email

"
Class {
	#name : 'DSUser',
	#superclass : 'DSObject',
	#instVars : [
		'restApi',
		'id',
		'username',
		'discriminator',
		'avatarHash',
		'isBot',
		'isMfaEnabled',
		'isVerified',
		'email'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'examples' }
DSUser class >> alice [
	<gtExample>
	^ self new
		id: '308348260000056432';
		discriminator: '3409';
		username: 'Alice';
		yourself
]

{ #category : 'converting' }
DSUser >> asAuthor [
	"Return a copy with a basic information, necessary to identify a message author."
	^ self class new
		id: self id;
		avatarHash: self avatarHash;
		discriminator: self discriminator;
		username: self username;
		yourself
]

{ #category : 'accessing' }
DSUser >> avatarHash [
	^ avatarHash
]

{ #category : 'accessing' }
DSUser >> avatarHash: anObject [
	avatarHash := anObject
]

{ #category : 'accessing - convenience' }
DSUser >> avatarUrl [
	"Return a user's avatar URL. 
	Return nil if the user has no avatar."
	^ self restApi userAvatarUrl: self
]

{ #category : 'accessing' }
DSUser >> children [
	^ #()
]

{ #category : 'accessing - convenience' }
DSUser >> directChannels [
	"Return collection of dirrect channels"
	<return: #DSChannels of: #DSDirectMessageChannel>
	^ self restApi directChannels
]

{ #category : 'accessing' }
DSUser >> discriminator [
	^ discriminator
]

{ #category : 'accessing' }
DSUser >> discriminator: anObject [
	discriminator := anObject
]

{ #category : 'accessing' }
DSUser >> email [
	^ email
]

{ #category : 'accessing' }
DSUser >> email: anObject [
	email := anObject
]

{ #category : 'gt-inspector-extension' }
DSUser >> gtInspectorDirectChannels: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
		title: [ 'Direct Channels' translated ];
		display: [ self directChannels ];
		when: [ self directChannels notEmpty ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : 'testing' }
DSUser >> hasAvatar [
	"Return true if user has avatar."
	^ self avatarHash notNil
]

{ #category : 'accessing' }
DSUser >> id [
	^ id
]

{ #category : 'accessing' }
DSUser >> id: anObject [
	id := anObject
]

{ #category : 'gt-inspector-extension' }
DSUser >> initialize [
	super initialize.
	restApi := DSRestBasic uniqueInstance.
]

{ #category : 'accessing' }
DSUser >> isBot [
	^ isBot ifNil: false
]

{ #category : 'accessing' }
DSUser >> isBot: anObject [
	isBot := anObject
]

{ #category : 'accessing' }
DSUser >> isMfaEnabled [
	"Multi-factor authentication (MFA) is a method of computer access control in which a user is granted access only after successfully presenting several separate pieces of evidence to an authentication mechanism"
	^ isMfaEnabled
]

{ #category : 'accessing' }
DSUser >> isMfaEnabled: anObject [
	isMfaEnabled := anObject
]

{ #category : 'testing' }
DSUser >> isUser [
	^ true
]

{ #category : 'accessing' }
DSUser >> isVerified [
	^ isVerified ifNil: false
]

{ #category : 'accessing' }
DSUser >> isVerified: anObject [
	isVerified := anObject
]

{ #category : 'accessing' }
DSUser >> members [
	"Convenience method for tree views"
	^ self children
]

{ #category : 'accessing - convenience' }
DSUser >> message [
	^ (self restApi directMessageWith: self) message
]

{ #category : 'accessing' }
DSUser >> name [
	^ self username
]

{ #category : 'printing' }
DSUser >> printOn: aStream [
	aStream << 'User: '.
	self username 
		ifNotNil: [ :string | aStream << string ]
		ifNil: [ aStream << '<nameless>' ].
	self isBot
		ifTrue: [ aStream << ' (bot)' ].
	
]

{ #category : 'accessing' }
DSUser >> restApi [
	^ restApi
]

{ #category : 'accessing' }
DSUser >> restApi: anObject [
	restApi := anObject
]

{ #category : 'accessing' }
DSUser >> username [
	^ username
]

{ #category : 'accessing' }
DSUser >> username: anObject [
	username := anObject
]
