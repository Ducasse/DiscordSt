"
A DSSerializePackageWithTonelCommandTest is a test class for testing the behavior of DSSerializePackageWithTonelCommand
"
Class {
	#name : #DSSerializePackageWithTonelCommandTest,
	#superclass : #DSToolCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSSerializePackageWithTonelCommandTest >> classToTest [
	^ DSSerializePackageWithTonelCommand
]

{ #category : #tests }
DSSerializePackageWithTonelCommandTest >> testDirectory [
	| command result |
	command := self classToTest new.
	command package: self class package.
	result := command
		execute;
		directory.
	self assert: result notNil.
	self assert: result isDirectory.
	self assert: result directories size equals: 1.
	self
		assert:
			(result directoryNames
				anySatisfy: [ :directoryName | directoryName = self class package name ])
		description: [ 'Missing directory named ' , self class package name ]
]

{ #category : #tests }
DSSerializePackageWithTonelCommandTest >> testZipFile [
	| command result |
	command := self classToTest new.
	command package: self class package.
	result := command execute; zipFile.
	self assert: result notNil.
	self assert: result isFile.
	self assert: result extension equals: 'zip'.
	self deny: result size isZero.
	result ensureDelete.
]

{ #category : #accessing }
DSSerializePackageWithTonelCommandTest >> tmCharacter [
	"The method includes an UNICODE character 
	in onder to check that we are able to store such characters."
	^ $™
]
