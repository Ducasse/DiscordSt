"
A DSDetectChannelCommandTest is a test class for testing the behavior of DSDetectChannelCommand
"
Class {
	#name : #DSDetectChannelCommandTest,
	#superclass : #DSChannelsCommandTest,
	#category : 'Discord-Core-Tests-Commands'
}

{ #category : #running }
DSDetectChannelCommandTest >> classToTest [
	^ DSDetectChannelCommand
]

{ #category : #tests }
DSDetectChannelCommandTest >> testChannel [
	command := self classToTest new.
	command satisfiedBy: [ :aChannel | aChannel name = 'ROCKET CHEESE' ].
	command channels: DSCategoryChannel withTwoChannels.
	command execute.
	self assert: command satisfyingChannel notNil.
	self assert: command satisfyingChannel name equals: 'ROCKET CHEESE'.
	
]

{ #category : #tests }
DSDetectChannelCommandTest >> testChannel2 [
	command := self classToTest new.
	command satisfiedBy: [ :aChannel | aChannel name = 'Test' ].
	command channels: DSCategoryChannel withTwoChannels.
	command execute.
	self assert: command satisfyingChannel notNil.
	self assert: command satisfyingChannel name equals: 'Test'.
	
]

{ #category : #tests }
DSDetectChannelCommandTest >> testChannel3 [
	command := self classToTest new.
	command satisfiedBy: [ :aChannel | aChannel name = 'general' ].
	command channels: DSCategoryChannel withTwoChannels.
	command execute.
	self assert: command satisfyingChannel notNil.
	self assert: command satisfyingChannel name equals: 'general'.
	
]

{ #category : #tests }
DSDetectChannelCommandTest >> testChannel5 [
	command := self classToTest new.
	command satisfiedBy: [ :aChannel | false ].
	command channels: DSCategoryChannel withTwoChannels.
	command execute.
	self assert: command satisfyingChannel isNil.	
]
