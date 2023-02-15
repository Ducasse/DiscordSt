"
A DSGatewayReadingProcessTest is a test class for testing the behavior of DSGatewayReadingProcess
"
Class {
	#name : #DSGatewayReadingProcessTest,
	#superclass : #DSGatewayProcessTest,
	#category : 'Discord-Gateway-Tests-API'
}

{ #category : #'instance creation' }
DSGatewayReadingProcessTest >> newGatewayProcess [
	^ DSGatewayReadingProcess new.
]

{ #category : #tests }
DSGatewayReadingProcessTest >> testMessageReceived [
	| received |
	process := self newGatewayProcess.
	received := nil.
	process receiver: [ :value | received := value. ].
	process messageReceived: 42.
	self assert: received equals: 42.
]

{ #category : #tests }
DSGatewayReadingProcessTest >> testMessageReceivedUnhandledError [
	| received |
	process := self newGatewayProcess.
	received := nil.
	process receiver: [ :value | received := value. Error signal ].
	self should: [ process messageReceived: 42 ] raise: Error.
	self assert: received equals: 42.
]

{ #category : #tests }
DSGatewayReadingProcessTest >> testStart [
	"Do three reading cycles and then close the connection"
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		socket 
			sendMessage: '21';
			sendMessage: '42';
			sendMessage: '108' ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process receiver: [ :message | self serverRequests add: message. self signalServerSemaphore ].
	process start.
	self assertServerSemaphore.
	self assertServerSemaphore.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 3.
	self 
		assert: self serverRequests asArray 
		equals: #( '21' '42' '108' ).
]

{ #category : #tests }
DSGatewayReadingProcessTest >> testStop [
	"Do three reading cycles and then close the connection"
	| semaphore |
	semaphore := Semaphore new.
	self startZnServer.
	self serverDelegate: (ZnWebSocketDelegate map: 'gateway' to: [ :socket |
		socket sendMessage: '21'.
		self deny: (semaphore waitTimeoutMSecs: 100).
		self serverRequests add: #finished.
		self signalServerSemaphore ]).
	websocket := ZnWebSocket to: self gatewayConnectUrl.
	process := self newGatewayProcess.
	process websocket: websocket.
	process receiver: [ :message | self serverRequests add: message. self signalServerSemaphore ].
	process start.
	self assertServerSemaphore.
	process stop.
	semaphore signal.
	self assertServerSemaphore.
	self assert: self serverRequests size equals: 2.
	self 
		assert: self serverRequests asArray 
		equals: #( '21' #finished ).
]
