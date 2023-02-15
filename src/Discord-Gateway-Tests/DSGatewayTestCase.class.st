"
A DSGatewayTestCase is an abstract test class for testing the behavior of the Discord Gateway.
"
Class {
	#name : #DSGatewayTestCase,
	#superclass : #DSCoreTestCase,
	#category : 'Discord-Gateway-Tests-API'
}

{ #category : #testing }
DSGatewayTestCase class >> isAbstract [
	^ self = DSGatewayTestCase 
]

{ #category : #mock }
DSGatewayTestCase >> gatewayConnectUrl [
	"Return a Mock Gateway URL object used for the WebSocket connection.
	It defines protocol version and used enconding system."
	^ server gatewayUrl
		queryAt: 'v' put: 5;
		queryAt: 'enconding' put: 'json';
		yourself
]

{ #category : #'instance creation' }
DSGatewayTestCase >> newGateway [
	^ DSGateway defaultClass new
]
