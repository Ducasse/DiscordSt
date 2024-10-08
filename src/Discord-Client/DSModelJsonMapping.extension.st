Extension { #name : 'DSModelJsonMapping' }

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> clientPostMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSClientJsonPost do: [ :mapping |
	      mapping mapAccessor: #content.
	      mapping mapAccessor: #nonce.
			mapping mapAccessor: #isTextToSpeech to: #tts.
			(mapping mapAccessor: #embed) valueSchema: DSEmbed ];
		for: DSClientDataPost do: [ :mapping |
	      mapping mapAccessor: #content.
	      mapping mapAccessor: #nonce.
			mapping mapAccessor: #isTextToSpeech to: #tts.
			(mapping mapAccessor: #embed) valueSchema: DSEmbed ].
	self embedMappingFor: aNeoJSONMapper.
]

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> clientSessionEmailAndPasswordMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSSession do: [ :mapping |
	      mapping mapAccessor: #email.
			mapping mapAccessor: #password ]
]

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> clientSessionTokenMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSSession do: [ :mapping |
	      mapping mapAccessor: #token ]
]

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> jsonClientPost [
	^ '{"content":"the message contents (up to 2000 characters)","nonce":"1343243","tts":true,"embed":', 
	self jsonEmbedOneField,  '}'
]

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> jsonSessionEmailAndPassword [
	^ '{"email":"name@example.com","password":"a secret password"}'
]

{ #category : '*Discord-Client' }
DSModelJsonMapping class >> jsonSessionToken [
	^ '{"token":"a secret token"}'
]
