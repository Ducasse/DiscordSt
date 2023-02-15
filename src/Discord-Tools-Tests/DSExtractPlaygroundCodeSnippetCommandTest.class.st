"
A DSExtractPlaygroundCodeSnippetCommandTest is a test class for testing the behavior of DSExtractPlaygroundCodeSnippetCommand
"
Class {
	#name : #DSExtractPlaygroundCodeSnippetCommandTest,
	#superclass : #DSToolCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSExtractPlaygroundCodeSnippetCommandTest >> classToTest [
	^ DSExtractPlaygroundCodeSnippetCommand
]

{ #category : #tests }
DSExtractPlaygroundCodeSnippetCommandTest >> testCodeSnippet [
	"Search for a specific playground."
	| script page playground command result |
	script := 'World submorphs'.
	page := GTPlayPage new saveContent: script; yourself.
	playground := GTPlayground new.
	playground entity: page.
	command := self classToTest new.
	command playground: playground.
	result := command execute; codeSnippet.
	self assert: result equals: 'World submorphs'.
	self assert: result isString.
]

{ #category : #tests }
DSExtractPlaygroundCodeSnippetCommandTest >> testMarkdown [
	"Search for a specific playground."
	| script page playground command result |
	script := 'World submorphs'.
	page := GTPlayPage new saveContent: script; yourself.
	playground := GTPlayground new.
	playground entity: page.
	command := self classToTest new.
	command playground: playground.
	result := command execute; markdown.
	self 
		assert: result 
		equals: (String cr join: #( '```Smalltalk' 'World submorphs' '```' )), String cr.
	self assert: result isString.
]
