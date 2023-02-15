Extension { #name : #DSPostToEntityCommand }

{ #category : #'*Discord-WebhookClient' }
DSPostToEntityCommand >> visitDSDataWebhookPost: aDSWebhookDataPost [ 
	| part payloadJson |
	self entity: ZnMultiPartFormDataEntity new.
	payloadJson := DSModelJsonMapping write: aDSWebhookDataPost mappedTo: #webhookPostMappingFor:.
	part := ZnMimePart fieldName: 'payload_json' value: payloadJson.
	entity addPart: part.
	aDSWebhookDataPost mimeParts do: [ :eachPart |
		entity addPart: eachPart ].
]

{ #category : #'*Discord-WebhookClient' }
DSPostToEntityCommand >> visitDSJSONWebhookPost: aDSWebhookJsonPost [ 
	self entity: (
		ZnEntity text: (
			DSModelJsonMapping write: aDSWebhookJsonPost mappedTo: #webhookPostMappingFor:)).
	self entity contentType: ZnMimeType applicationJson.
]
