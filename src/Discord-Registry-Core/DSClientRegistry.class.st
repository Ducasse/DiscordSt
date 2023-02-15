Class {
	#name : #DSClientRegistry,
	#superclass : #DSSingletonClientRegistry,
	#instVars : [
		'client'
	],
	#category : 'Discord-Registry-Core'
}

{ #category : #examples }
DSClientRegistry class >> emailPassword [
	<gtExample>
	<label: 'Client email and password'>
	^ self new
		email: 'contact@example.com';
		password: 'secret password';
		yourself
]

{ #category : #examples }
DSClientRegistry class >> mockClient [
	<gtExample>
	<label: 'Client email and password'>
	^ self new
		client: DSMockClient unsigned;
		yourself
]

{ #category : #accessing }
DSClientRegistry >> client [
	^ client
]

{ #category : #accessing }
DSClientRegistry >> client: aDSClient [
	client := aDSClient
]

{ #category : #initialization }
DSClientRegistry >> initialize [
	super initialize.
	client := DSClient new.
]
