Class {
	#name : 'DSGatewayWebSocket',
	#superclass : 'Object',
	#instVars : [
		'websocket',
		'readMutex',
		'writeMutex'
	],
	#category : 'Discord-Gateway-API',
	#package : 'Discord-Gateway',
	#tag : 'API'
}

{ #category : 'initialize-release' }
DSGatewayWebSocket >> close [
	"Close the connection"
	
	(MutexSet withAll: { readMutex. writeMutex }) critical: [ 
		self websocket ifNotNil: [ :aWebSocket | aWebSocket isConnected ifTrue: [ aWebSocket close ] ] ]
]

{ #category : 'initialization' }
DSGatewayWebSocket >> initialize [
	super initialize.
	writeMutex := Mutex new.
	readMutex := Mutex new.
]

{ #category : 'testing' }
DSGatewayWebSocket >> isConnected [
	^ self websocket 
		ifNotNil: #isConnected
		ifNil: false
]

{ #category : 'protocol' }
DSGatewayWebSocket >> readMessage [
	"Read a message from the Discord Gateway server if possible."
	^ readMutex critical: [ 
		self websocket 
			ifNotNil: [ :aWebSocket | aWebSocket readMessage ]
			ifNil: [ ZnWebSocketClosed signal ] ]
]

{ #category : 'protocol' }
DSGatewayWebSocket >> sendMessage: aString [ 
	"Send message to the Discord Gateway server if possible."
	^ writeMutex critical: [ 
		self websocket 
			ifNotNil: [ :aWebSocket | aWebSocket sendMessage: aString ]
			ifNil: [ ZnWebSocketClosed signal ] ]
]

{ #category : 'accessing' }
DSGatewayWebSocket >> websocket [
	^ websocket
]

{ #category : 'accessing' }
DSGatewayWebSocket >> websocket: anObject [
	websocket := anObject
]
