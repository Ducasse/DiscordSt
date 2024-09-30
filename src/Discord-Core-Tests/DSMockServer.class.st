"
I simulate a Discord server.
Test cases can use me for configuring delegate and responses.

Test cases that use me, should write to their tearDown method the following:

{{{
tearDown
	server ifNotNil: #stop.
	super tearDown.
}}}

Usage:

{{{
| server client serverResponse |
server := DSMockServer new.
server start.
server delegate 
	map: '/your/path' 
	to: [ :request :response | 
		server add: request. 
		response entity: (ZnEntity text: 'OK') ].
client := ZnClient new.
serverResponse := client
	url: (server url / 'your' / 'path');
	get.
server stop.
serverResponse.
}}}

"
Class {
	#name : 'DSMockServer',
	#superclass : 'Object',
	#instVars : [
		'port',
		'server',
		'delegate',
		'serverRequests',
		'semaphore'
	],
	#category : 'Discord-Core-Tests-Support',
	#package : 'Discord-Core-Tests',
	#tag : 'Support'
}

{ #category : 'examples' }
DSMockServer class >> basicUsage [
	"A commong usage example. The values of serverResponse and server collection can be then tested."
	
	| server client serverResponse |
	server := DSMockServer new.
	server start.
	server delegate 
		map: '/your/path' 
		to: [ :request :response | 
			server add: request. 
			response entity: (ZnEntity text: 'OK') ].
	client := ZnClient new.
	serverResponse := client
		url: (server url / 'your' / 'path');
		get.
	server stop.
	^ { serverResponse. server collection }

]

{ #category : 'adding' }
DSMockServer >> add: anObject [
	"Add a value that is subject of a interest to the collection.
	The collection can be than tested in a test case."
	serverRequests add: anObject
]

{ #category : 'accessing' }
DSMockServer >> apiUrl [
	"Return URL object pointing to a Fake Discord test server."
	self port isNil ifTrue: [ 
		self error: 'This message should be sent after #start message' ].
	^ ZnUrl new 
		scheme: #http;
		host: NetNameResolver loopBackName;
		port: port;
		addPathSegment: 'api';
		yourself
]

{ #category : 'accessing' }
DSMockServer >> collection [
	"Return an OrderedCollection that can be used for storing information about the server activities.
	See start method."
	^ serverRequests
]

{ #category : 'accessing' }
DSMockServer >> delegate [
	"Return delegate object that can be configured using to:map: message.
	See start method."
	^ delegate
]

{ #category : 'accessing' }
DSMockServer >> delegate: aDelegate [
	"Set delegate object that can be configured using to:map: message.
	See start method."
	delegate ifNil: [ self error: 'This message should be sent after #start message' ].
	delegate := aDelegate.
	server delegate: aDelegate.
]

{ #category : 'accessing' }
DSMockServer >> gatewayUrl [
	"Return URL object pointing to a Fake Gateway Discord test server."
	self port isNil ifTrue: [ 
		self error: 'This message should be sent after #start message' ].
	^ ZnUrl new 
		scheme: #ws;
		host: NetNameResolver loopBackName;
		port: port;
		addPathSegment: 'gateway';
		yourself
]

{ #category : 'accessing' }
DSMockServer >> port [
	"Return a current port of a ZnServer.
	See start method."
	^ port
]

{ #category : 'accessing' }
DSMockServer >> semaphore [
	"Return a Semaphore object that can be used for process synchronization between a client and the server.
	See start method."
	^ semaphore
]

{ #category : 'options' }
DSMockServer >> setDebugMode [
	self port isNil ifTrue: [ 
		self error: 'This message should be sent after #start message' ].
	server debugMode: true.
]

{ #category : 'actions' }
DSMockServer >> start [
	"It starts ZnServer on a free port. 
	The port is available at port instance variable.
	You can use delegate 
		map: '/your/path' 
		to: [ :request :response | serverRequests add: request. response entity: (ZnEntity text: 'OK') ].
	You can use serverRequests to store information necessary for testing."
	server := ZnServer startOn: 0.
	port := server serverSocket port.
	delegate := ZnDispatcherDelegate new.
	server delegate: delegate.
	serverRequests := OrderedCollection new.
	semaphore := Semaphore new.
]

{ #category : 'actions' }
DSMockServer >> stop [
	"Stop a running server."
	server ifNotNil: #stop.
]

{ #category : 'accessing' }
DSMockServer >> url [
	"Return an URL object pointing to a Fake Discord test server."
	self port isNil ifTrue: [ 
		self error: 'This message should be sent after #start message' ].
	^ ZnUrl new 
		scheme: #http;
		host: NetNameResolver loopBackName;
		port: port;
		yourself
]
