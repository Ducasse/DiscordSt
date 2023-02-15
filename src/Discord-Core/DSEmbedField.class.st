"
I represent Discord Embed Field object that can be send as JSON to a Discord  API.

See documentation at https://discordapp.com/developers/docs/resources/channel#embed-field-structure

{{{
DSEmbedField new 
	name: 'field-one';
	value: 'my value one';
	beInline;
	yourself
}}}

or as a part of DSEmbed object

{{{
DSEmbed new 
	addFieldName: 'field-one' value: 'my value one';
	addInlineFieldName: 'field-two' value: 'ma value two';
	yourself
}}}

"
Class {
	#name : #DSEmbedField,
	#superclass : #DSObject,
	#instVars : [
		'name',
		'value',
		'isInline'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #protocol }
DSEmbedField >> beInline [
	^ self isInline: true
]

{ #category : #accessing }
DSEmbedField >> isInline [
	^ isInline ifNil: false
]

{ #category : #accessing }
DSEmbedField >> isInline: anObject [
	isInline := anObject
]

{ #category : #accessing }
DSEmbedField >> name [
	^ name
]

{ #category : #accessing }
DSEmbedField >> name: anObject [
	name := anObject
]

{ #category : #printing }
DSEmbedField >> printFullMessageOn: aTextStream [ 
	aTextStream << self name << ': ' << self value
]

{ #category : #printing }
DSEmbedField >> printOn: aStream [ 
	aStream << 'Field: ' << self name << ': ' << self value
]

{ #category : #accessing }
DSEmbedField >> value [
	^ value
]

{ #category : #accessing }
DSEmbedField >> value: anObject [
	value := anObject
]
