"
A DSGatewayApiTest is a test class for testing the behavior of DSGatewayApi
"
Class {
	#name : 'DSGatewayTest',
	#superclass : 'DSGatewayTestCase',
	#instVars : [
		'api'
	],
	#category : 'Discord-Gateway-Tests-API',
	#package : 'Discord-Gateway-Tests',
	#tag : 'API'
}

{ #category : 'testing' }
DSGatewayTest class >> isAbstract [
	^ self = DSGatewayTest 
]

{ #category : 'instance creation' }
DSGatewayTest >> newGateway [
	^ self subclassResponsibility
]

{ #category : 'tests' }
DSGatewayTest >> testPrintString [
	self assert: self newGateway printString isString.
]
