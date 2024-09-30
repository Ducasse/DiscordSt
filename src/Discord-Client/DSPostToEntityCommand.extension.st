Extension { #name : 'DSPostToEntityCommand' }

{ #category : '*Discord-Client' }
DSPostToEntityCommand >> visitDSClientDataPost: aDSClientDataPost [ 
	| part payloadJson |
	self entity: ZnMultiPartFormDataEntity new.
	payloadJson := DSModelJsonMapping write: aDSClientDataPost mappedTo: #clientPostMappingFor:.
	part := ZnMimePart fieldName: 'payload_json' value: payloadJson.
	entity addPart: part.
	aDSClientDataPost mimeParts do: [ :eachPart |
		entity addPart: eachPart ].
]

{ #category : '*Discord-Client' }
DSPostToEntityCommand >> visitDSClientJsonPost: aDSClientJsonPost [ 
	self entity: (
		ZnEntity text: (
			DSModelJsonMapping write: aDSClientJsonPost mappedTo: #clientPostMappingFor:)).
	self entity contentType: ZnMimeType applicationJson.
]
