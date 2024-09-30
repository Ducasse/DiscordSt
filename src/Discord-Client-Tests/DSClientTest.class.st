"
A DSClientTest is a test class for testing the behavior of DSClient.
I test behavior that not requiere connection with a real Discord server.
"
Class {
	#name : 'DSClientTest',
	#superclass : 'DSClientTestCase',
	#instVars : [
		'client'
	],
	#category : 'Discord-Client-Tests',
	#package : 'Discord-Client-Tests'
}

{ #category : 'tests' }
DSClientTest >> testGateway [
	"Gateway should share the same session with REST API."

	client := self newClient.
	self assert: client gateway notNil.
	self assert: client gateway session == client restApi session
]

{ #category : 'tests' }
DSClientTest >> testIsAuthenticated [
	"Default user should not be authenticated"
	client := self newClient.
	self deny: client isAuthenticated
]

{ #category : 'tests' }
DSClientTest >> testIsConnected [
	"Default user should not be connected"
	client := self newClient.
	self deny: client isConnected
]

{ #category : 'tests' }
DSClientTest >> testMessage [
	| builder |
	client := self newClient.
	builder := client message.
	self assert: builder restApi == client restApi.
	self assert: builder class equals: DSClientPostBuilder.
]

{ #category : 'tests' }
DSClientTest >> testPrintString [
	client := self newClient.
	self assert: client printString isString.
]

{ #category : 'tests' }
DSClientTest >> testToken [
	"Set and get token"
	client := self newClient.
	client token: self tokenString.
	self assert: client token equals: self tokenString.

]

{ #category : 'tests' }
DSClientTest >> testTokenDefault [
	"Default token should be nil."
	client := self newClient.
	self assert: client token isEmpty.
]

{ #category : 'tests' }
DSClientTest >> testWith [
	| results returnValue |
	results := OrderedCollection new.
	client := self newClient.
	returnValue := client with: [ :aClient | results add: aClient. 42 ].
	self assert: results size equals: 1.
	self assert: results first == client.
	self assert: returnValue equals: 42.
]
