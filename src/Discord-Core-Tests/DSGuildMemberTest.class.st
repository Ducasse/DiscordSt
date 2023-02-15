"
A DSGuildMemberTest is a test class for testing the behavior of DSGuildMember
"
Class {
	#name : #DSGuildMemberTest,
	#superclass : #DSObjectTest,
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #coverage }
DSGuildMemberTest >> classToTest [
	^ DSGuildMember
]

{ #category : #tests }
DSGuildMemberTest >> testNickOrUsername [
	object := self classToTest new.
	object user: DSUser alice.
	self 
		assert: object nickOrUsername 
		equals: 'Alice'.
]

{ #category : #tests }
DSGuildMemberTest >> testNickOrUsername2 [
	object := self classToTest new.
	object nick: 'My Nick'.
	object user: DSUser alice.
	self 
		assert: object nickOrUsername 
		equals: 'My Nick'.
]

{ #category : #tests }
DSGuildMemberTest >> testNickOrUsernameDefault [
	object := self classToTest new.
	self 
		assert: object nickOrUsername 
		equals: '<unknown>'.
]

{ #category : #tests }
DSGuildMemberTest >> testPrinString [
	object := self classToTest basic.
	self 
		assert: object printString isString
		description: 'Should return a String'.
	self 
		assert: (object printString includesSubstring: 'this users guild nickname')
		description: 'Should display nick'
]

{ #category : #tests }
DSGuildMemberTest >> testPrinStringDefault [
	self assert: self classToTest new printString isString.
]
