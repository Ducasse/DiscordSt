"
A DSEmbedObjectTest is a test class for testing the behavior of DSEmbedObject
"
Class {
	#name : #DSEmbedTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSEmbedTest >> newObjectToTest [
	^ self newEmbedObject 
]

{ #category : #tests }
DSEmbedTest >> testColor [
	object := self newEmbedObject color: self color; yourself.
	self assert: object color equals: self color.
]

{ #category : #tests }
DSEmbedTest >> testDescription [
	object := self newEmbedObject description: self anyString; yourself.
	self assert: object description equals: self anyString.
]

{ #category : #tests }
DSEmbedTest >> testDescriptionMaxLenght [
	| content |
	content := (String loremIpsum: DSConstants maxMessageLenght).
	object := self newEmbedObject 
		description: content; 
		yourself.
	self assert: object description equals: content.

]

{ #category : #tests }
DSEmbedTest >> testDescriptionMaxLenghtError [
	| content |
	content := (String loremIpsum: DSConstants maxMessageLenght + 1).
	object := self newEmbedObject.
	self should: [ object description: content ] raise: DSLongMessageError.
	self assert: object description equals: nil.
]

{ #category : #tests }
DSEmbedTest >> testEnsureFooter [
	object := self newEmbedObject.
	self assert: object ensureFooter class equals: DSEmbedFooter.
	self assert: object ensureFooter == object ensureFooter.
]

{ #category : #tests }
DSEmbedTest >> testFields [
	object := self newObjectToTest.
	self assert: object fields isCollection.
	self assert: object fields class equals: OrderedCollection.
]

{ #category : #tests }
DSEmbedTest >> testFooter [
	| footer |
	footer := self newEmbedFooterObject.
	object := self newEmbedObject footer: footer; yourself.
	self assert: object footer == footer.
]

{ #category : #tests }
DSEmbedTest >> testFooterIconUrl [
	object := self newEmbedObject footerIconUrl: self anyString; yourself.
	self assert: object footer iconUrl equals: self anyString.
]

{ #category : #tests }
DSEmbedTest >> testFooterText [
	object := self newEmbedObject footerText: self anyString; yourself.
	self assert: object footer text equals: self anyString.
]

{ #category : #tests }
DSEmbedTest >> testTitle [
	object := self newEmbedObject title: self titleString; yourself.
	self assert: object title equals: self titleString.
]

{ #category : #tests }
DSEmbedTest >> testUrl [
	object := self newEmbedObject url: self anyString; yourself.
	self assert: object url equals: self anyString.
]
