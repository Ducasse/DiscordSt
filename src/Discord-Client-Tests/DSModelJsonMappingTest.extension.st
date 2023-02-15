Extension { #name : #DSModelJsonMappingTest }

{ #category : #'*Discord-Client-Tests' }
DSModelJsonMappingTest >> testClientPostMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonClientPost.
	result := self read: jsonString as: DSClientJsonPost mappedTo: #clientPostMappingFor:.
	self assert: result class equals: DSClientJsonPost.
	self assert: result content equals: 'the message contents (up to 2000 characters)'.
	self assert: result nonce equals: '1343243'.
	self assert: result isTextToSpeech.
	self assert: result embed class equals: DSEmbed.
	jsonResult := self write: result mappedTo: #clientPostMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : #'*Discord-Client-Tests' }
DSModelJsonMappingTest >> testClientPostMappingFor2 [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonClientPost.
	result := self read: jsonString as: DSClientDataPost mappedTo: #clientPostMappingFor:.
	self assert: result class equals: DSClientDataPost.
	self assert: result content equals: 'the message contents (up to 2000 characters)'.
	self assert: result nonce equals: '1343243'.
	self assert: result isTextToSpeech.
	self assert: result embed class equals: DSEmbed.
	jsonResult := self write: result mappedTo: #clientPostMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : #'*Discord-Client-Tests' }
DSModelJsonMappingTest >> testClientSessionEmailAndPasswordMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonSessionEmailAndPassword.
	result := self read: jsonString as: DSSession mappedTo: #clientSessionEmailAndPasswordMappingFor:.
	self assert: result class equals: DSSession.
	self assert: result email equals: 'name@example.com'.
	self assert: result password equals: 'a secret password'.
	jsonResult := self write: result mappedTo: #clientSessionEmailAndPasswordMappingFor:.
	self assert: jsonResult equals: jsonString.
]

{ #category : #'*Discord-Client-Tests' }
DSModelJsonMappingTest >> testSessionTokenMappingFor [
	| result jsonResult jsonString |
	jsonString := self classToTest jsonSessionToken.
	result := self read: jsonString as: DSSession mappedTo: #clientSessionTokenMappingFor:.
	self assert: result class equals: DSSession.
	self assert: result token equals: 'a secret token'.
	jsonResult := self write: result mappedTo: #clientSessionTokenMappingFor:.
	self assert: jsonResult equals: jsonString.
]
