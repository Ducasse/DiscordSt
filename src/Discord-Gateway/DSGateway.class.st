"
I am a abstract Discord Gateway API used for real-time communication.

Gateways are Discord's form of real-time communication over secure websockets. Clients will receive events and data over the gateway they are connected to and send data over the REST API.

See https://discordapp.com/developers/docs/topics/gateway#gateways

"
Class {
	#name : 'DSGateway',
	#superclass : 'Object',
	#traits : 'TAnnouncerSubscription',
	#classTraits : 'TAnnouncerSubscription classTrait',
	#instVars : [
		'announcer',
		'session',
		'restApiUrl',
		'websocketUrl',
		'websocket'
	],
	#category : 'Discord-Gateway-API',
	#package : 'Discord-Gateway',
	#tag : 'API'
}

{ #category : 'accessing' }
DSGateway class >> defaultClass [
	"Return default class responsible for Discord WebSocket and API communication."
	^ DSGatewaySix
]

{ #category : 'accessing' }
DSGateway >> announcer [
	"Return the actual Announcer."
	<return: #Announcer>
	^ announcer
]

{ #category : 'accessing' }
DSGateway >> announcer: anAnnouncer [
	"Set Announcer."
	announcer := anAnnouncer
]

{ #category : 'public' }
DSGateway >> connect [
	"Initialize the connection with the Discord Gateway.
	See https://discordapp.com/developers/docs/topics/gateway#connecting"
	self subclassResponsibility
]

{ #category : 'public' }
DSGateway >> disconnect [
	"Close the connection with the Discord Gateway.
	See https://discordapp.com/developers/docs/topics/gateway#connecting"
	self subclassResponsibility
]

{ #category : 'initialization' }
DSGateway >> initialize [
	super initialize.
	announcer := self newAnnouncer.
	websocket := self newGatewayWebsocket.
]

{ #category : 'testing' }
DSGateway >> isConnected [
	^ self websocket isConnected
]

{ #category : 'instance creation' }
DSGateway >> newAnnouncer [
	^ Announcer new
]

{ #category : 'instance creation' }
DSGateway >> newGatewayWebsocket [
	^ DSGatewayWebSocket new
]

{ #category : 'accessing' }
DSGateway >> restApiUrl [
	"Return a root Discord API URL."
	<return: #ZnUrl>
	^ restApiUrl ifNil: [ restApiUrl := DSConstants defaultRestApiSixUrl ]
]

{ #category : 'accessing' }
DSGateway >> restApiUrl: aZnUrl [ 
	restApiUrl := aZnUrl
]

{ #category : 'accessing' }
DSGateway >> session [
	"Get session object that keeps email, password and token for the Discord communication."
	<return: #DSSession>
	^ session
]

{ #category : 'accessing' }
DSGateway >> session: aDSSession [
	"Set session object that keeps email, password and token for the Discord communication."
	session := aDSSession
]

{ #category : 'accessing' }
DSGateway >> websocket [
	<return: #DSGatewayWebSocket>
	^ websocket
]

{ #category : 'accessing' }
DSGateway >> websocketUrl [
	"Returns an object with a single valid WSS URL, which the client can use as a basis for Connecting. 
	Clients should cache this value and only call this endpoint to retrieve a new URL 
	if they are unable to properly establish a connection using the cached version of the URL.
	
	This endpoint does not require any authentication.
	See https://discordapp.com/developers/docs/topics/gateway#get-gateway"
	<return: #ZnUrl>
	^ websocketUrl
]

{ #category : 'accessing' }
DSGateway >> websocketUrl: aZnUrl [
	"Set an object with a single valid WSS URL, which the client can use as a basis for Connecting. 
	Clients should cache this value and only call this endpoint to retrieve a new URL 
	if they are unable to properly establish a connection using the cached version of the URL.
	
	This endpoint does not require any authentication.
	See https://discordapp.com/developers/docs/topics/gateway#get-gateway"
	websocketUrl := aZnUrl
]
