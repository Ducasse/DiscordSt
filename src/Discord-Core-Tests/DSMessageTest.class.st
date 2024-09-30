"
A DSMessageTest is a test class for testing the behavior of DSMessage
"
Class {
	#name : 'DSMessageTest',
	#superclass : 'DSObjectTest',
	#instVars : [
		'message'
	],
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'instance creation' }
DSMessageTest >> newObjectToTest [
	^ self newMessage 
]

{ #category : 'tests' }
DSMessageTest >> testAttachments [
	message := self newMessage.
	message attachments: self newEmptyArray.
	self assert: message attachments equals: self newEmptyArray.
]

{ #category : 'tests' }
DSMessageTest >> testAuthor [
	| author |
	message := self newMessage.
	author := self newUser.
	message author: author.
	self assert: message author equals: author.
]

{ #category : 'tests' }
DSMessageTest >> testChannelId [
	message := self newMessage.
	message channelId: self anyString.
	self assert: message channelId equals: self anyString.
]

{ #category : 'tests' }
DSMessageTest >> testContent [
	message := self newMessage.
	message content: self anyString.
	self assert: message content equals: self anyString.
	self assert: message hasContent.
]

{ #category : 'tests' }
DSMessageTest >> testContentMaxLenght [
	| content |
	message := self newMessage.
	content := String loremIpsum: DSConstants maxMessageLenght.
	message content: content.
	self assert: message content equals: content.
	self assert: message hasContent.
]

{ #category : 'tests' }
DSMessageTest >> testContentMaxLenghtError [
	"It should produce an error because of maximum lenght."
	| content |
	message := self newMessage.
	content := String loremIpsum: DSConstants maxMessageLenght + 1.
	self should: [ message content: content ] raise: DSLongMessageError.
	self assert: message content equals: nil.
	self deny: message hasContent.
]

{ #category : 'tests' }
DSMessageTest >> testEditedTimestamp [
	message := self newMessage.
	message editedTimestamp: self newDateAndTime.
	self assert: message editedTimestamp equals: self newDateAndTime.
]

{ #category : 'tests' }
DSMessageTest >> testEmbeds [
	message := self newMessage.
	message embeds: self newEmptyArray.
	self assert: message embeds equals: self newEmptyArray.
]

{ #category : 'tests' }
DSMessageTest >> testFromJsonStringAttachment [
	"Check attachment object"
	| api |
	api := self newRestApi.
	message := self coreModelJsonMapping read: DSMessage withMapping: #messageMappingFor: on: self coreModelJsonMapping jsonMessage readStream.
	message restApi: api.
	self assert: message restApi notNil.
	self assert: message restApi == api.
	self assert: message attachments isArray.
	self assert: message attachments size equals: 1.
	self assert: message attachments first isAttachment.
	self assert: message hasAttachments.
]

{ #category : 'tests' }
DSMessageTest >> testHasAttachments [
	message := self newMessage.
	self deny: message hasAttachments.
]

{ #category : 'tests' }
DSMessageTest >> testHasContent [
	"Default object does not have a content"
	message := self newMessage.
	self deny: message hasContent.
]

{ #category : 'tests' }
DSMessageTest >> testHasImageAttachments [
	message := self newMessage.
	message attachments: (Array with: (self newAttachment 
		url: 'http://example.com/image.png'; width: 512; height: 321; yourself)).
	self assert: message hasImageAttachments.
]

{ #category : 'tests' }
DSMessageTest >> testHasMentionEveryone [
	message := self newMessage.
	message hasMentionEveryone: true.
	self assert: message hasMentionEveryone
]

{ #category : 'tests' }
DSMessageTest >> testHasMentionEveryone2 [
	message := self newMessage.
	message hasMentionEveryone: false.
	self deny: message hasMentionEveryone
]

{ #category : 'tests' }
DSMessageTest >> testId [
	message := self newMessage.
	message id: self anyString.
	self assert: message id equals: self anyString.
]

{ #category : 'tests' }
DSMessageTest >> testIsMessage [
	self assert: self newMessage isMessage
]

{ #category : 'tests' }
DSMessageTest >> testIsPinnedInChannel [
	message := self newMessage.
	message isPinnedInChannel: true.
	self assert: message isPinnedInChannel
]

{ #category : 'tests' }
DSMessageTest >> testIsPinnedInChannel2 [
	message := self newMessage.
	message isPinnedInChannel: false.
	self deny: message isPinnedInChannel
]

{ #category : 'tests' }
DSMessageTest >> testIsTextToSpeech [
	message := self newMessage.
	message isTextToSpeech: true.
	self assert: message isTextToSpeech
]

{ #category : 'tests' }
DSMessageTest >> testIsTextToSpeech2 [
	message := self newMessage.
	message isTextToSpeech: false.
	self deny: message isTextToSpeech
]

{ #category : 'tests' }
DSMessageTest >> testMentions [
	message := self newMessage.
	message mentions: self newEmptyArray.
	self assert: message mentions equals: self newEmptyArray.
]

{ #category : 'tests' }
DSMessageTest >> testNonce [
	message := self newMessage.
	message nonce: self anyString.
	self assert: message nonce equals: self anyString.
]

{ #category : 'tests' }
DSMessageTest >> testReactions [
	message := self newMessage.
	message reactions: self newEmptyArray.
	self assert: message reactions equals: self newEmptyArray.
]

{ #category : 'tests' }
DSMessageTest >> testTimestamp [
	message := self newMessage.
	message timestamp: self newDateAndTime.
	self assert: message timestamp equals: self newDateAndTime.
]

{ #category : 'tests' }
DSMessageTest >> testWebhookId [
	message := self newMessage.
	message webhookId: self anyString.
	self assert: message webhookId equals: self anyString.
]
