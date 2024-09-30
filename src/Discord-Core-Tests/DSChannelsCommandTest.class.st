"
A DSChannelsCommandTest is a test class for testing the behavior of DSChannelsCommand
"
Class {
	#name : 'DSChannelsCommandTest',
	#superclass : 'DSCommandTest',
	#category : 'Discord-Core-Tests-Commands',
	#package : 'Discord-Core-Tests',
	#tag : 'Commands'
}

{ #category : 'testing' }
DSChannelsCommandTest class >> isAbstract [
	^ self name = #DSChannelsCommandTest
]
