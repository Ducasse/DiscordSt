"
I represent Discord message builder.
I know how to compose message, that can include
	- a simple text content
	- an embed object
	- and attachments
	
I can be used for composing one message at a time.
	
I collaborate with DSClientPost and its subclasses that know how to prepare an HTTP request (as a JSON payload string or as a byte arrray).

I am used by DSClient and I use the client to send a message.

Public API and Key Messages

- channel : 	- set the channel object where a particular message is going to be sent
- send, sendTo:, sendToServer:channel: - send a composed message to a specific channel
- for composing a message, check ""protocol - *"".
 
Internal Representation and Key Implementation Points.

    Instance Variables
	channel:		<DSGuildChannel>
	client:		<DSClient>
	post:		<DSClientPost>

"
Class {
	#name : #DSClientPostBuilder,
	#superclass : #DSObject,
	#traits : 'TDSClientPostBuilder + TDSUnifiedPublishInterface',
	#classTraits : 'TDSClientPostBuilder classTrait + TDSUnifiedPublishInterface classTrait',
	#instVars : [
		'post',
		'channel',
		'signalProgress',
		'restApi'
	],
	#category : 'Discord-Client'
}

{ #category : #accessing }
DSClientPostBuilder >> channel [
	^ channel
]

{ #category : #accessing }
DSClientPostBuilder >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
DSClientPostBuilder >> embed [
	"Create an embed object if necessary and return it."
	<return: #DSEmbed>
	^ self post embed
		ifNil: [ self post embed: self newEmbed; embed ]
]

{ #category : #'protocol - embed' }
DSClientPostBuilder >> embeds [
	"Return a collection of embed objects"
	<return: #Array of: #DSEmbed>
	^ self post embed ifNil: [ #() ] ifNotNil: [ :anEmbed | Array with: anEmbed ]
]

{ #category : #'gt-inspector-extension' }
DSClientPostBuilder >> gtChildren [
	^ { self post. self channel } reject: #isNil
]

{ #category : #initialization }
DSClientPostBuilder >> initialize [
	super initialize.
	post := self newJSONPost.
	signalProgress := false.
]

{ #category : #'instance creation' }
DSClientPostBuilder >> newJSONPost [
	^ DSClientJsonPost new
]

{ #category : #private }
DSClientPostBuilder >> post [
	"Return a post object."
	<return: #DSClientPost>
	^ post
]

{ #category : #private }
DSClientPostBuilder >> post: aPost [
	"Set a post object."
	post := aPost
]

{ #category : #'protocol - sending' }
DSClientPostBuilder >> respondTo: aDSMessage [ 
	<return: #DSMessage or: nil>
	self post isEmpty ifTrue: [ DSIncorrectValuesError signal: 'Cannot send an empty message' ].
	^ [ self restApi
			sendMessage: post
			answering: aDSMessage
			signalProgress: self signalProgress ]
		ensure: [ post := nil ].
]

{ #category : #accessing }
DSClientPostBuilder >> restApi [
	^ restApi
]

{ #category : #accessing }
DSClientPostBuilder >> restApi: anObject [
	restApi := anObject
]

{ #category : #'protocol - sending' }
DSClientPostBuilder >> send [
	"Send a message to the particular text Guild or DM channel.
	It returns the sent message.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage or: nil>
	self post isEmpty ifTrue: [ DSIncorrectValuesError signal: 'Cannot send an empty message' ].
	^ [ self restApi
			sendMessage: post
			toChannel: self channel
			signalProgress: self signalProgress ]
		ensure: [ post := nil ].
]

{ #category : #'protocol - sending' }
DSClientPostBuilder >> sendTo: aDSGuildTextChannelOrOneArgBlock [
	"Send a message to the particular text Guild or DM channel.
	If the parameter is a block, then the block expects collection of servers.
	The block should return a aDSGuildTextChannel.
	It returns the sent message.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage or: nil> 
	aDSGuildTextChannelOrOneArgBlock isClosure 
		ifTrue: [ self target: (aDSGuildTextChannelOrOneArgBlock value: self servers) ]
		ifFalse: [ self target: aDSGuildTextChannelOrOneArgBlock ].
	^ self send
]

{ #category : #'protocol - sending' }
DSClientPostBuilder >> sendToServer: serverName channel: channelName [ 
	"Send a message to the particular text Guild or DM channel of the given channelName.
	The channel is part of a server of the given name.
	It returns the sent message. 
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	^ self sendTo: [ :servers | (servers named: serverName) channelNamed: channelName ]
]

{ #category : #accessing }
DSClientPostBuilder >> servers [
	"Return a collection of Guilds (servers)."
	<return: #DSGuilds>
	^ self restApi meGuilds
]

{ #category : #accessing }
DSClientPostBuilder >> signalProgress [
	^ signalProgress
]

{ #category : #accessing }
DSClientPostBuilder >> signalProgress: anObject [
	signalProgress := anObject
]

{ #category : #'protocol - sending' }
DSClientPostBuilder >> target: aChannel [
	"Set a target where a particular message should be sent.
	In case of Webhooks it is a Webhook URL.
	In case of Bots and User Clients it is a Channel object."
	self channel: aChannel
]
