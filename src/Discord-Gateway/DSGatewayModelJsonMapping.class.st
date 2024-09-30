"
I keep Neo JSON mappings between Discord Gateway objects and their JSON representations.
"
Class {
	#name : 'DSGatewayModelJsonMapping',
	#superclass : 'Object',
	#category : 'Discord-Gateway-Utility',
	#package : 'Discord-Gateway',
	#tag : 'Utility'
}

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> connectionStatusMappingFor: aNeoJSONMapper [
	DSModelJsonMapping connectionStatusMappingFor: aNeoJSONMapper
]

{ #category : 'accessing' }
DSGatewayModelJsonMapping class >> coreModelJsonMapping [
	^ DSModelJsonMapping
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> dispatchReadyEventPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayDispatchReadyPayload event: DSGatewayReadyEvent mappingFor: aNeoJSONMapper.
	self readyEventMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> gameMappingFor: aNeoJSONMapper [
	DSModelJsonMapping gameMappingFor: aNeoJSONMapper
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> heartbeatAckPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayHeartbeatAckPayload event: nil mappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> heartbeatPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayHeartbeatPayload event: nil mappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - event' }
DSGatewayModelJsonMapping class >> helloEventMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayHelloEvent do: [ :mapping |
	      mapping mapAccessor: #heartbeatInterval to: #heartbeat_interval.
	      mapping mapAccessor: #traces to: #_trace ].
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> helloPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayHelloPayload event: DSGatewayHelloEvent mappingFor: aNeoJSONMapper.
	self helloEventMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - event' }
DSGatewayModelJsonMapping class >> identityEventMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayIdentityEvent do: [ :mapping |
	      mapping mapAccessor: #token.
			(mapping mapAccessor: #properties) valueSchema: DSGatewayIdentityProperties.
			mapping mapAccessor: #compress.
			mapping mapAccessor: #largeThreshold to: #large_threshold.
	      (mapping mapAccessor: #shard) valueSchema: DSGatewayShard.
			(mapping mapAccessor: #status to: #presence) valueSchema: DSGatewayStatusUpdate ].
	self
		identityPropertiesMappingFor: aNeoJSONMapper;
		shardMappingFor: aNeoJSONMapper;
		statusUpdateMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> identityPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayIdentityPayload event: DSGatewayIdentityEvent mappingFor: aNeoJSONMapper.
	self identityEventMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> identityPropertiesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayIdentityProperties do: [ :mapping |
	      mapping mapAccessor: #os to: #'$os'.
	      mapping mapAccessor: #browser to: #'$browser'.
			mapping mapAccessor: #device to: #'$device'.
			mapping mapAccessor: #referrer to: #'$referrer'.
			mapping mapAccessor: #referringDomain to: #'$referring_domain' ].
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> invalidSessionPayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayInvalidSessionPayload event: nil mappingFor: aNeoJSONMapper.
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonCollectionOfGuildsOne [
	^ DSModelJsonMapping jsonCollectionOfGuildsOne
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonGame [
	^ DSModelJsonMapping jsonGame
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonHeartbeatAckPayload [
	^ '{"op":11}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonHeartbeatPayload [
	^ '{"op":1,"d":42}'
]

{ #category : 'json example - event' }
DSGatewayModelJsonMapping class >> jsonHelloEvent [
	^ '{"heartbeat_interval":41250,"_trace":["discord-gateway-prd-1-2"]}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonHelloPayload [
	^ '{"op":10,"d":', self jsonHelloEvent, ',"s":1,"t":"name"}'
]

{ #category : 'json example - event' }
DSGatewayModelJsonMapping class >> jsonIdentityEvent [
	^ '{"token":"a secret token","properties":', self jsonIdentityProperties, ',"compress":true,"large_threshold":72,"shard":', 
	self jsonShard, ',"presence":', self jsonStatusUpdate, '}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonIdentityPayload [
	^ '{"op":2,"d":', self jsonIdentityEvent, '}'
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonIdentityProperties [
	^ '{"$os":"MacOSX","$browser":"DiscordSt (https://github.com/JurajKubelka/DiscordSt, 0.1.0-dev-60519)","$device":"Pharo6.0 of 13 May 2016 update 60519","$referrer":"","$referring_domain":""}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonInvalidSessionPayload [
	^ '{"op":9,"d":false}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonMessageCreatePayload [
	^ '{"op":0,"d":', self coreModelJsonMapping jsonMessage, ',"s":4,"t":"MESSAGE_CREATE"}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonMessageUpdatePayload [
	^ '{"op":0,"d":', self coreModelJsonMapping jsonMessage, ',"s":5,"t":"MESSAGE_UPDATE"}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonPresenceUpdatePayload [
	^ '{"op":0,"d":{"user":{"id":"286153065164304880"},"status":"idle","roles":[],"nick":null,"guild_id":"289187121854545132","game":null},"s":8,"t":"PRESENCE_UPDATE"}'
]

{ #category : 'json example - event' }
DSGatewayModelJsonMapping class >> jsonReadyEvent [
	^ '{"v":6,"user":', self jsonUser, ',"private_channels":[],"guilds":', self jsonCollectionOfGuildsOne, 
	',"session_id":21,"_trace":["discord-gateway-prd-1-16","discord-sessions-prd-1-2"]}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonReadyPayload [
	^ '{"op":0,"d":', self jsonReadyEvent, ',"s":2,"t":"READY"}'
]

{ #category : 'json example - event' }
DSGatewayModelJsonMapping class >> jsonResumeEvent [
	^ '{"token":"randomstring","session_id":"evenmorerandomstring","seq":1337}'
]

{ #category : 'json example - payload' }
DSGatewayModelJsonMapping class >> jsonResumePayload [
	^ '{"op":6,"d":', self jsonResumeEvent, '}'
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonShard [
	^ '[1,10]'
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonStatusUpdate [
	^ '{"since":91879201,"game":', self jsonGame, ',"status":"invisible","afk":true}'
]

{ #category : 'json example - basic' }
DSGatewayModelJsonMapping class >> jsonUser [
	^ DSModelJsonMapping jsonUser
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> messageCreatePayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayDispatchMessageCreatePayload event: DSMessage mappingFor: aNeoJSONMapper.
	self coreModelJsonMapping messageMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> messageUpdatePayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayDispatchMessageUpdatePayload event: DSMessage mappingFor: aNeoJSONMapper.
	self coreModelJsonMapping messageMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> payload: payloadSchema event: eventSchema mappingFor: aNeoJSONMapper [
	"Configure Payload schema with a particular event schema.
	The event schema can be nil."
	aNeoJSONMapper
		for: payloadSchema do: [ :mapping | | propertyMapping |
			mapping 
				mapProperty: #op 
				getter: [ :object | object code ] 
				setter: [ :object :value | 
					"Check we are reading the payload."
					[ object code = value ] assert ].
	      propertyMapping := (mapping mapAccessor: #eventData to: #d).
			eventSchema ifNotNil: [ propertyMapping valueSchema: eventSchema ].
			mapping mapAccessor: #sequenceNumber to: #s.
			mapping mapAccessor: #eventName to: #t ].
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> payloadMappingFor: aNeoJSONMapper [ 
	self 
		helloPayloadMappingFor: aNeoJSONMapper;
		identityPayloadMappingFor: aNeoJSONMapper;
		dispatchReadyEventPayloadMappingFor: aNeoJSONMapper;
		resumePayloadMappingFor: aNeoJSONMapper;
		heartbeatPayloadMappingFor: aNeoJSONMapper;
		invalidSessionPayloadMappingFor: aNeoJSONMapper;
		heartbeatAckPayloadMappingFor: aNeoJSONMapper;
		messageCreatePayloadMappingFor: aNeoJSONMapper;
		presenceUpdatePayloadMappingFor: aNeoJSONMapper;
		messageUpdatePayloadMappingFor: aNeoJSONMapper;
		unclassifiedPayloadMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> presenceUpdatePayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayDispatchPresenceUpdatePayload event: DSPresenceUpdate mappingFor: aNeoJSONMapper.
	self helloEventMappingFor: aNeoJSONMapper.
]

{ #category : 'public' }
DSGatewayModelJsonMapping class >> read: jsonSchema withMapping: messageSymbol on: aReadStream [ 
	"Read a JSON string using json schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	| reader |
	reader := (NeoJSONReader on: aReadStream).
	self perform: messageSymbol with: reader.
	^ reader nextAs: jsonSchema
]

{ #category : 'public' }
DSGatewayModelJsonMapping class >> readPayload: jsonString [ 
	"Parse the json string that represents a Gateway payload.
	It correctly parses the eventData according to the payload code."
	<return: #DSGatewayPayload>
	| unspecifidPayload schema |
	unspecifidPayload := self read: DSGatewayUnspecifiedPayload withMapping: #unspecifiedPayloadMappingFor: on: jsonString readStream.
	schema := DSGatewayPayload schemaFromUnspecifidPayload: unspecifidPayload.
	^ self read: schema withMapping: #payloadMappingFor: on: jsonString readStream.
]

{ #category : 'mapping - event' }
DSGatewayModelJsonMapping class >> readyEventMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayReadyEvent do: [ :mapping |
	      mapping mapAccessor: #version to: #v.
			(mapping mapAccessor: #user) valueSchema: DSUser.
			(mapping mapAccessor: #privateChannels to: #private_channels) valueSchema: #CollectionOfSpecifiedChannels.
			(mapping mapAccessor: #guilds) valueSchema: #CollectionOfGuilds.
	      mapping mapAccessor: #sessionId to: #session_id.
			mapping mapAccessor: #traces to: #_trace ].
	DSModelJsonMapping
		userMappingFor: aNeoJSONMapper;
		collectionOfSpecifiedChannelsMappingFor: aNeoJSONMapper;
		collectionOfGuildsMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - event' }
DSGatewayModelJsonMapping class >> resumeEventMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayResumeEvent do: [ :mapping |
	      mapping mapAccessor: #token.
			mapping mapAccessor: #sessionId to: #session_id.
			mapping mapAccessor: #sequenceNumber to: #seq ].

]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> resumePayloadMappingFor: aNeoJSONMapper [
	self payload: DSGatewayResumePayload event: DSGatewayResumeEvent mappingFor: aNeoJSONMapper.
	self resumeEventMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> shardMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayShard customDo: [ :mapping |
			mapping
				decoder: [ :array | DSGatewayShard new
					id: array first;
					numberOfShards: array second;
					yourself ];
				encoder: [ :aShard | 
					{ aShard id. aShard numberOfShards } ] ].
]

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> statusUpdateMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayStatusUpdate do: [ :mapping |
	      (mapping mapAccessor: #since) valueSchema: #UnixTimeInMilliSeconds.
	      (mapping mapAccessor: #game) valueSchema: DSGame.
			(mapping mapAccessor: #status) valueSchema: DSConnectionStatus.
			mapping mapAccessor: #awayFromKeyboard to: #afk ].
	self
		unixTimeInMilliSecondsMappingFor: aNeoJSONMapper;
		gameMappingFor: aNeoJSONMapper;
		connectionStatusMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> unclassifiedPayloadMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGatewayUnclassifiedPayload do: [ :mapping |
			mapping mapAccessor: #code to: #op.
	      mapping mapAccessor: #eventData to: #d.
			mapping mapAccessor: #sequenceNumber to: #s.
			mapping mapAccessor: #eventName to: #t ].
]

{ #category : 'mapping - basic' }
DSGatewayModelJsonMapping class >> unixTimeInMilliSecondsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #UnixTimeInMilliSeconds customDo: [ :mapping |
			mapping 
				encoder: [ :aDateAndTime | 
					(aDateAndTime - DateAndTime unixEpoch) asMilliSeconds ];
				decoder: [ :aStringOrNil | 
					aStringOrNil ifNotNil: [ :anInteger | 
						DateAndTime fromUnixTime: anInteger / 1000 ] ] ].
]

{ #category : 'mapping - payload' }
DSGatewayModelJsonMapping class >> unspecifiedPayloadMappingFor: aNeoJSONMapper [ 
	aNeoJSONMapper
		for: DSGatewayUnspecifiedPayload do: [ :mapping |
	      mapping mapAccessor: #code to: #op.
			mapping mapAccessor: #eventName to: #t ].
]

{ #category : 'public' }
DSGatewayModelJsonMapping class >> write: aDSObject as: schema mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			prettyPrint: false;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: aDSObject as: schema ].
]

{ #category : 'public' }
DSGatewayModelJsonMapping class >> write: aDSObject mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			prettyPrint: false;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: aDSObject ].
]

{ #category : 'public' }
DSGatewayModelJsonMapping class >> writePayload: aDSGatewayPayload [
	"Return a JSON string representation of the Discord Gateway payload."
	<return: #String>
	^ self write: aDSGatewayPayload mappedTo: #payloadMappingFor:
]
