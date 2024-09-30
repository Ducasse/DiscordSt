"
A DSAsyncCommandTest is a test class for testing the behavior of DSAsyncCommand
"
Class {
	#name : 'DSAsyncCommandTest',
	#superclass : 'DSCommandTest',
	#category : 'Discord-Core-Tests-Commands',
	#package : 'Discord-Core-Tests',
	#tag : 'Commands'
}

{ #category : 'running' }
DSAsyncCommandTest >> classToTest [
	^ DSAsyncCommand
]

{ #category : 'tests' }
DSAsyncCommandTest >> testAsync [
	command := self classToTest new async.
	self assert: command == command.
]

{ #category : 'tests' }
DSAsyncCommandTest >> testCommandDefault [
	command := self classToTest new.
	self assert: command command notNil.
]

{ #category : 'tests' }
DSAsyncCommandTest >> testExecute [

	| result semaphore timeout |
	semaphore := Semaphore new.
	command := self classToTest new.
	command onSuccess: [ :aCommand |
		result := aCommand.
		semaphore signal ].
	command execute.
	timeout := semaphore waitTimeoutMilliseconds: 300.
	self
		deny: timeout
		description: 'The semaphore was not signaled in time'.
	self assert: result equals: command command
]

{ #category : 'tests' }
DSAsyncCommandTest >> testOnSuccessDefault [
	command := self classToTest new.
	self assert: command onSuccess notNil.
]
