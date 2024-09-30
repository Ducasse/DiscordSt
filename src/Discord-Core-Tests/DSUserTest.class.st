"
A DSUserTest is a test class for testing the behavior of DSUser
"
Class {
	#name : 'DSUserTest',
	#superclass : 'DSObjectTest',
	#instVars : [
		'user'
	],
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'instance creation' }
DSUserTest >> newObjectToTest [
	^ self newUser 
]

{ #category : 'tests-converting' }
DSUserTest >> testAsAuthor [
	| author |
	user := self coreModelJsonMapping read: DSUser withMapping: #userMappingFor: on: self coreModelJsonMapping jsonUser readStream.
	user restApi: self newRestApi.
	self assert: user email equals: 'nelly@discordapp.com'.
	author := user asAuthor.
	self deny: author == user.
	self assert: author id equals: user id.
	self assert: author name equals: user name.
	self assert: author discriminator equals: user discriminator.
	self assert: author avatarHash equals: user avatarHash.
	self assert: author isMfaEnabled isNil.
	self assert: author email isNil.
	self deny: author isVerified.
]

{ #category : 'tests' }
DSUserTest >> testAvatarHash [
	user := self newUser.
	user avatarHash: self anyString.
	self assert: user avatarHash equals: self anyString.
]

{ #category : 'tests' }
DSUserTest >> testAvatarUrl [
	user := self newUser.
	user id: 'user-id'.
	user avatarHash: 'avatar-id'.
	user restApi: DSRestApi defaultClass new.
	self 
		assert: user avatarUrl asString
		equals: 'https://cdn.discordapp.com/avatars/user-id/avatar-id.webp?size=1024'
]

{ #category : 'tests' }
DSUserTest >> testDiscriminator [
	user := self newUser.
	user discriminator: self anyString.
	self assert: user discriminator equals: self anyString.
]

{ #category : 'tests' }
DSUserTest >> testEmail [
	user := self newUser.
	user email: self anyString.
	self assert: user email equals: self anyString.
]

{ #category : 'tests' }
DSUserTest >> testId [
	user := self newUser.
	user id: self anyString.
	self assert: user id equals: self anyString.
]

{ #category : 'tests' }
DSUserTest >> testIsBot [
	user := self newUser.
	user isBot: true.
	self assert: user isBot
]

{ #category : 'tests' }
DSUserTest >> testIsBot2 [
	user := self newUser.
	user isBot: false.
	self deny: user isBot
]

{ #category : 'tests' }
DSUserTest >> testIsMfaEnabled [
	user := self newUser.
	user isMfaEnabled: true.
	self assert: user isMfaEnabled.

]

{ #category : 'tests' }
DSUserTest >> testIsMfaEnabled2 [
	user := self newUser.
	user isMfaEnabled: false.
	self deny: user isMfaEnabled.

]

{ #category : 'tests' }
DSUserTest >> testIsVerified [
	user := self newUser.
	user isVerified: true.
	self assert: user isVerified.

]

{ #category : 'tests' }
DSUserTest >> testIsVerified2 [
	user := self newUser.
	user isVerified: false.
	self deny: user isVerified.

]

{ #category : 'tests' }
DSUserTest >> testPrintString [
	user := self newUser.
	self assert: user printString isString.

]

{ #category : 'tests' }
DSUserTest >> testUsername [
	user := self newUser.
	user username: self anyString.
	self assert: user username equals: self anyString.
]
