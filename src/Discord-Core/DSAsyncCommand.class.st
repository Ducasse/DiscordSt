"
I execute a command in a forked process. 
I do not catch any errors.
I do trigger onSuccess when the forked process is finished.

Public API and Key Messages

- command:		a command (that understand #execute) to be executed in a forked process
- onSuccess:		a block to be executed when the command finish successfully

Internal Representation and Key Implementation Points.

    Instance Variables
	command:		<DSCoreCommand>
	onSuccess:		<BlockClosure>

"
Class {
	#name : 'DSAsyncCommand',
	#superclass : 'DSCommand',
	#instVars : [
		'command',
		'onSuccess'
	],
	#category : 'Discord-Core-Commands',
	#package : 'Discord-Core',
	#tag : 'Commands'
}

{ #category : 'converting' }
DSAsyncCommand >> async [
	^ self
]

{ #category : 'accessing' }
DSAsyncCommand >> command [
	^ command
]

{ #category : 'accessing' }
DSAsyncCommand >> command: anObject [
	command := anObject
]

{ #category : 'accessing' }
DSAsyncCommand >> defaultProcessName [
	"Return the process name used for the forked execution.
	See #execute method."
	^ String streamContents: [ :aStream |
		aStream << self className << ' on ' << self command className << ' (a Discord command)' ].
]

{ #category : 'accessing' }
DSAsyncCommand >> defaultProcessPriority [
	"Return the process priority number used for the forked execution.
	See #execute method."
	^ Processor userBackgroundPriority 
]

{ #category : 'execute' }
DSAsyncCommand >> execute [
	"Execute the command in a forked process.
	It is recommended to use this method from UIs (buttons)."
	self assert: [ self command notNil ] description: 'Command has to be initialized before execution.'.

	[ self executeCommand ]
		forkAt: self defaultProcessPriority
		named: self defaultProcessName.
]

{ #category : 'private' }
DSAsyncCommand >> executeCommand [
	[ 
		self command execute.
		self onSuccess cull: self command.
	] on: Error do: [ "ignore" ]
]

{ #category : 'initialization' }
DSAsyncCommand >> image: aDSEmbed [ 
	self command: (DSGetImageCommand new image: aDSEmbed; yourself)
]

{ #category : 'initialization' }
DSAsyncCommand >> initialize [
	super initialize.
	command := DSNoCommand uniqueInstance.
	onSuccess := [ "do nothing" ].
]

{ #category : 'accessing' }
DSAsyncCommand >> onSuccess [
	^ onSuccess
]

{ #category : 'accessing' }
DSAsyncCommand >> onSuccess: aBlockClosure [ 
	"Set an action that is executed after a successful command execution."
	onSuccess := aBlockClosure 
]
