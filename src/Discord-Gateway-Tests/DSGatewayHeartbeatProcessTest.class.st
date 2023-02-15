"
A DSGatewayHeartbeatProcessTest is a test class for testing the behavior of DSGatewayHeartbeatProcess
"
Class {
	#name : #DSGatewayHeartbeatProcessTest,
	#superclass : #DSGatewayProcessTest,
	#category : 'Discord-Gateway-Tests-API'
}

{ #category : #asserting }
DSGatewayHeartbeatProcessTest >> assertDelay: integerInMilliseconds between: startDateAndTime and: stopDateAndTime [
	"Assert that stopDateAndTime happens integerInMilliseconds milliseconds after startDateAndTime.	
	Difference (diff) should be positive or zero.
	We allow about 20% of tollerance (allowed)."
	| diff allowed |
	allowed := (integerInMilliseconds * 0.2) milliSeconds negated.
	diff := stopDateAndTime - startDateAndTime - integerInMilliseconds milliSeconds.
	self 
		assert: diff >= allowed
		description: 'The difference is ', diff printString, ', but should be >= ', allowed printString.
]

{ #category : #'instance creation' }
DSGatewayHeartbeatProcessTest >> newGatewayProcess [
	^ DSGatewayHeartbeatProcess new
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testHeartbeatString [
	"Heartbeat JSON object with default sequence number"
	process := self newGatewayProcess.
	self assert: process heartbeatString equals: '{"op":1}'.
	
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testHeartbeatString2 [
	"Heartbeat JSON object with default sequence number"
	process := self newGatewayProcess.
	process sequenceNumber: 2.
	self assert: process heartbeatString equals: '{"op":1,"d":2}'.
	
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testSendHeartbeat [
	"Send one heartbeat message to a server"
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #server.
		self serverRequests add: socket readMessage.
		self serverRequests add: #finished.
		self signalServerSemaphore. ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process sendHeartbeat.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 3.
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testSequenceNumber [
	"Set sequence number"
	process := self newGatewayProcess.
	process sequenceNumber: 42.
	self assert: process sequenceNumber equals: 42.
	self assert: process heartbeatString equals: '{"op":1,"d":42}'.
	
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testStart [
	"Do three heartbeat cycles and then close the connection"
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #readOne.
		self serverRequests add: socket readMessage.
		self serverRequests add: #readTwo.
		self serverRequests add: socket readMessage.
		self serverRequests add: #readThree.
		self serverRequests add: socket readMessage.
		self serverRequests add: #finished.
		socket close.
		self signalServerSemaphore ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process heartbeatInterval: 10.
	process start.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 7.
	self 
		assert: self serverRequests asArray 
		equals: #( #readOne '{"op":1}' #readTwo '{"op":1}' #readThree '{"op":1}' #finished ).
]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testStartDelays [
	"Check delays between three heartbeat cycles"
	| heartbeatInterval |
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: DateAndTime now.
		socket readMessage.
		self serverRequests add: DateAndTime now.
		socket readMessage.
		self serverRequests add: DateAndTime now.
		socket readMessage.
		self serverRequests add: DateAndTime now.
		socket close.
		self signalServerSemaphore ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	heartbeatInterval := 300.
	process heartbeatInterval: heartbeatInterval.
	process start.
	self serverSemaphoreTimeout: heartbeatInterval * 5.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 4.
	self assertDelay: heartbeatInterval between: self serverRequests first and: self serverRequests second.
	self assertDelay: heartbeatInterval between: self serverRequests second and: self serverRequests third.
	self assertDelay: heartbeatInterval between: self serverRequests third and: self serverRequests fourth.

]

{ #category : #tests }
DSGatewayHeartbeatProcessTest >> testStop [
	"Do three heartbeat cycles and then close the connection"
	| semaphore |
	semaphore := Semaphore new.
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		self serverRequests add: #server.
		self serverRequests add: socket readMessage.
		self serverRequests add: #waiting.
		self signalServerSemaphore.
		self deny: (semaphore waitTimeoutMSecs: 100).
		self serverRequests add: #finished.
		self signalServerSemaphore. ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process heartbeatInterval: 10.
	process start.
	self assertServerSemaphore.
	process stop.
	semaphore signal.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 4.
	self 
		assert: self serverRequests asArray 
		equals: #( #server '{"op":1}' #waiting #finished ).
	self deny: process canDoNextCycle.

]
