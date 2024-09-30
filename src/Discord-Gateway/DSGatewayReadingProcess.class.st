Class {
	#name : 'DSGatewayReadingProcess',
	#superclass : 'DSGatewayProcess',
	#instVars : [
		'receiver'
	],
	#category : 'Discord-Gateway-API',
	#package : 'Discord-Gateway',
	#tag : 'API'
}

{ #category : 'private' }
DSGatewayReadingProcess >> doCycle [
	"Read Payload/Event.
	It also receives heartbeat ACK code."
	| message |
	[ message := websocket readMessage ]
	on: ConnectionTimedOut, ConnectionClosed
	do: [ "ignore & continue" ].
	message ifNotNil: [ 
		self messageReceived: message ].

]

{ #category : 'private' }
DSGatewayReadingProcess >> messageReceived: message [
	"Inform receiver about received message.
	The message is a raw message (string or bytes).
	Process UnhandledError and Halt exceptions in a separate process.
	That way we can still receive messages and keep the process active 
	even on a debugger window close." 
	self receiver ifNotNil: [ :oneArgBlock | 
		[ oneArgBlock value: message ]
			on: UnhandledError, Halt fork: [ :ex | ex pass ] ]
]

{ #category : 'printing' }
DSGatewayReadingProcess >> printProcessNameOn: aStream [
	aStream
		nextPutAll: self className;
		nextPutAll: ' reading process'
]

{ #category : 'accessing' }
DSGatewayReadingProcess >> receiver [
	<return: #DSGatewayMessageReceiver>
	^ receiver
]

{ #category : 'accessing' }
DSGatewayReadingProcess >> receiver: aDSGatewayMessageReceiver [
	receiver := aDSGatewayMessageReceiver
]
