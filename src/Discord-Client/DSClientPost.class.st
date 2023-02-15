"
I represent Discord Message post that can be send as JSON or multipart/form-data format to a Discord API.
I am an abstract class.

I am used by DSClient in order to construct a message to be send to a Discord channel.

See documentation at https://discordapp.com/developers/docs/resources/channel#create-message
"
Class {
	#name : #DSClientPost,
	#superclass : #DSObject,
	#instVars : [
		'content',
		'nonce',
		'isTextToSpeech',
		'embed'
	],
	#category : 'Discord-Client'
}

{ #category : #accessing }
DSClientPost >> content [
	^ content
]

{ #category : #accessing }
DSClientPost >> content: anObject [
	"Set the message contents (up to 2000 characters)"
	| newValue |
	newValue := anObject ifNotNil: #asString.
	newValue ifNotNil: [ 
		newValue size > DSConstants maxMessageLenght 
			ifTrue: [ DSLongMessageError new
				content: newValue;
				signal: 'Content ', newValue size asString, 
					' long, max. is ', DSConstants maxMessageLenght asString ] ].
	content := newValue
]

{ #category : #accessing }
DSClientPost >> embed [
	^ embed
]

{ #category : #accessing }
DSClientPost >> embed: anObject [
	embed := anObject
]

{ #category : #'gt-inspector-extension' }
DSClientPost >> gtChildren [
	"Return children to display in a GT-Inspector tree view.
	Subclasses are encouradged to override it."
	^ self embed ifNil: [ #() ] ifNotNil: [ :anEmbed | Array with: anEmbed ]
]

{ #category : #accessing }
DSClientPost >> isTextToSpeech [
	^ isTextToSpeech
]

{ #category : #accessing }
DSClientPost >> isTextToSpeech: anObject [
	isTextToSpeech := anObject
]

{ #category : #accessing }
DSClientPost >> nonce [
	^ nonce
]

{ #category : #accessing }
DSClientPost >> nonce: anObject [
	nonce := anObject
]
