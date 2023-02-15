"
I am a command that search for  a channel in a channel hierarchy (channels in categories) that satisfy a condition.

Public API and Key Messages

- channels 			set searched channels
- satisfiedBy			set an one argument block that retuns a true or false
- execute			perform the search algorithm
- satisfyingChannel	get nil or a channel that satisfies the condition

Internal Representation and Key Implementation Points.

    Instance Variables
	channels:			<Array>
	satisfiedBy:			<BlockClosure>
	satisfyingChannel:	<DSChannel>

"
Class {
	#name : #DSDetectChannelCommand,
	#superclass : #DSChannelsCommand,
	#instVars : [
		'satisfiedBy',
		'satisfyingChannel'
	],
	#category : 'Discord-Core-Commands'
}

{ #category : #examples }
DSDetectChannelCommand class >> searchForName [
	<gtExample>
	^ self new
		channels: DSCategoryChannel withTwoChannels;
		satisfiedBy: [ :aChannel | aChannel name = 'ROCKET CHEESE' ];
		execute;
		satisfyingChannel
]

{ #category : #execute }
DSDetectChannelCommand >> execute [
	self channels do: [ :eachChannel |
		self satisfyingChannel: (eachChannel detectChannel: self satisfiedBy).
		self satisfyingChannel ifNotNil: [ ^ self ] ].
]

{ #category : #accessing }
DSDetectChannelCommand >> satisfiedBy [
	^ satisfiedBy
]

{ #category : #accessing }
DSDetectChannelCommand >> satisfiedBy: oneArgBlock [
	"Set an one-argument block that return true if a channel, given as the argument, is the wanted.
	The block returns false otherwise."
	satisfiedBy := oneArgBlock
]

{ #category : #accessing }
DSDetectChannelCommand >> satisfyingChannel [
	^ satisfyingChannel
]

{ #category : #accessing }
DSDetectChannelCommand >> satisfyingChannel: anObject [
	satisfyingChannel := anObject
]
