"
I am an abstract class representing actions that subclasses should implement.

My subclasses knows how to communicate with a Discord server.
"
Class {
	#name : #DSRestApi,
	#superclass : #Object,
	#instVars : [
		'session',
		'cache'
	],
	#category : 'Discord-Core-REST-Api'
}

{ #category : #defaults }
DSRestApi class >> defaultClass [
	"Return default class responsible for Discord WebSocket and API communication."
	^ self subclasses detectMax: #versionNumber
]

{ #category : #testing }
DSRestApi class >> isAbstract [
	^ self = DSRestApi
]

{ #category : #accessing }
DSRestApi class >> jsonMappingClass [
	"Return Model-JSON mapping class, that is able to read and write JSON representations."
	^ DSModelJsonMapping
]

{ #category : #defaults }
DSRestApi class >> userAgent [
	"Return a correct User Agent.
	See https://discordapp.com/developers/docs/reference#user-agent"
	^ DSConstants userAgent
]

{ #category : #accessing }
DSRestApi class >> versionNumber [
	<return: #Number>
	^ self subclassResponsibility
]

{ #category : #defaults }
DSRestApi class >> versionString [
	"Return version number of this implementation."
	^ DSConstants version 
]

{ #category : #accessing }
DSRestApi >> cache [
	"Return dictionary that serves as a cache."
	^ cache ifNil: [ cache := SmallDictionary new ]
]

{ #category : #'accessing - cache' }
DSRestApi >> cacheAt: key [
	"Return value at key or nil."
	^ self cache at: key ifAbsent: nil
]

{ #category : #'accessing - cache' }
DSRestApi >> cacheAt: key ifAbsentPut: absentBlock [ 
	"Return the value at the given key.
	If the key is not included in the receiver store and return the result 
	of evaluating aBlock as the new value."
	^ self cache at: key ifAbsentPut: absentBlock
]

{ #category : #'accessing - cache' }
DSRestApi >> cacheAt: key put: value [
	"Put value at key."
	^ self cache at: key put: value
]

{ #category : #'public - user' }
DSRestApi >> directChannels [
	"Return collection of dirrect channels"
	<return: #DSChannels of: #DSDirectMessageChannel>
	^ self subclassResponsibility
]

{ #category : #'public - user' }
DSRestApi >> directMessageWith: aDSUser [
	"Create a new DM channel with a user. Returns a DM channel object."
	<return: #DSDirectMessageChannel>
	^ self subclassResponsibility
]

{ #category : #accessing }
DSRestApi >> email [
	"Get email or nil used to login into a Discord server."
	^ self session email
]

{ #category : #convenient }
DSRestApi >> email: emailString password: passwordString [ 
	"Set email and password used to login into a Discord server."
	self session email: emailString password: passwordString
]

{ #category : #public }
DSRestApi >> guildChannelsOf: aDSUserGuild [
	"Return Guild Channel objects.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
	^ self subclassResponsibility
]

{ #category : #public }
DSRestApi >> guildChannelsUsingId: guildId [
	"Returns a list of guild channel objects.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
]

{ #category : #testing }
DSRestApi >> isAuthenticated [
	"Return true if the client was previously authenticated successfully."
	^ self session isAuthenticated
]

{ #category : #public }
DSRestApi >> login [
	"Login to Discord. 
	Raise DSCannotLogin on incorrect email or password.
	Raise NetworkError on any network problem."
	self subclassResponsibility 
]

{ #category : #public }
DSRestApi >> logout [
	"Logout from Discord."
	self subclassResponsibility
]

{ #category : #'public - user' }
DSRestApi >> me [
	"Return User object that identyfies the logged user.
	See https://discordapp.com/developers/docs/resources/user#user-object"
	<return: #DSUser>
	^ self subclassResponsibility
]

{ #category : #'public - user' }
DSRestApi >> meGuilds [
	"Returns a list of user guild objects the current user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	<return: #DSGuilds of: #DSGuild>
	^ self subclassResponsibility
]

{ #category : #'public - channel' }
DSRestApi >> messageBuilder [
	"Return a builder to compose a user message.
	For the message structure, see https://discordapp.com/developers/docs/resources/channel#create-message"
	^ self subclassResponsibility
]

{ #category : #'public - channel' }
DSRestApi >> messagesAfter: aDSMessage inChannel: aDSGuildTextChannel [ 
	"Return a collection of messages for a given channel 
	that are newwer then the given message."
	<return: #DSMessages of: #DSMessage>
	^ self subclassResponsibility
]

{ #category : #'public - channel' }
DSRestApi >> messagesBefore: aDSMessage inChannel: aDSGuildTextChannel [ 
	"Return a collection of messages for a given channel 
	that are older then the given message."
	<return: #DSMessages of: #DSMessage>
	^ self subclassResponsibility
]

{ #category : #'public - channel' }
DSRestApi >> messagesForChannel: aChannel [
	"Return a collection of messages for a given channel"
	<return: #DSMessages of: #DSMessage>
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
DSRestApi >> newSession [
	^ DSSession new
]

{ #category : #accessing }
DSRestApi >> password [
	"Get password or nil used to login into a Discord server."
	^ self session password
]

{ #category : #accessing }
DSRestApi >> resetCache [
	"Reset current cache"
	cache := nil
]

{ #category : #'public - channel' }
DSRestApi >> sendMessage: aDSClientPost answering: aDSMessage signalProgress: aBoolean [
	"Send a message to the same text Guild or DM channel as given aDSMessage.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage>
	^ self subclassResponsibility
]

{ #category : #'public - channel' }
DSRestApi >> sendMessage: aDSClientJsonPost toChannel: aDSChannel [
	"Send a message to the particular text Guild or DM channel.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage>
	^ self sendMessage: aDSClientJsonPost toChannel: aDSChannel signalProgress: false

]

{ #category : #'public - channel' }
DSRestApi >> sendMessage: aDSClientJsonPost toChannel: aDSChannel signalProgress: aBoolean [
	"Send a message to the particular text Guild or DM channel.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage>
	^ self subclassResponsibility
]

{ #category : #accessing }
DSRestApi >> session [
	"Get session object that keeps email, password and token for the Discord communication."
	^ session ifNil: [ session := self newSession ]
]

{ #category : #accessing }
DSRestApi >> token [
	"Get token used to authorize Discord opperations."
	^ self session token
]

{ #category : #accessing }
DSRestApi >> token: aString [
	"Set token used to authorize Discord opperations."
	self session token: aString
]

{ #category : #public }
DSRestApi >> userAvatarUrl: aDSUser [ 
	"Return a user's avatar URL. 
	Return nil if the user has no avatar."
	^ self subclassResponsibility
]
