Class {
	#name : #DSSharedCodeSnippet,
	#superclass : #DSSharedData,
	#instVars : [
		'string'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #accessing }
DSSharedCodeSnippet class >> typeName [
	"Return a string data representation.
	It should be a short string including only [a-z] characters."
	<return: #String>
	^ #codeSnippet
]

{ #category : #visiting }
DSSharedCodeSnippet >> accept: aVisitor [
	^ aVisitor visitDSSharedCodeSnippet: self
]

{ #category : #accessing }
DSSharedCodeSnippet >> contents: aByteArrayOrNil [
	"The argument should be a decoded UFT8 string."
	aByteArrayOrNil ifNil: [ ^ self ].
	string := aByteArrayOrNil utf8Decoded.
]

{ #category : #initialization }
DSSharedCodeSnippet >> initialize [
	super initialize.
	string := ''.
]

{ #category : #testing }
DSSharedCodeSnippet >> isCodeSnippet [
	^ true
]

{ #category : #accessing }
DSSharedCodeSnippet >> string [
	"Return a string representing code snippet."
	<return: #String>
	^ string
]
