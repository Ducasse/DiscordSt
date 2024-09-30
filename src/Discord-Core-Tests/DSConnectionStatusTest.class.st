"
A DSConnectionStatusTest is a test class for testing the behavior of DSConnectionStatus
"
Class {
	#name : 'DSConnectionStatusTest',
	#superclass : 'TestCase',
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'running' }
DSConnectionStatusTest >> classToTest [
	^ DSConnectionStatus
]

{ #category : 'tests' }
DSConnectionStatusTest >> testNewFromString [
	self classToTest allStatuses do: [ :eachClass | | status |
		status := self classToTest newFromString: eachClass statusString.
		self assert: status class equals: eachClass.
		self assert: status statusString equals: eachClass statusString ].
]
