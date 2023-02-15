Extension { #name : #DSModelJsonMapping }

{ #category : #'*Discord-WebhookClient' }
DSModelJsonMapping classSide >> jsonWebhookPost [
	^ '{"content":"the message contents (up to 2000 characters)","username":"override the default username of the webhook","avatar_url":"http://example.com/avatar.png","tts":true,"embeds":', 
	self jsonCollectionOfEmbedsOne, '}'
]

{ #category : #'*Discord-WebhookClient' }
DSModelJsonMapping classSide >> webhookPostMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSWebhookJsonPost do: [ :mapping |
	      mapping mapAccessor: #content.
	      mapping mapAccessor: #username.
			(mapping mapAccessor: #avatarUrl to: #avatar_url) valueSchema: ZnUrl.
	      mapping mapAccessor: #isTextToSpeech to: #tts.
			(mapping mapAccessor: #embeds) valueSchema: #CollectionOfEmbeds ];
		for: DSWebhookDataPost do: [ :mapping |
	      mapping mapAccessor: #content.
	      mapping mapAccessor: #username.
			(mapping mapAccessor: #avatarUrl to: #avatar_url) valueSchema: ZnUrl.
	      mapping mapAccessor: #isTextToSpeech to: #tts.
			(mapping mapAccessor: #embeds) valueSchema: #CollectionOfEmbeds ].
	self 
		urlMappingFor: aNeoJSONMapper;
		collectionOfEmbedsMappingFor: aNeoJSONMapper.
]
