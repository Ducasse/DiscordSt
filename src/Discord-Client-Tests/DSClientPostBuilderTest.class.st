"
A DSClientPostBuilderTest is a test class for testing the behavior of DSClientPostBuilder
"
Class {
	#name : 'DSClientPostBuilderTest',
	#superclass : 'DSCoreTestCase',
	#instVars : [
		'builder'
	],
	#category : 'Discord-Client-Tests',
	#package : 'Discord-Client-Tests'
}

{ #category : 'coverage' }
DSClientPostBuilderTest >> classToTest [
	^ DSClientPostBuilder
]

{ #category : 'test - protocol - basic' }
DSClientPostBuilderTest >> testChannel [
	| channel |
	channel := DSGuildTextChannel new.
	builder := self newInstanceToBeTested 
		channel: channel;
		yourself.
	self assert: builder channel == channel.
]

{ #category : 'test - protocol - basic' }
DSClientPostBuilderTest >> testContent [
	builder := self newInstanceToBeTested 
		content: self anyString;
		yourself.
	self assert: builder post content equals: self anyString.
]

{ #category : 'test - protocol - basic' }
DSClientPostBuilderTest >> testContentMaxLenght [
	| content |
	content := (String loremIpsum: DSConstants maxMessageLenght).
	builder := self newInstanceToBeTested 
		content: content;
		yourself.
	self assert: builder post content equals: content.
]

{ #category : 'test - protocol - basic' }
DSClientPostBuilderTest >> testContentMaxLenghtError [
	| content |
	content := (String loremIpsum: DSConstants maxMessageLenght + 1).
	builder := self newInstanceToBeTested.
	self should: [ builder content: content ] raise: DSLongMessageError.
	self assert: builder post content equals: nil.
]

{ #category : 'tests' }
DSClientPostBuilderTest >> testDataPost [
	"Create new data post object"
	builder := self newInstanceToBeTested.
	self assert: builder dataPost class equals: DSClientDataPost.
	self assert: builder dataPost == builder dataPost.
	self assert: builder post == builder post.
]

{ #category : 'tests' }
DSClientPostBuilderTest >> testDataPost2 [
	"Convert JSON post to Data post"
	builder := self newInstanceToBeTested.
	builder post: builder newJSONPost.
	self assert: builder dataPost class equals: DSClientDataPost.
	self assert: builder dataPost == builder dataPost.
	self assert: builder post == builder post.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedColor [
	builder := self newInstanceToBeTested 
		embedColor: self color;
		yourself.
	self assert: builder post embed color equals: self color.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedDescription [
	builder := self newInstanceToBeTested 
		embedDescription: self anyString;
		yourself.
	self assert: builder post embed description equals: self anyString.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedFieldNameValue [
	builder := self newInstanceToBeTested 
		embedFieldName: self anyString value: self anyStringTwo;
		yourself.
	self assert: builder post embed fields size equals: 1.
	self assert: builder post embed fields first name equals: self anyString.
	self assert: builder post embed fields first value equals: self anyStringTwo.
	self deny: builder post embed fields first isInline.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedFooterIconUrl [
	builder := self newInstanceToBeTested 
		embedFooterIconUrl: self anyString;
		yourself.
	self assert: builder post embed footer iconUrl equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedFooterText [
	builder := self newInstanceToBeTested 
		embedFooterText: self anyString;
		yourself.
	self assert: builder post embed footer text equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedImageHeight [
	builder := self newInstanceToBeTested 
		embedImageHeight: 42;
		yourself.
	self assert: builder post embed image height equals: 42.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedImageUrl [
	builder := self newInstanceToBeTested 
		embedImageUrl: self anyString;
		yourself.
	self assert: builder post embed image url equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedImageWidth [
	builder := self newInstanceToBeTested 
		embedImageWidth: 42;
		yourself.
	self assert: builder post embed image width equals: 42.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedInlineFieldNameValue [
	builder := self newInstanceToBeTested 
		embedInlineFieldName: self anyString value: self anyStringTwo;
		yourself.
	self assert: builder post embed fields size equals: 1.
	self assert: builder post embed fields first name equals: self anyString.
	self assert: builder post embed fields first value equals: self anyStringTwo.
	self assert: builder post embed fields first isInline.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedProviderName [
	builder := self newInstanceToBeTested 
		embedProviderName: self anyString;
		yourself.
	self assert: builder post embed provider name equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedProviderUrl [
	builder := self newInstanceToBeTested 
		embedProviderUrl: self anyString;
		yourself.
	self assert: builder post embed provider url equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedThumbnailHeight [
	builder := self newInstanceToBeTested 
		embedThumbnailHeight: 42;
		yourself.
	self assert: builder post embed thumbnail height equals: 42.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedThumbnailUrl [
	builder := self newInstanceToBeTested 
		embedThumbnailUrl: self anyString;
		yourself.
	self assert: builder post embed thumbnail url equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedThumbnailWidth [
	builder := self newInstanceToBeTested 
		embedThumbnailWidth: 42;
		yourself.
	self assert: builder post embed thumbnail width equals: 42.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedTitle [
	builder := self newInstanceToBeTested 
		embedTitle: self anyString;
		yourself.
	self assert: builder post embed title equals: self anyString.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedUrl [
	builder := self newInstanceToBeTested 
		embedUrl: self anyString;
		yourself.
	self assert: builder post embed url equals: self anyString.
]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedVideoHeight [
	builder := self newInstanceToBeTested 
		embedVideoHeight: 42;
		yourself.
	self assert: builder post embed video height equals: 42.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedVideoUrl [
	builder := self newInstanceToBeTested 
		embedVideoUrl: self anyString;
		yourself.
	self assert: builder post embed video url equals: self anyString.

]

{ #category : 'test - protocol - embed' }
DSClientPostBuilderTest >> testEmbedVideoWidth [
	builder := self newInstanceToBeTested 
		embedVideoWidth: 42;
		yourself.
	self assert: builder post embed video width equals: 42.

]

{ #category : 'test - protocol - attachments' }
DSClientPostBuilderTest >> testFileNameBytes [
	builder := self newInstanceToBeTested.
	builder fileName: self anyString bytes: self bytes.
	self assert: builder post mimeParts size equals: 1.
	self assert: builder post mimeParts first fieldName equals: self anyString.
	self assert: builder post mimeParts first fileName equals: self anyString.
	self assert: builder post mimeParts first contents equals: self bytes.
]

{ #category : 'test - protocol - attachments' }
DSClientPostBuilderTest >> testFileNameForm [
	"Check that the help icon is properly stored."

	builder := self newInstanceToBeTested.
	builder fileName: self anyString form:
		(self iconNamed: #help).
	self assert: builder post mimeParts size equals: 1.
	self
		assert: builder post mimeParts first fieldName
		equals: self anyString.
	self
		assert: builder post mimeParts first fileName
		equals: self anyString.
	self
		assert: builder post mimeParts first contents
		equals:
			#[137 80 78 71 13 10 26 10 0 0 0 13 73 72 68 82 0 0 0 16 0 0 0 16 8 6 0 0 0 31 243 255 97 0 0 0 244 73 68 65 84 120 94 99 248 255 255 63 195 127 10 48 69 154 105 103 128 71 223 246 104 175 137 59 55 249 76 222 245 194 119 202 238 255 64 250 153 103 255 142 41 110 61 219 196 136 50 192 119 234 238 69 161 243 14 254 141 88 116 228 98 228 162 163 91 128 244 167 224 57 7 254 123 77 218 121 128 40 3 124 166 238 17 15 153 119 72 14 198 143 92 124 60 51 106 233 137 255 65 179 15 124 39 57 12 220 250 119 240 5 204 58 112 48 114 201 241 255 193 115 15 237 38 201 0 219 150 13 6 46 61 219 238 249 207 220 255 63 120 222 225 195 222 83 247 136 146 100 128 67 231 150 187 158 83 246 252 247 157 177 191 215 99 210 110 102 146 162 209 178 113 29 151 75 223 142 51 158 83 247 158 113 238 219 46 65 86 58 176 239 220 34 232 216 181 85 140 172 132 100 90 189 210 194 186 105 253 47 235 230 13 255 204 106 86 197 147 108 0 80 147 134 125 251 230 103 246 29 91 62 88 212 173 241 26 98 121 129 20 12 0 120 52 215 196 149 111 118 146 0 0 0 0 73 69 78 68 174 66 96 130]
]

{ #category : 'test - protocol - attachments' }
DSClientPostBuilderTest >> testFileNameFuelObject [
	builder := self newInstanceToBeTested.
	builder fileName: self anyString fuelObject: self.
	self assert: builder post mimeParts size equals: 1.
	self assert: builder post mimeParts first fieldName equals: self anyString.
	self assert: builder post mimeParts first fileName equals: self anyString.
	self assert: builder post mimeParts first contents class equals: ByteArray.
]

{ #category : 'test - protocol - attachments' }
DSClientPostBuilderTest >> testFileNameMorph [
	"Check that the help icon is properly stored."
	builder := self newInstanceToBeTested.
	builder fileName: self anyString morph: World.
	self assert: builder post mimeParts size equals: 1.
	self assert: builder post mimeParts first fieldName equals: self anyString.
	self assert: builder post mimeParts first fileName equals: self anyString.
	self assert: builder post mimeParts first contents isCollection.
]

{ #category : 'test - protocol - basic' }
DSClientPostBuilderTest >> testNonce [
	builder := self newInstanceToBeTested 
		nonce: self anyString;
		yourself.
	self assert: builder post nonce equals: self anyString.
]

{ #category : 'tests' }
DSClientPostBuilderTest >> testPost [
	"Create JSON post"
	builder := self newInstanceToBeTested.
	self assert: builder post class equals: DSClientJsonPost.
	self assert: builder post == builder post.

]

{ #category : 'test - protocol - sending' }
DSClientPostBuilderTest >> testSend [
	| client message |
	self startZnServer.
	self serverDelegate
		map: '/api/channels/channel-id/messages'
		to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "1234", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "channel-id", "mentions": [], "type": 0}') ].
	client := DSClient new.
	client restApi 
		apiUrl: self apiUrl;
		token: self anyString;
		yourself.
	builder := self newInstanceToBeTested 
		content: self anyString;
		restApi: client restApi;
		channel: (DSGuildTextChannel new id: 'channel-id'; yourself);
		yourself.
	message := builder send.
	self assert: message notNil.
	self assert: message content equals: 'text message'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #POST.
	self assert: builder post isNil.
]

{ #category : 'test - protocol - sending' }
DSClientPostBuilderTest >> testSend2 [
	| client message |
	self startZnServer.
	self serverDelegate
		map: '/api/channels/channel-id-two/messages'
		to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "1234", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "channel-id", "mentions": [], "type": 0}') ].
	client := DSClient new.
	client restApi 
		apiUrl: self apiUrl;
		token: self anyString;
		yourself.
	builder := self newInstanceToBeTested 
		content: self anyString;
		fileName: 'attachment1.data' bytes: self bytes;
		restApi: client restApi;
		channel: (DSGuildTextChannel new id: 'channel-id-two'; yourself);
		yourself.
	message := builder send.
	self assert: message notNil.
	self assert: message content equals: 'text message'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #POST.
	self assert: builder post isNil.
]

{ #category : 'test - protocol - sending' }
DSClientPostBuilderTest >> testSendEmptyMessage [
	builder := self newInstanceToBeTested.
	self should: [ builder send ] raise: DSIncorrectValuesError.
]

{ #category : 'test - protocol - sending' }
DSClientPostBuilderTest >> testSendTo [
	| client message |
	self startZnServer.
	self serverDelegate
		map: '/api/channels/channel-id/messages'
		to: [ :request :response |
		self serverRequests add: request.
		response entity: (ZnEntity text: '{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "1234", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "channel-id", "mentions": [], "type": 0}') ].
	client := DSClient new.
	client restApi 
		apiUrl: self apiUrl;
		token: self anyString;
		yourself.
	builder := self newInstanceToBeTested 
		content: self anyString;
		restApi: client restApi;
		yourself.
	message := builder sendTo: (DSGuildTextChannel new id: 'channel-id'; yourself).
	self assert: message notNil.
	self assert: message content equals: 'text message'.
	self assert: self serverRequests size equals: 1.
	self assert: self serverRequests first method equals: #POST.
	self assert: builder post isNil.
]

{ #category : 'test - protocol - sending' }
DSClientPostBuilderTest >> testSendTo2 [
	| client message |
	self startZnServer.
	self serverDelegate
		map: '/api/users/@me/guilds'
			to: [ :request :response | 
			self serverRequests add: request.
			response
				entity:
					(ZnEntity
						text:
							'[{"owner": false, "permissions": 104332353, "icon": "icon-id", "id": "1234", "name": "Guild One"}]') ];
		map: '/api/guilds/1234/channels'
			to: [ :request :response | 
			self serverRequests add: request.
			response
				entity:
					(ZnEntity
						text:
							'[{"guild_id": "1234", "name": "general", "permission_overwrites": [], "topic": "Channel topic", "position": 0, "last_message_id": "5678", "type": 0, "id": "1234", "is_private": false}]') ];
		map: '/api/channels/1234/messages'
			to: [ :request :response | 
			self serverRequests add: request.
			response
				entity:
					(ZnEntity
						text:
							'{"nonce": null, "attachments": [], "tts": false, "embeds": [], "timestamp": "2017-05-08T15:56:48.149000+00:00", "mention_everyone": false, "id": "5674", "pinned": false, "edited_timestamp": null, "author": {"username": "User one", "discriminator": "5678", "id": "9012", "avatar": null}, "mention_roles": [], "content": "text message", "channel_id": "1234", "mentions": [], "type": 0}') ].
	client := DSClient new.
	client restApi
		apiUrl: self apiUrl;
		token: self anyString;
		yourself.
	builder := self newInstanceToBeTested
		content: self anyString;
		restApi: client restApi;
		yourself.
	message := builder sendTo: [ :servers | servers first general ].
	self assert: message notNil.
	self assert: message content equals: 'text message'.
	self assert: self serverRequests size equals: 3.
	self assert: self serverRequests last method equals: #POST.
	self assert: builder post isNil
]

{ #category : 'tests' }
DSClientPostBuilderTest >> testSignalProgress [
	builder := self newInstanceToBeTested.
	builder signalProgress: true.
	self assert: builder signalProgress.

]

{ #category : 'tests' }
DSClientPostBuilderTest >> testSignalProgressDefault [
	builder := self newInstanceToBeTested.
	self deny: builder signalProgress.

]

{ #category : 'tests' }
DSClientPostBuilderTest >> testSignalProgressFalse [
	builder := self newInstanceToBeTested.
	builder signalProgress: false.
	self deny: builder signalProgress.

]

{ #category : 'tests' }
DSClientPostBuilderTest >> testWith [
	| results returnValue |
	results := OrderedCollection new.
	builder := self newInstanceToBeTested.
	returnValue := builder with: [ :aBuilder | results add: aBuilder. 42 ].
	self assert: results size equals: 1.
	self assert: results first == builder.
	self assert: returnValue equals: 42.
]
