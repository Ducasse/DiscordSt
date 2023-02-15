"
A DSClassesInCodeSnippetCommandTest is a test class for testing the behavior of DSClassesInCodeSnippetCommand
"
Class {
	#name : #DSClassesInCodeSnippetCommandTest,
	#superclass : #DSToolCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSClassesInCodeSnippetCommandTest >> classToTest [
	^ DSClassesInCodeSnippetCommand
]

{ #category : #tests }
DSClassesInCodeSnippetCommandTest >> testClasses [
	"Search for used classes."
	| script command result |
	script := '| morphs command |', String cr, 'morphs := World submorphs.', String cr, 'command := DSFindInspectorCommand new model: Object new.'.
	command := self classToTest new.
	command codeSnippet: script.
	result := command execute; classes.
	self assert: result notNil.
	self assert: result size equals: 2.
	self assert: result equals: { DSFindInspectorCommand. Object }.
]
