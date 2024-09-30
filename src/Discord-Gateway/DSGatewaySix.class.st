"
I am a Discord Gateway API used for real-time communication.
I represent the version five of the Discord API.

Gateways are Discord's form of real-time communication over secure websockets. Clients will receive events and data over the gateway they are connected to and send data over the REST API.

See https://discordapp.com/developers/docs/topics/gateway#gateways

"
Class {
	#name : 'DSGatewaySix',
	#superclass : 'DSGateway',
	#instVars : [
		'heartbeatProcess',
		'readingProcess',
		'receiver'
	],
	#category : 'Discord-Gateway-API',
	#package : 'Discord-Gateway',
	#tag : 'API'
}

{ #category : 'accessing' }
DSGatewaySix >> announcer: anAnnouncer [
	super announcer: anAnnouncer.
	receiver announcer: anAnnouncer.
]

{ #category : 'public' }
DSGatewaySix >> connect [
	"Initialize the connection with the Discord Gateway.
	See https://discordapp.com/developers/docs/topics/gateway#connecting"
	self session isAuthenticated ifFalse: [ 
		DSTokenRequiredError signal: 'Cannot authorize the client.' ].
	"Connect"
	self ensureConnectedWebSocket.
	self startReadingProcesses.
	
]

{ #category : 'public' }
DSGatewaySix >> disconnect [
	"Close the connection with the Discord Gateway.
	Stop Heartbeat and Reading processes.
	See https://discordapp.com/developers/docs/topics/gateway#connecting"
	heartbeatProcess stop.
	readingProcess stop.
	websocket close.
]

{ #category : 'private' }
DSGatewaySix >> ensureConnectedWebSocket [
	"Establish the WebSocket with a Discord Gateway. 
	The api object knows the URL. I set
	See https://discordapp.com/developers/docs/topics/gateway#get-gateway"
	self isConnected ifTrue: [ ^ self ].
	self websocketUrl ifNil: [ self websocketUrl: self getWebsocketUrl ].
	self websocket websocket: (ZnWebSocket to: self websocketUrl).
]

{ #category : 'private - accessing' }
DSGatewaySix >> getWebsocketUrl [
	"Returns an object with a single valid WSS URL, which the client can use as a basis for Connecting. 
	Clients should cache this value and only call this endpoint to retrieve a new URL 
	if they are unable to properly establish a connection using the cached version of the URL.
	
	This endpoint does not require any authentication.
	See https://discordapp.com/developers/docs/topics/gateway#get-gateway"
	^ DSGatewayGetGatewaySixUrlCommand new
		restApiUrl: self restApiUrl;
		execute;
		websocketUrl
]

{ #category : 'as yet unclassified' }
DSGatewaySix >> heartbeatInterval [
	"For testing purpose only."
	
	^ heartbeatProcess heartbeatInterval
]

{ #category : 'initialization' }
DSGatewaySix >> initialize [
	super initialize.
	readingProcess := DSGatewayReadingProcess new.
	heartbeatProcess := DSGatewayHeartbeatProcess new.
	heartbeatProcess websocket: self websocket.
	receiver := DSGatewayMessageReceiver new.
	receiver
		websocket: self websocket;
		heartbeatProcess: heartbeatProcess;
		announcer: self announcer.
	readingProcess 
		websocket: self websocket;
		receiver: receiver.
]

{ #category : 'as yet unclassified' }
DSGatewaySix >> sequenceNumber [
	"For testing purpose only."

	^ heartbeatProcess sequenceNumber
]

{ #category : 'accessing' }
DSGatewaySix >> session: aDSSession [
	"Set session object that keeps email, password and token for the Discord communication."
	super session: aDSSession.
	receiver session: aDSSession.
]

{ #category : 'as yet unclassified' }
DSGatewaySix >> sessionId [
	"For testing purpose only"

	^ receiver sessionId 
]

{ #category : 'private' }
DSGatewaySix >> startReadingProcesses [
	"Start Reading processes.
	Reading process reads all events and requests from the Gateway server."
	readingProcess start.
]
