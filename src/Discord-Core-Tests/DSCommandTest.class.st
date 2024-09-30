"
A DSCoreCommandTest is a test class for testing the behavior of DSCoreCommand
"
Class {
	#name : 'DSCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'command'
	],
	#category : 'Discord-Core-Tests-Commands',
	#package : 'Discord-Core-Tests',
	#tag : 'Commands'
}

{ #category : 'testing' }
DSCommandTest class >> isAbstract [
	^ self name = #DSCommandTest 
]

{ #category : 'running' }
DSCommandTest >> classToTest [
	^ self subclassResponsibility 
]

{ #category : 'tests' }
DSCommandTest >> testAsync [
	command := self classToTest new async.
	self assert: command class equals: DSAsyncCommand.
	self assert: command command class equals: self classToTest.
	
]
