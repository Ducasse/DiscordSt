"
A DSToolCommandTest is a test class for testing the behavior of DSToolCommand
"
Class {
	#name : #DSToolCommandTest,
	#superclass : #TestCase,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #testing }
DSToolCommandTest class >> isAbstract [
	^ self name = #DSToolCommandTest 
]

{ #category : #running }
DSToolCommandTest >> classToTest [
	^ self subclassResponsibility
]
