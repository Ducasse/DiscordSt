"
A DSWebhookClientTest is a test class for testing the behavior of DSWebhookClient
"
Class {
	#name : 'DSWebhookClientTest',
	#superclass : 'DSCoreTestCase',
	#instVars : [
		'client'
	],
	#category : 'Discord-WebhookClient-Tests',
	#package : 'Discord-WebhookClient-Tests'
}

{ #category : 'defaults' }
DSWebhookClientTest >> anyString [
	^ 'any string'
]

{ #category : 'defaults' }
DSWebhookClientTest >> avatarUrl [
	^ 'http://localhost/avatar.png'
]

{ #category : 'coverage' }
DSWebhookClientTest >> classToTest [
	^ DSWebhookClient
]

{ #category : 'defaults' }
DSWebhookClientTest >> color [
	^ Color green
]

{ #category : 'accessing' }
DSWebhookClientTest >> externalWebhookTokenOrNil [
	"Return Discord Webhook URL used for real post testing.
	The value is secret, for that reason, we recomend you to set it in your environment.
	For example, if you use Travir-CI.org, you can set environments in settings."
	^ Smalltalk os environment at: 'DISCORD_ST_TEST_CASE_WEBHOOK' ifAbsent: nil.
]

{ #category : 'defaults' }
DSWebhookClientTest >> messageEntity [
	^ (ZnEntity text: '{"id":1234,"content":"', self messageString, '"}')
]

{ #category : 'defaults' }
DSWebhookClientTest >> messageString [
	^ 'a message content'
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testAsyncSend [
	"Send JSON entity asynchronously"
	| port serverRequests semaphore delegate timeout |
	serverRequests := OrderedCollection new.
	semaphore := Semaphore new.
	server := ZnServer startOn: 0.
	delegate := ZnDispatcherDelegate new.
	delegate map: '/' to: [ :request :response | 
		serverRequests add: request. 
		semaphore signal.
		response entity: self messageEntity ].
	server delegate: delegate.
	port := server serverSocket port.
	client := self classToTest new 
		url: 'http://localhost:', port asString;
		message: self messageString.
	client asyncSend.
	timeout := semaphore waitTimeoutMSecs: 300.
	self deny: timeout.
	self assert: serverRequests size equals: 1.

]

{ #category : 'tests' }
DSWebhookClientTest >> testAvatarUrl [
	client := self classToTest new 
		message: self messageString;
		avatarUrl: self avatarUrl;
		yourself.
	self assert: client post avatarUrl equals: self avatarUrl.
	self assert: client post content equals: self messageString.
]

{ #category : 'tests' }
DSWebhookClientTest >> testAvatarUrl2 [
	client := self classToTest new 
		avatarUrl: self avatarUrl;
		message: self messageString;
		yourself.
	self assert: client post avatarUrl equals: self avatarUrl.
	self assert: client post content equals: self messageString.
]

{ #category : 'tests' }
DSWebhookClientTest >> testDataPost [
	client := self classToTest new.
	self assert: client dataPost class equals: DSWebhookDataPost.
	self assert: client dataPost == client dataPost.
	self assert: client post == client post.
]

{ #category : 'tests' }
DSWebhookClientTest >> testDataPost2 [
	client := self classToTest new.
	client post: client newJSONPost.
	self assert: client dataPost class equals: DSWebhookDataPost.
	self assert: client post == client post.
]

{ #category : 'tests' }
DSWebhookClientTest >> testDataPost3 [
	client := self classToTest new.
	client
		username: 'Pharo Welcome';
		avatarUrl: 'http://files.pharo.org/media/logo/icon-opaque-512x512.png';
		embedTitle: 'Discord Bot Announcement';
		fileName: 'bytes.out' bytes: self bytes.
	self assert: client post username equals: 'Pharo Welcome'.
	self assert: client post avatarUrl equals: 'http://files.pharo.org/media/logo/icon-opaque-512x512.png'.
	self assert: client post embeds first title equals: 'Discord Bot Announcement'.
	self assert: client post mimeParts first fileName equals: 'bytes.out'.
	self assert: client post mimeParts first contents equals: self bytes.
	
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbed [
	client := self classToTest new
		embedTitle: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first title equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedColor [
	client := self classToTest new
		embedColor: self color;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first color equals: self color.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedDescription [
	client := self classToTest new
		embedDescription: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first description equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedFooterIconUrl [
	client := self classToTest new
		embedFooterIconUrl: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first footer iconUrl equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedFooterText [
	client := self classToTest new
		embedFooterText: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first footer text equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedImageUrl [
	client := self classToTest new
		embedImageUrl: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first image url equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedTitle [
	client := self classToTest new
		embedTitle: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first title equals: self anyString.
]

{ #category : 'tests - embed' }
DSWebhookClientTest >> testEmbedUrl [
	client := self classToTest new
		embedUrl: self anyString;
		yourself.
	self assert: client post embeds isCollection.
	self assert: client post embeds size equals: 1.
	self assert: client post embeds first url equals: self anyString.
]

{ #category : 'tests - files' }
DSWebhookClientTest >> testFileNameBytes [
	client := self classToTest new 
		fileName: self anyString bytes: self bytes.
	self assert: client post mimeParts size equals: 1.
	self assert: client post mimeParts first fieldName equals: self anyString.
	self assert: client post mimeParts first fileName equals: self anyString.
	self assert: client post mimeParts first contents equals: self bytes.
]

{ #category : 'tests - files' }
DSWebhookClientTest >> testFileNameBytes2 [
	client := self classToTest new 
		fileName: self anyString bytes: self bytes;
		fileName: self anyString bytes: self bytes.
	self assert: client post mimeParts size equals: 2.
	self assert: client post mimeParts first fieldName equals: self anyString.
	self assert: client post mimeParts first fileName equals: self anyString.
	self assert: client post mimeParts first contents equals: self bytes.
	self assert: client post mimeParts second fieldName equals: self anyString.
	self assert: client post mimeParts second fileName equals: self anyString.
	self assert: client post mimeParts second contents equals: self bytes.
]

{ #category : 'tests - files' }
DSWebhookClientTest >> testFileNameForm [
	client := self classToTest new
		fileName: self anyString
		form:
			(self iconNamed: #help).
	self assert: client post mimeParts size equals: 1.
	self
		assert: client post mimeParts first fieldName
		equals: self anyString.
	self
		assert: client post mimeParts first fileName
		equals: self anyString.
	self
		assert: client post mimeParts first contents
		equals:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 16 0 0 0 16 8 6 0 0 0 31 243 255 97 0 0 0 244 73 68 65 84 120 94 99 248 255 255 63 195 127 10 48 69 154 105 103 128 71 223 246 104 175 137 59 55 249 76 222 245 194 119 202 238 255 64 250 153 103 255 142 41 110 61 219 196 136 50 192 119 234 238 69 161 243 14 254 141 88 116 228 98 228 162 163 91 128 244 167 224 57 7 254 123 77 218 121 128 40 3 124 166 238 17 15 153 119 72 14 198 143 92 124 60 51 106 233 137 255 65 179 15 124 39 57 12 220 250 119 240 5 204 58 112 48 114 201 241 255 193 115 15 237 38 201 0 219 150 13 6 46 61 219 238 249 207 220 255 63 120 222 225 195 222 83 247 136 146 100 128 67 231 150 187 158 83 246 252 247 157 177 191 215 99 210 110 102 146 162 209 178 113 29 151 75 223 142 51 158 83 247 158 113 238 219 46 65 86 58 176 239 220 34 232 216 181 85 140 172 132 100 90 189 210 194 186 105 253 47 235 230 13 255 204 106 86 197 147 108 0 80 147 134 125 251 230 103 246 29 91 62 88 212 173 241 26 98 121 129 20 12 0 120 52 215 196 149 111 118 146 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'tests - files' }
DSWebhookClientTest >> testFileNameMorph [
	client := self classToTest new 
		fileName: self anyString morph: World.
	self assert: client post mimeParts size equals: 1.
	self assert: client post mimeParts first fieldName equals: self anyString.
	self assert: client post mimeParts first fileName equals: self anyString.
	self assert: client post mimeParts first contents isCollection.
]

{ #category : 'tests' }
DSWebhookClientTest >> testIfFail [
	| block |
	client := self classToTest new.
	block := [ :exception | exception ].
	client ifFail: block.
	self assert: client ifFailBlock equals: block.
]

{ #category : 'tests' }
DSWebhookClientTest >> testIfFailBlock [
	client := self classToTest new.
	self assert: client ifFailBlock isBlock.
]

{ #category : 'tests' }
DSWebhookClientTest >> testMessage [
	client := self classToTest new message: self messageString.
	self assert: client post content equals: self messageString.
]

{ #category : 'tests' }
DSWebhookClientTest >> testPost [
	client := self classToTest new.
	self assert: client post class equals: DSWebhookJsonPost.
	self assert: client post == client post.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError2 [
	"Post JSON entity"
	| port |
	server := ZnServer startOn: 0.
	port := server serverSocket port.
	server stop.
	client := self classToTest new 
		url: 'http://localhost:', port asString;
		message: self messageString.
	self should: [ client send ] raise: ConnectionTimedOut.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError3 [
	"Post multi-part data form entity"
	| port |
	server := ZnServer startOn: 0.
	port := server serverSocket port.
	server stop.
	client := self classToTest new 
		url: 'http://localhost:', port asString;
		message: self messageString;
		fileName: self anyString bytes: self bytes.
	self should: [ client send ] raise: ConnectionTimedOut.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError4 [
	"Post JSON entity"
	| port response |
	server := ZnServer startOn: 0.
	port := server serverSocket port.
	client := self classToTest new 
		url: 'http://localhost:', port asString, '/doesNotExists';
		message: self messageString.
	self should: [ response := client send ] raise: DSResponseError.
	self assert: response isNil.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError5 [
	"Post multi-part data form entity"
	| port response |
	server := ZnServer startOn: 0.
	port := server serverSocket port.
	client := self classToTest new 
		url: 'http://localhost:', port asString, '/doesNotExists';
		message: self messageString;
		fileName: self anyString bytes: self bytes.
	self should: [ response := client send ] raise: DSResponseError.
	self assert: response isNil.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError6 [
	"Post multi-part data form entity"
	client := self classToTest new 
		url: 'http://nonexistingserver.localhost.';
		message: self messageString;
		fileName: self anyString bytes: self bytes.
	self should: [ client send ] raise: NameLookupFailure.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testPostNetworkError7 [
	"Post JSON entity"
	client := self classToTest new 
		url: 'http://nonexistingserver.localhost.';
		message: self messageString.
	self should: [ client send ] raise: NameLookupFailure.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSend [
	"Send JSON entity"
	| message |
	self startZnServer.
	server delegate map: '/' to: [ :request :response | 
		response entity: self messageEntity ].
	client := self classToTest new 
		url: self serverUrl;
		message: self messageString.
	message := client send.
	self assert: message class equals: DSMessage.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSend2 [
	"Send multi-part data form entity"
	| message |
	self startZnServer.
	server delegate map: '/' to: [ :request :response | 
		response entity: self messageEntity ].
	client := self classToTest new 
		url: self serverUrl;
		message: self messageString;
		fileName: self anyString bytes: self bytes.
	message := client send.
	self assert: message class equals: DSMessage.
]

{ #category : 'tests - discord server' }
DSWebhookClientTest >> testSendToDiscord [
	"Post JSON entity"
	| message url |
	url := self externalWebhookTokenOrNil.
	url ifNil: [ ^ self skip: 'Webhook URL is not set.' ].
	client := self classToTest new 
		url: url;
		message: self continuousIntegrationMessageString.
	message := client send.
	self assert: message class equals: DSMessage.
]

{ #category : 'tests' }
DSWebhookClientTest >> testSetWaitForResponse [
	client := self classToTest new url: self url.
	client setWaitForResponse.
	self assert: client url hasQuery.
	self assert: (client url queryAt: #wait) equals: 'true'.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors [
	"Post JSON entity"
	| response |
	self startZnServer.
	client := self classToTest new 
		url: self serverUrl;
		message: self messageString;
		supressNetworkErrors.
	server stop.
	response := client send.
	self assert: response isNil
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors2 [
	"Post multi-part data form entity"
	| response |
	self startZnServer.
	client := self classToTest new 
		url: self serverUrl;
		message: self messageString;
		fileName: self anyString bytes: self bytes;
		supressNetworkErrors.
	server stop.
	response := client send.
	self assert: response isNil
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors3 [
	"Post JSON entity"
	| result |
	self startZnServer.
	server delegate map: '/' to: [ :request :response | 
		response entity: self messageEntity ].
	client := self classToTest new 
		url: self serverUrl / 'doesNotExists';
		message: self messageString;
		supressNetworkErrors.
	result := client send.
	self assert: result class equals: DSResponseError.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors4 [
	"Post multi-part data form entity"
	| result |
	self startZnServer.
	client := self classToTest new 
		url: self serverUrl / 'doesNotExists';
		message: self messageString;
		fileName: self anyString bytes: self bytes;
		supressNetworkErrors.
	result := client send.
	self assert: result class equals: DSResponseError.
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors5 [
	"Post JSON entity"
	| response |
	client := self classToTest new 
		url: 'http://nonexistingserver.localhost.';
		message: self messageString;
		supressNetworkErrors.
	response := client send.
	self assert: response isNil
]

{ #category : 'test - sending' }
DSWebhookClientTest >> testSupressNetworkErrors6 [
	"Post multi-part data form entity"
	| response |
	client := self classToTest new 
		url: 'http://nonexistingserver.localhost.';
		message: self messageString;
		fileName: self anyString bytes: self bytes;
		supressNetworkErrors.
	response := client send.
	self assert: response isNil
]

{ #category : 'tests' }
DSWebhookClientTest >> testUnSetWaitForResponse [
	client := self classToTest new url: self url.
	client unsetWaitForResponse.
	self assert: client url hasQuery.
	self assert: (client url queryAt: #wait) equals: 'false'.
]

{ #category : 'tests' }
DSWebhookClientTest >> testUrl [
	client := self classToTest new url: self url.
	self assert: client url equals: self url asZnUrl ? ('wait' -> false).
]

{ #category : 'tests' }
DSWebhookClientTest >> testUsername [
	client := self classToTest new 
		message: self messageString;
		username: self username;
		yourself.
	self assert: client post username equals: self username.
	self assert: client post content equals: self messageString.
]

{ #category : 'tests' }
DSWebhookClientTest >> testUsername2 [
	client := self classToTest new 
		username: self username;
		message: self messageString;
		yourself.
	self assert: client post username equals: self username.
	self assert: client post content equals: self messageString.
]

{ #category : 'tests' }
DSWebhookClientTest >> testWaitForResponse [
	client := self classToTest new url: self url.
	self assert: client url hasQuery.
	self assert: (client url queryAt: #wait) equals: 'false'.
]

{ #category : 'defaults' }
DSWebhookClientTest >> url [
	^ 'https://discordapp.com/api/webhooks/webhook-id/webhook-token'
]

{ #category : 'defaults' }
DSWebhookClientTest >> username [
	^ 'user one'
]

{ #category : 'defaults' }
DSWebhookClientTest >> webhookId [
	^ 'webhook-id'
]

{ #category : 'defaults' }
DSWebhookClientTest >> webhookToken [
	^ 'webhook-token'
]
