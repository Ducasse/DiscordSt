"
A DSApiSixTest is a test class for testing the behavior of DSApiSix
"
Class {
	#name : 'DSApiSixTest',
	#superclass : 'DSApiTest',
	#category : 'Discord-Client-Tests-REST-Api',
	#package : 'Discord-Client-Tests',
	#tag : 'REST-Api'
}

{ #category : 'instance creation' }
DSApiSixTest >> newRestApi [
	^ DSRestApiSix new
]

{ #category : 'tests-public' }
DSApiSixTest >> testEditMessageContentEmbed [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/channels/45930/messages/84266' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: self messageObjectWithEmbedsString) ].
		api 
			editMessage: (self messageObjectWithEmbedsObject: api)
			content: self anyString 
			embed: (self messageObjectWithEmbedsObject: api) embeds first.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #PATCH.
	
]

{ #category : 'tests-public' }
DSApiSixTest >> testEditMessageIdInChannelIdContentEmbed [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/channels/channel-id/messages/message-id' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: self messageObjectWithEmbedsString) ].
		api editMessageId: 'message-id' 
		inChannelId: 'channel-id' 
		content: self anyString 
		embed: (self messageObjectWithEmbedsObject: api) embeds first.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #PATCH.
	
]

{ #category : 'tests' }
DSApiSixTest >> testGuildChannelsUsingId [
	"Return Guild Text Channel"
	| channels |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/guilds/1234/channels' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"guild_id": "1234", "name": "general", "permission_overwrites": [], "topic": "Channel topic", "position": 0, "last_message_id": "5678", "type": 0, "id": "1234", "is_private": false}]') ].
	channels := api guildChannelsUsingId: 1234.
	self assert: channels notNil.
	self assert: channels isCollection.
	self assert: channels size equals: 1.
	self assert: channels first name equals: 'general'.
	self assert: channels first restApi == api description: 'It should have the api object'.
	self assert: channels first isGuildTextChannel.
	self deny: channels first isGuildVoiceChannel.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testGuildChannelsUsingId2 [
	"Receive guild voice channel"
	| channels |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/guilds/1234/channels' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"guild_id": "1234", "name": "general", "permission_overwrites": [], "bitrate": 128, "position": 0, "user_limit": 12, "type": 2, "id": "1234", "is_private": false}]') ].
	channels := api guildChannelsUsingId: 1234.
	self assert: channels notNil.
	self assert: channels isCollection.
	self assert: channels size equals: 1.
	self assert: channels first name equals: 'general'.
	self deny: channels first isGuildTextChannel.
	self assert: channels first restApi == api description: 'It should have the api object'.
	self assert: channels first isGuildVoiceChannel.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testGuildChannelsUsingId3 [
	"Return Guild Text Channel using type = 0"
	| channels |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/guilds/1234/channels' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"guild_id": "1234", "name": "general", "permission_overwrites": [], "topic": "Channel topic", "position": 0, "last_message_id": "5678", "type": 0, "id": "1234", "is_private": false}]') ].
	channels := api guildChannelsUsingId: 1234.
	self assert: channels notNil.
	self assert: channels isCollection.
	self assert: channels size equals: 1.
	self assert: channels first name equals: 'general'.
	self assert: channels first restApi == api description: 'It should have the api object'.
	self assert: channels first isGuildTextChannel.
	self deny: channels first isGuildVoiceChannel.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testGuildChannelsUsingId4 [
	"Receive guild voice channel using type = 2"
	| channels |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/guilds/1234/channels' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"guild_id": "1234", "name": "general", "permission_overwrites": [], "bitrate": 128, "position": 0, "user_limit": 12, "type": 2, "id": "1234", "is_private": false}]') ].
	channels := api guildChannelsUsingId: 1234.
	self assert: channels notNil.
	self assert: channels isCollection.
	self assert: channels size equals: 1.
	self assert: channels first name equals: 'general'.
	self deny: channels first isGuildTextChannel.
	self assert: channels first restApi == api description: 'It should have the api object'.
	self assert: channels first isGuildVoiceChannel.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testGuildChannelsUsingIdUnauthorized [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/guilds/1234/channels' to: self unauthorizedResponseBlock.
	self
		should: [ api guildChannelsUsingId: 1234 ]
		raise: DSUnauthorizedOperationError
		withExceptionDo: self unauthorizedExceptionAssetionBlock.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testLogin [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	self serverDelegate map: '/api/auth/login' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"token":"secret-token"}') ].
	api email: self emailString password: self passwordString.
	api login.
	self assert: api isAuthenticated.
	self assert: api token equals: 'secret-token'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents equals: '{"email":"email@example.com","password":"secret password"}'.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'tests' }
DSApiSixTest >> testLoginEmailDoesNotExist [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	self serverDelegate map: '/api/auth/login' to: [ :request :response |
		self serverRequests add: request.
		response 
			entity: (ZnEntity text: '{"email": ["Email does not exist."]}');
			setContentType: ZnMimeType applicationJson.
		response statusLine
			code: 400;
			reason: 'BAD REQUEST'.
		response. ].
	api email: self emailString password: self passwordString.
	self should: [ api login ] raise: DSCannotLoginError withExceptionDo: [ :exception | 
		self assert: exception response notNil.
		self assert: exception response code = 400.
		self assert: exception response contents equals: '{"email": ["Email does not exist."]}' ].
	self deny: api isAuthenticated.
	self assert: api token isEmpty.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents equals: '{"email":"email@example.com","password":"secret password"}'.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'tests' }
DSApiSixTest >> testLoginNewLoginLocationDetected [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	self serverDelegate map: '/api/auth/login' to: [ :request :response |
		self serverRequests add: request.
		response 
			entity: (ZnEntity text: '{"email": ["New login location detected, please check your e-mail."]}');
			setContentType: ZnMimeType applicationJson.
		response statusLine
			code: 400;
			reason: 'BAD REQUEST'.
		response. ].
	api email: self emailString password: self passwordString.
	self should: [ api login ] raise: DSCannotLoginError withExceptionDo: [ :exception | 
		self assert: exception response notNil.
		self assert: exception response code = 400.
		self assert: exception response contents equals: '{"email": ["New login location detected, please check your e-mail."]}' ].
	self deny: api isAuthenticated.
	self assert: api token isEmpty.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents equals: '{"email":"email@example.com","password":"secret password"}'.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'tests' }
DSApiSixTest >> testLoginPasswordDoesNotMatch [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	self serverDelegate map: '/api/auth/login' to: [ :request :response |
		self serverRequests add: request.
		response 
			entity: (ZnEntity text: '{"password": ["Password does not match."]}');
			setContentType: ZnMimeType applicationJson.
		response statusLine
			code: 400;
			reason: 'BAD REQUEST'.
		response. ].
	api email: self emailString password: self passwordString.
	self should: [ api login ] raise: DSCannotLoginError withExceptionDo: [ :exception | 
		self assert: exception response notNil.
		self assert: exception response code = 400.
		self assert: exception response contents equals: '{"password": ["Password does not match."]}' ].
	self deny: api isAuthenticated.
	self assert: api token isEmpty.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents equals: '{"email":"email@example.com","password":"secret password"}'.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'tests' }
DSApiSixTest >> testLogout [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: 'secret-token'.
	self serverDelegate map: '/api/auth/logout' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{}') ].
	api logout.
	self deny: api isAuthenticated.
	self assert: api token isEmpty.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first contents equals: '{"token":"secret-token"}'.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'tests' }
DSApiSixTest >> testLogoutUnauthorized [
	"Unauthorized logout"

	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: 'secret-token'.
	self serverDelegate map: '/api/auth/logout' to: self unauthorizedResponseBlock.
	self
		should: [ api logout ]
		raise: DSUnauthorizedOperationError
		withExceptionDo: self unauthorizedExceptionAssetionBlock.
	self assert: api isAuthenticated.
	self assert: api token equals: 'secret-token'.
	self assert: self serverRequests size equals: 1.
	self
		assert: self serverRequests first contents
		equals: '{"token":"secret-token"}'.
	self assert: self serverRequests first method equals: #POST
]

{ #category : 'tests' }
DSApiSixTest >> testMe [
	| user |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"username": "example user name", "verified": false, "mfa_enabled": false, "id": "1234", "phone": null, "avatar": null, "discriminator": "5678", "email": "email@example.com"}') ].
	user := api me.
	self assert: user notNil.
	self assert: user username equals: 'example user name'.
	self assert: user restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.
	self assert: api me == user description: 'It should return the same object'.
]

{ #category : 'tests' }
DSApiSixTest >> testMeGuilds [
	| guilds |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me/guilds' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"owner": false, "permissions": 104332353, "icon": "icon-id", "id": "1234", "name": "Guild One"}]') ].
	guilds := api meGuilds.
	self assert: guilds notNil.
	self assert: guilds isCollection.
	self assert: guilds size equals: 1.
	self assert: guilds first name equals: 'Guild One'.
	self assert: guilds first restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.
	self assert: api meGuilds == guilds description: 'The same object should be returned.'
]

{ #category : 'tests' }
DSApiSixTest >> testMeGuildsUnauthorized [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me/guilds' to: self unauthorizedResponseBlock.
	self
		should: [ api meGuilds ]
		raise: DSUnauthorizedOperationError
		withExceptionDo: self unauthorizedExceptionAssetionBlock.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testMeUnauthorized [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me' to: self unauthorizedResponseBlock.
	self
		should: [ api me ]
		raise: DSUnauthorizedOperationError
		withExceptionDo: self unauthorizedExceptionAssetionBlock.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testMessageForIdInChannelId [
	| message |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/channels/5930/messages/36576' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: self messageObjectString) ].
	message := api messageForId: 36576 inChannelId: 5930.
	self assert: message notNil.
	self assert: message isMessage.
	self assert: message author username equals: 'user one'.
	self assert: message restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.

]

{ #category : 'tests' }
DSApiSixTest >> testNewMeGuilds [
	| guilds |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me/guilds' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '[{"owner": false, "permissions": 104332353, "icon": "icon-id", "id": "1234", "name": "Guild One"}]') ].
	guilds := api newMeGuilds.
	self assert: guilds notNil.
	self assert: guilds isCollection.
	self assert: guilds size equals: 1.
	self assert: guilds first name equals: 'Guild One'.
	self assert: guilds first restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.
]

{ #category : 'tests' }
DSApiSixTest >> testNewMeUser [
	| user |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"username": "example user name", "verified": false, "mfa_enabled": false, "id": "1234", "phone": null, "avatar": null, "discriminator": "5678", "email": "email@example.com"}') ].
	user := api newMeUser.
	self assert: user notNil.
	self assert: user username equals: 'example user name'.
	self assert: user restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.
]

{ #category : 'tests' }
DSApiSixTest >> testNewMeUserUnauthorized [
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/users/@me' to: self unauthorizedResponseBlock.
	self should: [ api newMeUser ] raise: DSUnauthorizedOperationError withExceptionDo: self unauthorizedExceptionAssetionBlock.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #GET.
]

{ #category : 'as yet unclassified' }
DSApiSixTest >> testSendMessageToGuildTextOrDMChannelId [
	| message returnedMessage |
	self startZnServer.
	api := self newRestApi.
	api apiUrl: self apiUrl.
	api token: self tokenString.
	self serverDelegate map: '/api/channels/channel-id/messages' to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "1234", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "channel-id", "mentions": [], "type": 0}') ].
	message := DSClientJsonPost new content: 'message one'; yourself.
	returnedMessage := api sendMessage: message toGuildTextOrDMChannelId: 'channel-id' signalProgress: false.
	self assert: returnedMessage notNil.
	self assert: returnedMessage content equals: 'text message'.
	self assert: returnedMessage restApi == api description: 'It should have the api object'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #POST.
]

{ #category : 'defaults' }
DSApiSixTest >> unauthorizedExceptionAssetionBlock [
	"Assertion block for unauthorized exception"
	^ [ :exception | 
	self assert: exception response notNil.
	self assert: exception response code = 401.
	self
		assert: exception response contents
		equals: '{"code": 0, "message": "401: Unauthorized"}' ]
]

{ #category : 'defaults' }
DSApiSixTest >> unauthorizedResponseBlock [
	"Znserver delegate handler that returns unauthorized response."
	^ [ :request :response | 
	self serverRequests add: request.
	response
		entity: (ZnEntity text: '{"code": 0, "message": "401: Unauthorized"}');
		setContentType: ZnMimeType applicationJson.
	response statusLine
		code: 401;
		reason: 'UNAUTHORIZED'.
	response ]
]
