"
I represent Discord Embed object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-object

{{{
DSEmbedObject new 
		title: 'title message'; 
		description: 'description message';
		url: 'http://example.com';
		color: Color green;
		yourself
}}}

"
Class {
	#name : 'DSEmbed',
	#superclass : 'DSObject',
	#instVars : [
		'title',
		'type',
		'description',
		'url',
		'timestamp',
		'color',
		'footer',
		'image',
		'thumbnail',
		'video',
		'provider',
		'author',
		'fields'
	],
	#category : 'Discord-Core-Model',
	#package : 'Discord-Core',
	#tag : 'Model'
}

{ #category : 'examples' }
DSEmbed class >> all [

	^ self new
		description: 'I am a description of the embed object.';
		image: DSEmbedImage screenshot;
		color: Color yellow;
		yourself
]

{ #category : 'examples' }
DSEmbed class >> description [
	
	^ self new
		description: 'I am a description of the embed object.';
		color: Color green;
		yourself
]

{ #category : 'examples' }
DSEmbed class >> screenshot [
	
	^ self new
		image: DSEmbedImage screenshot;
		color: Color blue;
		yourself
]

{ #category : 'adding' }
DSEmbed >> addField: aDSField [
	^ self fields add: aDSField 
]

{ #category : 'accessing' }
DSEmbed >> author [
	^ author
]

{ #category : 'accessing' }
DSEmbed >> author: anObject [
	author := anObject
]

{ #category : 'accessing' }
DSEmbed >> color [
	^ color
]

{ #category : 'accessing' }
DSEmbed >> color: anObject [
	color := anObject
]

{ #category : 'accessing' }
DSEmbed >> description [
	^ description
]

{ #category : 'accessing' }
DSEmbed >> description: aString [ 
	aString size > DSConstants maxMessageLenght 
		ifTrue: [ DSLongMessageError new
			content: aString;
			signal: 'Message ', aString size asString, ' long, max. is ', DSConstants maxMessageLenght asString ].
	description := aString
]

{ #category : 'private' }
DSEmbed >> ensureFooter [
	"Create a footer object if necessary and return it."
	self footer ifNil: [ self footer: self newFooterObject ].
	^ self footer
]

{ #category : 'private' }
DSEmbed >> ensureImage [
	"Create an image object if necessary and return it."
	self image ifNil: [ self image: self newEmbedImage ].
	^ self image
]

{ #category : 'private' }
DSEmbed >> ensureProvider [
	"Create an provider object if necessary and return it."
	self provider ifNil: [ self provider: self newEmbedProvider ].
	^ self provider
]

{ #category : 'private' }
DSEmbed >> ensureThumbnail [
	"Create a thumbnail object if necessary and return it."
	self thumbnail ifNil: [ self thumbnail: self newEmbedThumbnail ].
	^ self thumbnail
]

{ #category : 'private' }
DSEmbed >> ensureVideo [
	"Create a video object if necessary and return it."
	self video ifNil: [ self video: self newEmbedVideo ].
	^ self video
]

{ #category : 'convenience' }
DSEmbed >> fieldName: fieldName value: fieldValue [
	^ self addField: (DSEmbedField new 
		name: fieldName; 
		value: fieldValue; 
		yourself)
]

{ #category : 'accessing' }
DSEmbed >> fields [
	^ fields ifNil: [ fields := OrderedCollection new ]
]

{ #category : 'accessing' }
DSEmbed >> fields: anObject [
	fields := anObject
]

{ #category : 'accessing' }
DSEmbed >> footer [
	^ footer
]

{ #category : 'accessing' }
DSEmbed >> footer: anObject [
	footer := anObject
]

{ #category : 'convenience' }
DSEmbed >> footerIconUrl: aString [ 
	^ self ensureFooter iconUrl: aString
]

{ #category : 'convenience' }
DSEmbed >> footerText: aString [ 
	self ensureFooter text: aString
]

{ #category : 'testing' }
DSEmbed >> hasDescription [
	"Return true if a description exists."
	^ self description isEmptyOrNil not
]

{ #category : 'testing' }
DSEmbed >> hasImage [
	"Return true if an image is attached."
	^ self image notNil
]

{ #category : 'accessing' }
DSEmbed >> image [
	^ image
]

{ #category : 'accessing' }
DSEmbed >> image: anObject [
	image := anObject
]

{ #category : 'convenience' }
DSEmbed >> imageHeight: aString [ 
	^ self ensureImage height: aString
]

{ #category : 'convenience' }
DSEmbed >> imageUrl: aString [ 
	^ self ensureImage url: aString
]

{ #category : 'convenience' }
DSEmbed >> imageWidth: aString [ 
	^ self ensureImage width: aString
]

{ #category : 'convenience' }
DSEmbed >> inlineFieldName: fieldName value: fieldValue [
	^ self addField: (DSEmbedField new 
		name: fieldName; 
		value: fieldValue; 
		beInline;
		yourself)
]

{ #category : 'testing' }
DSEmbed >> isEmbed [
	^ true
]

{ #category : 'instance creation' }
DSEmbed >> newEmbedImage [
	^ DSEmbedImage new
]

{ #category : 'instance creation' }
DSEmbed >> newEmbedProvider [
	^ DSEmbedProvider new
]

{ #category : 'instance creation' }
DSEmbed >> newEmbedThumbnail [
	^ DSEmbedThumbnail new
]

{ #category : 'instance creation' }
DSEmbed >> newEmbedVideo [
	^ DSEmbedVideo new
]

{ #category : 'instance creation' }
DSEmbed >> newFooterObject [
	^ DSEmbedFooter new
]

{ #category : 'printing' }
DSEmbed >> printFullMessageOn: aTextStream [ 
	self title ifNotNil: [ :string | aTextStream << string << String crlf ].
	self description ifNotNil: [ :string | aTextStream << string << String crlfcrlf ].
	self fields do: [ :eachField | 
		eachField printFullMessageOn: aTextStream.
		aTextStream << String crlf ].
	self footer ifNotNil: [ :aFooter | 
		aFooter printFullMessageOn: aTextStream ]
]

{ #category : 'accessing' }
DSEmbed >> provider [
	^ provider
]

{ #category : 'accessing' }
DSEmbed >> provider: anObject [
	provider := anObject
]

{ #category : 'convenience' }
DSEmbed >> providerName: aString [ 
	^ self ensureProvider name: aString
]

{ #category : 'convenience' }
DSEmbed >> providerUrl: aString [ 
	^ self ensureProvider url: aString
]

{ #category : 'accessing' }
DSEmbed >> thumbnail [
	^ thumbnail
]

{ #category : 'accessing' }
DSEmbed >> thumbnail: anObject [
	thumbnail := anObject
]

{ #category : 'convenience' }
DSEmbed >> thumbnailHeight: aString [ 
	^ self ensureThumbnail height: aString
]

{ #category : 'convenience' }
DSEmbed >> thumbnailUrl: aString [ 
	^ self ensureThumbnail url: aString
]

{ #category : 'convenience' }
DSEmbed >> thumbnailWidth: aString [ 
	^ self ensureThumbnail width: aString
]

{ #category : 'accessing' }
DSEmbed >> timestamp [
	^ timestamp
]

{ #category : 'accessing' }
DSEmbed >> timestamp: anObject [
	timestamp := anObject
]

{ #category : 'accessing' }
DSEmbed >> title [
	^ title
]

{ #category : 'accessing' }
DSEmbed >> title: anObject [
	title := anObject
]

{ #category : 'accessing' }
DSEmbed >> type [
	^ type
]

{ #category : 'accessing' }
DSEmbed >> type: anObject [
	type := anObject
]

{ #category : 'accessing' }
DSEmbed >> url [
	^ url
]

{ #category : 'accessing' }
DSEmbed >> url: anObject [
	url := anObject
]

{ #category : 'accessing' }
DSEmbed >> video [
	^ video
]

{ #category : 'accessing' }
DSEmbed >> video: anObject [
	video := anObject
]

{ #category : 'convenience' }
DSEmbed >> videoHeight: aString [ 
	^ self ensureVideo height: aString
]

{ #category : 'convenience' }
DSEmbed >> videoUrl: aString [ 
	^ self ensureVideo url: aString
]

{ #category : 'convenience' }
DSEmbed >> videoWidth: aString [ 
	^ self ensureVideo width: aString
]
