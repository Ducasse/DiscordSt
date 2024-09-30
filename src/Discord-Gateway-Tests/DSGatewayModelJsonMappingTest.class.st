"
A DSGatewayModelJsonMappingTest is a test class for testing the behavior of DSGatewayModelJsonMapping
"
Class {
	#name : 'DSGatewayModelJsonMappingTest',
	#superclass : 'TestCase',
	#category : 'Discord-Gateway-Tests-Utility',
	#package : 'Discord-Gateway-Tests',
	#tag : 'Utility'
}

{ #category : 'running' }
DSGatewayModelJsonMappingTest >> classToTest [
	^ DSGatewayModelJsonMapping
]

{ #category : 'utility' }
DSGatewayModelJsonMappingTest >> read: jsonString as: schema mappedTo: mappingMessage [
	"Return an object that is represented by the JSON string."
	<return: #DSObject>
	^ self classToTest read: schema withMapping: mappingMessage on: jsonString readStream
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testDispatchReadyEventPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonReadyPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayDispatchReadyPayload.
	self assert: result code equals: 0.
	self assert: result eventData class equals: DSGatewayReadyEvent.
	self assert: result sequenceNumber equals: 2.
	self assert: result eventName equals: 'READY'.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testHeartbeatAckPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonHeartbeatAckPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayHeartbeatAckPayload.
	self assert: result code equals: 11.
	self assert: result eventData isNil.
	self assert: result sequenceNumber isNil.
	self assert: result eventName isNil.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testHeartbeatPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonHeartbeatPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayHeartbeatPayload.
	self assert: result code equals: 1.
	self assert: result eventData equals: 42.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - event' }
DSGatewayModelJsonMappingTest >> testHelloEventMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonHelloEvent.
	result := self read: jsonString as: DSGatewayHelloEvent mappedTo: #helloEventMappingFor:.
	self assert: result class equals: DSGatewayHelloEvent.
	self assert: result heartbeatInterval equals: 41250.
	self assert: result traces class equals: Array.
	self assert: result traces size equals: 1.
	self assert: result traces first equals: 'discord-gateway-prd-1-2'.
	jsonResult := self write: result mappedTo: #helloEventMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testHelloPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonHelloPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayHelloPayload.
	self assert: result code equals: 10.
	self assert: result eventData class equals: DSGatewayHelloEvent.
	self assert: result sequenceNumber equals: 1.
	self assert: result eventName equals: 'name'.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - event' }
DSGatewayModelJsonMappingTest >> testIdentityEventMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonIdentityEvent.
	result := self read: jsonString as: DSGatewayIdentityEvent mappedTo: #identityEventMappingFor:.
	self assert: result class equals: DSGatewayIdentityEvent.
	self assert: result token equals: 'a secret token'.
	self assert: result properties class equals: DSGatewayIdentityProperties.
	self assert: result compress.
	self assert: result largeThreshold equals: 72.
	self assert: result shard class equals: DSGatewayShard.
	self assert: result status class equals: DSGatewayStatusUpdate.
	jsonResult := self write: result mappedTo: #identityEventMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testIdentityPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonIdentityPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayIdentityPayload.
	self assert: result code equals: 2.
	self assert: result eventData class equals: DSGatewayIdentityEvent.
	self assert: result sequenceNumber isNil.
	self assert: result eventName isNil.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSGatewayModelJsonMappingTest >> testIdentityPropertiesMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonIdentityProperties.
	result := self read: jsonString as: DSGatewayIdentityProperties mappedTo: #identityPropertiesMappingFor:.
	self assert: result class equals: DSGatewayIdentityProperties.
	self assert: result os equals: 'MacOSX'.
	self assert: result browser equals: 'DiscordSt (https://github.com/JurajKubelka/DiscordSt, 0.1.0-dev-60519)'.
	self assert: result device equals: 'Pharo6.0 of 13 May 2016 update 60519'.
	self assert: result referrer equals: ''.
	self assert: result referringDomain equals: ''.
	jsonResult := self write: result mappedTo: #identityPropertiesMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testInvalidSessionPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonInvalidSessionPayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayInvalidSessionPayload.
	self assert: result code equals: 9.
	self deny: result eventData.
	self assert: result sequenceNumber isNil.
	self assert: result eventName isNil.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testMessageCreatePayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonMessageCreatePayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayDispatchMessageCreatePayload.
	self assert: result code equals: 0.
	self assert: result eventData class equals: DSMessage.
	self assert: result sequenceNumber equals: 4.
	self assert: result eventName equals: 'MESSAGE_CREATE'.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testMessageUpdatePayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonMessageUpdatePayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayDispatchMessageUpdatePayload.
	self assert: result code equals: 0.
	self assert: result eventData class equals: DSMessage.
	self assert: result sequenceNumber equals: 5.
	self assert: result eventName equals: 'MESSAGE_UPDATE'.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testPresenceUpdatePayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonPresenceUpdatePayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayDispatchPresenceUpdatePayload.
	self assert: result code equals: 0.
	self assert: result eventData class equals: DSPresenceUpdate.
	self assert: result sequenceNumber equals: 8.
	self assert: result eventName equals: 'PRESENCE_UPDATE'.
	jsonResult := self writePayload: result.
	self 
		assert: jsonResult 
		equals: '{"op":0,"d":{"user":{"id":"286153065164304880","bot":false,"verified":false},"roles":[],"guild_id":"289187121854545132","status":"idle"},"s":8,"t":"PRESENCE_UPDATE"}'.
]

{ #category : 'tests - event' }
DSGatewayModelJsonMappingTest >> testReadyEventMappingFor [
	| result jsonString jsonResult |
	jsonString := self classToTest jsonReadyEvent.
	result := self read: jsonString as: DSGatewayReadyEvent mappedTo: #readyEventMappingFor:.
	self assert: result class equals: DSGatewayReadyEvent.
	self assert: result version equals: 6.
	self assert: result user class equals: DSUser.
	self assert: result privateChannels class equals: DSChannels.
	self assert: result guilds class equals: DSGuilds.
	self assert: result sessionId equals: 21.
	self assert: result traces class equals: Array.
	self assert: result traces size equals: 2.
	self assert: result traces first equals: 'discord-gateway-prd-1-16'.
	self assert: result traces second equals: 'discord-sessions-prd-1-2'.
	jsonResult := self write: result mappedTo: #readyEventMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - event' }
DSGatewayModelJsonMappingTest >> testResumeEventMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonResumeEvent.
	result := self read: jsonString as: DSGatewayResumeEvent mappedTo: #resumeEventMappingFor:.
	self assert: result class equals: DSGatewayResumeEvent.
	self assert: result token equals: 'randomstring'.
	self assert: result sessionId equals: 'evenmorerandomstring'.
	self assert: result sequenceNumber equals: 1337.
	jsonResult := self write: result mappedTo: #resumeEventMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testResumePayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonResumePayload.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayResumePayload.
	self assert: result code equals: 6.
	self assert: result eventData class equals: DSGatewayResumeEvent.
	self assert: result sequenceNumber isNil.
	self assert: result eventName isNil.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSGatewayModelJsonMappingTest >> testShardMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonShard.
	result := self read: jsonString as: DSGatewayShard mappedTo: #shardMappingFor:.
	self assert: result class equals: DSGatewayShard.
	self assert: result id equals: 1.
	self assert: result numberOfShards equals: 10.
	jsonResult := self write: result mappedTo: #shardMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSGatewayModelJsonMappingTest >> testStatusUpdateMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonStatusUpdate.
	result := self read: jsonString as: DSGatewayStatusUpdate mappedTo: #statusUpdateMappingFor:.
	self assert: result class equals: DSGatewayStatusUpdate.
	self assert: result since class equals: DateAndTime.
	self assert: result game class equals: DSGame.
	self assert: result status class equals: DSInvisibleStatus.
	self assert: result awayFromKeyboard.
	jsonResult := self write: result mappedTo: #statusUpdateMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - payload' }
DSGatewayModelJsonMappingTest >> testUnclassifiedPayloadMappingFor [
	| result jsonResult jsonString |
	jsonString := '{"op":342,"d":42,"s":21,"t":"UNKNOWN"}'.
	result := self classToTest readPayload: jsonString.
	self assert: result class equals: DSGatewayUnclassifiedPayload.
	self assert: result code equals: 342.
	self assert: result eventData equals: 42.
	self assert: result sequenceNumber equals: 21.
	self assert: result eventName equals: 'UNKNOWN'.
	jsonResult := self writePayload: result.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'tests - basic' }
DSGatewayModelJsonMappingTest >> testUnixTimeInMilliSecondsMappingFor [
	| result jsonResult jsonString |
	"'2017-11-09T11:41:09.769-03:00' asDateAndTime asUnixTime"
	jsonString := '1510238469769'.
	result := self read: jsonString as: #UnixTimeInMilliSeconds mappedTo: #unixTimeInMilliSecondsMappingFor:.
	self assert: result class equals: DateAndTime.
	self assert: result equals: '2017-11-09T11:41:09.769-03:00' asDateAndTime.
	jsonResult := self write: result as: #UnixTimeInMilliSeconds mappedTo: #unixTimeInMilliSecondsMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : 'utility' }
DSGatewayModelJsonMappingTest >> write: aDSObject as: schema mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ self classToTest write: aDSObject as: schema mappedTo: mappingSymbol
]

{ #category : 'utility' }
DSGatewayModelJsonMappingTest >> write: aDSObject mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ self classToTest write: aDSObject mappedTo: mappingSymbol
]

{ #category : 'utility' }
DSGatewayModelJsonMappingTest >> writePayload: aDSGatewayPayload [
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ self classToTest writePayload: aDSGatewayPayload
]
