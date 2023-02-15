"
I am responsible for receiving and processing the Discrod Gateway messages. I receive the messages in value: message. 

I know how to transform messages to objects.

DSGatewayReadingProcess used me and send me all the received messages.

Public API and Key Messages

- value: - receive the Discord Gateway message and process it
- websocket: - set the Discord Gateway WebSocket object.

Internal Representation and Key Implementation Points.

    Instance Variables
	websocket:		<DSGatewayWebSocket>

"
Class {
	#name : #DSGatewayMessageReceiver,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'session',
		'websocket',
		'heartbeatProcess',
		'sessionId'
	],
	#category : 'Discord-Gateway-API'
}

{ #category : #accessing }
DSGatewayMessageReceiver >> announcer [
	^ announcer
]

{ #category : #accessing }
DSGatewayMessageReceiver >> announcer: anObject [
	announcer := anObject
]

{ #category : #testing }
DSGatewayMessageReceiver >> hasSessionId [
	^ self sessionId notNil
]

{ #category : #accessing }
DSGatewayMessageReceiver >> heartbeatProcess [
	<return: #DSGatewayHeartbeatProcess>
	^ heartbeatProcess
]

{ #category : #accessing }
DSGatewayMessageReceiver >> heartbeatProcess: anObject [
	heartbeatProcess := anObject
]

{ #category : #'private - actions' }
DSGatewayMessageReceiver >> sendIdentifyCode [
	"Send the OP 2 Identify message to a Discord Gateway."
	| payload |
	payload := DSGatewayIdentityPayload new
		eventData: (DSGatewayIdentityEvent new
			token: self token;
			properties: DSGatewayIdentityProperties new;
			compress: false;
			largeThreshold: 250;
			yourself);
		yourself.
	self sendMessage: payload.	
]

{ #category : #'private - actions' }
DSGatewayMessageReceiver >> sendIdentifyCodeAfterAWhile [
	"It's also possible that your client cannot reconnect in time to resume, 
	in which case the client will receive a OP 9 Invalid Session and 
	is expected to wait a random amount of time (between 1 and 5 seconds), 
	then send a fresh OP 2 Identify."
	5 atRandom seconds wait. 
	self sendIdentifyCode.
]

{ #category : #'private - actions' }
DSGatewayMessageReceiver >> sendMessage: aGatewayPayload [
	| jsonString |
	jsonString := DSGatewayModelJsonMapping writePayload: aGatewayPayload.
	self websocket sendMessage: jsonString.	
]

{ #category : #'private - actions' }
DSGatewayMessageReceiver >> sendResumeCode [
	"Send the OP 6 Resume message to a Discord Gateway."
	| payload |
	payload := DSGatewayResumePayload new
		eventData: (DSGatewayResumeEvent new
			token: self token;
			sequenceNumber: self sequenceNumber;
			sessionId: self sessionId;
			yourself);
		yourself.
	self sendMessage: payload.	
]

{ #category : #'private - accessing' }
DSGatewayMessageReceiver >> sequenceNumber [
	<return: #Integer>
	^ self heartbeatProcess sequenceNumber
]

{ #category : #'private - accessing' }
DSGatewayMessageReceiver >> sequenceNumber: anInteger [ 
	self heartbeatProcess sequenceNumber: anInteger
]

{ #category : #accessing }
DSGatewayMessageReceiver >> session [
	<return: #DSSession>
	^ session
]

{ #category : #accessing }
DSGatewayMessageReceiver >> session: aDSSession [
	session := aDSSession
]

{ #category : #'private - accessing' }
DSGatewayMessageReceiver >> sessionId [
	<return: #String>
	^ sessionId
]

{ #category : #'private - accessing' }
DSGatewayMessageReceiver >> sessionId: aString [
	sessionId := aString
]

{ #category : #'private - actions' }
DSGatewayMessageReceiver >> startHeartbeatProcessWithInterval: anInteger [
	"Send the OP 2 Identify message to a Discord Gateway."
	self heartbeatProcess 
		heartbeatInterval: anInteger;
		start.
]

{ #category : #'private - accessing' }
DSGatewayMessageReceiver >> token [
	^ self session token
]

{ #category : #evaluating }
DSGatewayMessageReceiver >> value: messageString [
	"Receive a Discord Gateway message in a raw string format."
	| payload |
	payload := DSGatewayModelJsonMapping readPayload: messageString.
	payload sequenceNumber ifNotNil: [ :integer | self sequenceNumber: integer ].
	payload accept: self.
	
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayDispatchMessageCreatePayload: payload [
	"Message Create event received. Let's inform about it."
	self announcer announce: (DSGatewayMessageCreateAnnouncement payload: payload)
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayDispatchMessageUpdatePayload: payload [ 
	self announcer announce: (DSGatewayMessageUpdateAnnouncement payload: payload)
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayDispatchPresenceUpdatePayload: payload [ 
	self announcer announce: (DSGatewayPresenceUpdateAnnouncement payload: payload)
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayDispatchReadyPayload: payload [ 
	payload sequenceNumber ifNotNil: [ :sequence | self sequenceNumber: sequence ].
	payload sessionId ifNotNil: [ :id | self sessionId: id ]. 
	self announcer announce: (DSGatewayReadyAnnouncement new payload: payload; yourself)
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayHeartbeatAckPayload: aDSGatewayHeartbeatAckPayload [ 
	"nothing todo"
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayHelloPayload: payload [
	self hasSessionId
		ifFalse: [ self sendIdentifyCode ]
		ifTrue: [ self sendResumeCode ].
	self startHeartbeatProcessWithInterval: payload heartbeatInterval.
]

{ #category : #visiting }
DSGatewayMessageReceiver >> visitDSGatewayInvalidSessionPayload: payload [ 
	"Sent when a client attempts to resume, but the passed session ID is invalid or expired. 
	The inner d key is a boolean that indicates whether or not the session may be resumable. 
	
	It's also possible that your client cannot reconnect in time to resume, 
	in which case the client will receive a OP 9 Invalid Session and 
	is expected to wait a random amount of time (between 1 and 5 seconds), 
	then send a fresh OP 2 Identify."
	self sendIdentifyCodeAfterAWhile
]

{ #category : #'as yet unclassified' }
DSGatewayMessageReceiver >> visitDSGatewayUnclassifiedPayload: payload [ 
	self announcer announce: (DSGatewayUnclassifiedAnnouncement payload: payload)
]

{ #category : #accessing }
DSGatewayMessageReceiver >> websocket [
	<return: #DSGatewayWebSocket>
	^ websocket
]

{ #category : #accessing }
DSGatewayMessageReceiver >> websocket: aDSGatewayWebSocket [
	websocket := aDSGatewayWebSocket
]
