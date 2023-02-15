"
I extract a code snippet from a given GT-Playground.
"
Class {
	#name : #DSExtractPlaygroundCodeSnippetCommand,
	#superclass : #DSToolCommand,
	#instVars : [
		'playground',
		'codeSnippet',
		'selectionInterval',
		'selectionText'
	],
	#category : 'Discord-Tools-Commands'
}

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> codeSnippet [
	<return: #String>
	^ codeSnippet
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #execute }
DSExtractPlaygroundCodeSnippetCommand >> execute [
	| aValue |
	self codeSnippet: self playground entity content.
	aValue := (self playground pane port: #selectionInterval) value.
	aValue := aValue ifNil: [ 0 to: 0 ].
	self selectionInterval: aValue.
	aValue := (self playground pane port: #selectedText) value.
	aValue := aValue ifNil: [ '' ].
	self selectionText: aValue asString.
]

{ #category : #testing }
DSExtractPlaygroundCodeSnippetCommand >> hasCodeSnippet [
	^ self codeSnippet isNotEmpty
]

{ #category : #testing }
DSExtractPlaygroundCodeSnippetCommand >> hasSelection [
	^ self selectionText notEmpty and: [ self selectionText size < self codeSnippet size ]
]

{ #category : #'accessing - computed' }
DSExtractPlaygroundCodeSnippetCommand >> markdown [
	"Return Markdown representation of a Playground code snippet"
	<return: #String>
	^ self hasSelection 
		ifTrue: [ DSUtility smalltalkMarkdownOf: self selectionText trimBoth ]
		ifFalse: [ DSUtility smalltalkMarkdownOf: self codeSnippet trimBoth ]
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> playground [
	<return: #GTPlayground>
	^ playground
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> playground: anObject [
	playground := anObject
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> selectionInterval [
	^ selectionInterval
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> selectionInterval: anObject [
	selectionInterval := anObject
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> selectionText [
	^ selectionText
]

{ #category : #accessing }
DSExtractPlaygroundCodeSnippetCommand >> selectionText: anObject [
	selectionText := anObject
]
