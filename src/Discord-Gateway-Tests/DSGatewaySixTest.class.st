"
A DSGatewayApiSixTest is a test class for testing the behavior of DSGatewayApiSix
"
Class {
	#name : 'DSGatewaySixTest',
	#superclass : 'DSGatewayTest',
	#category : 'Discord-Gateway-Tests-API',
	#package : 'Discord-Gateway-Tests',
	#tag : 'API'
}

{ #category : 'running' }
DSGatewaySixTest >> classToTest [
	^ DSGatewaySix
]

{ #category : 'instance creation' }
DSGatewaySixTest >> newGateway [
	^ self classToTest new
]

{ #category : 'running' }
DSGatewaySixTest >> tearDown [
	server ifNotNil: #stop.
	api ifNotNil: [ :anApi | [ anApi websocket ifNotNil: #close ] on: ConnectionClosed, ConnectionTimedOut do: [ "ignore" ] ].
	super tearDown.
]

{ #category : 'tests' }
DSGatewaySixTest >> testConnect [
	"Connect using a gateway websocket URL"
	self startZnServer.
	self serverDelegate 
		map: '/api/gateway' to: [ :request :response | 
			self serverRequests add: #apiGateway.
			response entity: (ZnEntity text: self gatewayUrlMessage) ];
		map: '/gateway' to: [ :request :response | (ZnWebSocketDelegate handler: [ :webSocket | 
		self serverRequests add: #hello.
		webSocket sendMessage: DSGatewayModelJsonMapping jsonHelloPayload.
		self serverRequests add: #identify.
		webSocket readMessage.
		self serverRequests add: #ready.
		webSocket sendMessage: DSGatewayModelJsonMapping jsonReadyPayload.
		self serverRequests add: #finished.
		self signalServerSemaphore ]) handleRequest: request ].
	api := self newGateway. 
	api session: (DSSession new token: self tokenString; yourself).
	api restApiUrl: self apiUrl.
	api when: DSGatewayReadyAnnouncement do: [ :ann | 
		self serverRequests add: ann. self signalServerSemaphore ].
	self defaultConnectionTimeoutDuring: [ api connect ].
	self assertServerSemaphore.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 6.
	self assert: self serverRequests first equals: #apiGateway.
	self assert: self serverRequests second equals: #hello.
	self assert: self serverRequests third equals: #identify.
	self assert: self serverRequests fourth equals: #ready.
	self assert: self serverRequests fifth equals: #finished.
	self assert: self serverRequests sixth class equals: DSGatewayReadyAnnouncement.
	self assert: api heartbeatInterval equals: 41250.
	self assert: api sessionId equals: 21.
	self assert: api sequenceNumber equals: 2.
	self assert: api websocket notNil.

]

{ #category : 'tests' }
DSGatewaySixTest >> testGetWebSocketUrl [
	"Ask for a gateway websocket URL"
	| url |
	self startZnServer.
	self serverDelegate map: '/api/gateway' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"url": "wss://gateway.discord.gg"}') ].
	api := self newGateway. 
	api restApiUrl: self apiUrl.
	url := api getWebsocketUrl.
	self assert: url equals: 'wss://gateway.discord.gg/?v=6&enconding=json' asZnUrl.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents isNil.
	self assert: self serverRequests first method equals: #GET.
]
