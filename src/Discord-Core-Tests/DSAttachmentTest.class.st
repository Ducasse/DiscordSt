"
A DSAttachmentTest is a test class for testing the behavior of DSAttachment
"
Class {
	#name : #DSAttachmentTest,
	#superclass : #DSObjectTest,
	#instVars : [
		'attachment'
	],
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSAttachmentTest >> newObjectToTest [
	^ self newAttachment 
]

{ #category : #tests }
DSAttachmentTest >> testData [
	| bytes |
	self startZnServer.
	self serverDelegate map: '/' to: [ :request :response | 
		response entity: (ZnEntity bytes: self bytes) ].
	attachment := self newAttachment.
	attachment url: self serverUrl.
	bytes := attachment data.
	self assert: bytes equals: self bytes.
	self assert: attachment data == bytes.
	self assert: attachment hasData.
]

{ #category : #tests }
DSAttachmentTest >> testFileSize [
	attachment := self newAttachment.
	attachment fileSize: 42.
	self assert: attachment fileSize equals: 42.
]

{ #category : #tests }
DSAttachmentTest >> testFilename [
	attachment := self newAttachment.
	attachment filename: self anyString.
	self assert: attachment filename equals: self anyString.
]

{ #category : #tests }
DSAttachmentTest >> testHasData [
	attachment := self newAttachment.
	self deny: attachment hasData.
]

{ #category : #tests }
DSAttachmentTest >> testHeight [
	attachment := self newAttachment.
	attachment height: 42.
	self assert: attachment height equals: 42.
]

{ #category : #tests }
DSAttachmentTest >> testId [
	attachment := self newAttachment.
	attachment id: self anyString.
	self assert: attachment id equals: self anyString.
]

{ #category : #tests }
DSAttachmentTest >> testIsImage [
	attachment := self newAttachment.
	self deny: attachment isImage
]

{ #category : #tests }
DSAttachmentTest >> testIsImageTrue [
	attachment := self newAttachment.
	attachment width: 42; height: 42.
	self assert: attachment isImage.
]

{ #category : #tests }
DSAttachmentTest >> testPrintString [
	attachment := self newAttachment.
	self assert: attachment printString isString.
]

{ #category : #tests }
DSAttachmentTest >> testPrintString2 [
	attachment := self newAttachment.
	attachment filename: self anyString; height: 32; width: 32.
	self assert: attachment printString isString.
]

{ #category : #tests }
DSAttachmentTest >> testProxyUrl [
	attachment := self newAttachment.
	attachment proxyUrl: self anyString.
	self assert: attachment proxyUrl equals: self anyString.
]

{ #category : #tests }
DSAttachmentTest >> testUrl [
	attachment := self newAttachment.
	attachment url: self anyString.
	self assert: attachment url equals: self anyString.
]

{ #category : #tests }
DSAttachmentTest >> testWidth [
	attachment := self newAttachment.
	attachment width: 42.
	self assert: attachment width equals: 42.
]
