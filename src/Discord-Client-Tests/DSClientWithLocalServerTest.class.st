"
A DSClientWithLocalServerTest is a test class for testing the behavior of DSClient.
I test behavior that not requiere connection with a real Discord server.
I test behavior that requiere connection with a Mock Local ZnServer.

"
Class {
	#name : #DSClientWithLocalServerTest,
	#superclass : #DSClientTestCase,
	#instVars : [
		'client',
		'websocketDelegate'
	],
	#category : 'Discord-Client-Tests'
}

{ #category : #initialization }
DSClientWithLocalServerTest >> setUp [
	super setUp.
	self startZnServer.
	websocketDelegate := ZnWebSocketDelegate new.
	self serverDelegate
		map: '/api/gateway'
			to: [ :request :response | 
			self serverRequests add: #apiGateway.
			response entity: (ZnEntity text: self gatewayUrlMessage) ];
		map: '/gateway'
			to: [ :request :response | websocketDelegate handleRequest: request ].
	"Configure the client"
	client := self newClient.
	client restApi apiUrl: self apiUrl.
	client gateway restApiUrl: self apiUrl.
	client token: self token
]

{ #category : #tests }
DSClientWithLocalServerTest >> testLogin [
	self serverDelegate map: '/api/auth/login' to: [ :request :response |
		self serverRequests add: #login.
		response entity: (ZnEntity text: '{"token":"secret-token"}') ].
	client announcer 
		when: DSAuthenticatedAnnouncement 
		do: [ :announcement | self serverRequests add: announcement. self signalServerSemaphore ]. 
	client login.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 2.
	self assert: self serverRequests first equals: #login.
	self assert: self serverRequests second class equals: DSAuthenticatedAnnouncement.
]

{ #category : #tests }
DSClientWithLocalServerTest >> testMessageCreateEvent [
	websocketDelegate handler: [ :socket |
		socket sendMessage: self gatewayModelJsonMapping jsonMessageCreatePayload ].
	client announcer 
		when: DSGatewayMessageCreateAnnouncement  
		do: [ :announcement | self serverRequests add: announcement. self signalServerSemaphore ]. 
	client connect.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 2.
	self assert: self serverRequests first equals: #apiGateway.
	self assert: self serverRequests second class equals: DSGatewayMessageCreateAnnouncement.
]

{ #category : #tests }
DSClientWithLocalServerTest >> testMessageUpdateEvent [
	"I have received 
	DSUnauthorizedOperationError: {""code"": 20002, ""message"": ""Only bots can use this endpoint""}
	when asking for the message. So let's dicable it for now and suppose that Gateway returns 
	whole message for real users."
	websocketDelegate handler: [ :socket |
		socket sendMessage: self gatewayModelJsonMapping jsonMessageUpdatePayload ].
	self serverDelegate map: '/api/channels/5930/messages/36576' to: [ :request :response |
		self serverRequests add: #message.
		response entity: (ZnEntity text: self messageObjectString) ].
	client announcer 
		when: DSGatewayMessageUpdateAnnouncement  
		do: [ :announcement | self serverRequests add: announcement. self signalServerSemaphore ]. 
	client connect.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 2.
	self assert: self serverRequests first equals: #apiGateway.
	self assert: self serverRequests second class equals: DSGatewayMessageUpdateAnnouncement.
]

{ #category : #tests }
DSClientWithLocalServerTest >> testReadyEvent [
	websocketDelegate handler: [ :socket |
		socket sendMessage: self gatewayModelJsonMapping jsonReadyPayload ].
	client announcer 
		when: DSGatewayReadyAnnouncement
		do: [ :announcement | self serverRequests add: announcement. self signalServerSemaphore ]. 
	client connect.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 2.
	self assert: self serverRequests first equals: #apiGateway.
	self assert: self serverRequests second class equals: DSGatewayReadyAnnouncement.
]
