Class {
	#name : #DSGatewayGetGatewaySixUrlCommand,
	#superclass : #DSGatewayCommand,
	#instVars : [
		'websocketUrl',
		'restApiUrl'
	],
	#category : 'Discord-Gateway-Commands'
}

{ #category : #execute }
DSGatewayGetGatewaySixUrlCommand >> execute [
	| response |
	response := DSUtility newZnClientWithUserAgent
		url: self gatewayUrl;
		get;
		response.
	response isSuccess 
		ifTrue: [ self websocketUrl: ((NeoJSONObject fromString: response contents) at: 'url') asZnUrl ]
		ifFalse: [ DSDiscordResponseError new
				response: response;
				signal: response contents ].
	self websocketUrl: (self websocketUrl
		queryAt: 'v' put: 6;
		queryAt: 'enconding' put: 'json';
		yourself)
]

{ #category : #accessing }
DSGatewayGetGatewaySixUrlCommand >> gatewayUrl [
	"Return Gateway URL.
	See https://discordapp.com/developers/docs/topics/gateway#get-gateway"
	<return: #ZnUrl>
	^ self restApiUrl / 'gateway'
]

{ #category : #accessing }
DSGatewayGetGatewaySixUrlCommand >> restApiUrl [
	"Return a root Discord REST API URL."
	<return: #ZnUrl>	
	^ restApiUrl
]

{ #category : #accessing }
DSGatewayGetGatewaySixUrlCommand >> restApiUrl: anObject [
	restApiUrl := anObject
]

{ #category : #accessing }
DSGatewayGetGatewaySixUrlCommand >> websocketUrl [
	"Return WebSocket URL that should be used connecting to Gateway."
	<return: #ZnUrl>
	^ websocketUrl
]

{ #category : #accessing }
DSGatewayGetGatewaySixUrlCommand >> websocketUrl: anObject [
	websocketUrl := anObject
]
