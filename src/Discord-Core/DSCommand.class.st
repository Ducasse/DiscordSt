Class {
	#name : 'DSCommand',
	#superclass : 'Object',
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
DSCommand >> async [
	^ DSAsyncCommand new
		command: self;
		yourself
]

{ #category : 'execute' }
DSCommand >> execute [
	^ self subclassResponsibility
]

{ #category : 'execute' }
DSCommand >> executeAsync [
	^ self async execute
]
