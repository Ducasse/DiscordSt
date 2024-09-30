"
A DSGatewayProcessTest is a test class for testing the behavior of DSGatewayProcess
"
Class {
	#name : 'DSGatewayProcessTest',
	#superclass : 'DSGatewayTestCase',
	#instVars : [
		'process',
		'websocket'
	],
	#category : 'Discord-Gateway-Tests-API',
	#package : 'Discord-Gateway-Tests',
	#tag : 'API'
}

{ #category : 'testing' }
DSGatewayProcessTest class >> isAbstract [
	^ self = DSGatewayProcessTest 
]

{ #category : 'instance creation' }
DSGatewayProcessTest >> newGatewayProcess [
	^ self subclassResponsibility 
]

{ #category : 'running' }
DSGatewayProcessTest >> tearDown [
	websocket ifNotNil: [ :aWebSocket | [ aWebSocket close ] 
		on: ConnectionTimedOut, ConnectionClosed do: [ "ignore" ] ].
	super tearDown
]

{ #category : 'tests' }
DSGatewayProcessTest >> testCanDoNextCycle [
	"Heartbeat is not allowed by default, because of missing WebSocket"
	process := self newGatewayProcess.
	self deny: process canDoNextCycle
]

{ #category : 'tests' }
DSGatewayProcessTest >> testCanDoNextCycleFalse [
	"Heartbeat is not allowed by default, because of disconnected WebSocket"
	process := self newGatewayProcess.
	process websocket: ZnWebSocket new.
	self deny: process canDoNextCycle
]

{ #category : 'tests' }
DSGatewayProcessTest >> testCanDoNextCycleTrue [
	"Heartbeat is allowed by default, because of connected WebSocket"
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #server ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	self assert: process canDoNextCycle.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first equals: #server.	
	
]

{ #category : 'tests' }
DSGatewayProcessTest >> testDisableNextCycle [
	"Heartbeat is not allowed explicitly"
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #server ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process disableNextCycle.
	self deny: process canDoNextCycle.
	
]

{ #category : 'tests' }
DSGatewayProcessTest >> testDisableNextCycleExplicitly [
	"Next Cycle is not allowed explicitly"
	process := self newGatewayProcess.
	process disableNextCycle.
	self deny: process canDoNextCycle.
	
]

{ #category : 'tests' }
DSGatewayProcessTest >> testIsConnected [
	process := self newGatewayProcess.
	self deny: process isConnected.
]

{ #category : 'tests' }
DSGatewayProcessTest >> testIsConnectedFalse [
	process := self newGatewayProcess.
	process websocket: ZnWebSocket new.
	self deny: process isConnected.
]

{ #category : 'tests' }
DSGatewayProcessTest >> testIsConnectedTrue [
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #server ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	self assert: process isConnected.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first equals: #server.
]

{ #category : 'tests' }
DSGatewayProcessTest >> testPrintProcessName [
	process := self newGatewayProcess.
	self assert: process printProcessName isNotEmpty
]

{ #category : 'tests' }
DSGatewayProcessTest >> testPrintString [
	process := self newGatewayProcess.
	self assert: process printString isNotEmpty
]

{ #category : 'tests' }
DSGatewayProcessTest >> testStart [
	"Subtest should define this test case."
	^ self subclassResponsibility
]

{ #category : 'tests' }
DSGatewayProcessTest >> testStop [
	"Start a server, then stop it"
	self subclassResponsibility
]
