"
A DSSerializePackagesWithTonelCommandTest is a test class for testing the behavior of DSSerializePackagesWithTonelCommand
"
Class {
	#name : #DSSerializePackagesWithTonelCommandTest,
	#superclass : #DSToolCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSSerializePackagesWithTonelCommandTest >> classToTest [
	^ DSSerializePackagesWithTonelCommand
]

{ #category : #tests }
DSSerializePackagesWithTonelCommandTest >> testDirectory [
	| command result |
	command := self classToTest new.
	command packages: { self class package. self classToTest package }.
	result := command execute; directory.
	self assert: result notNil.
	self assert: result isDirectory.
	self assert: result directories size equals: 2.
	self assert: (result directories anySatisfy: [ :directory | directory basename = self class package name ]).
	self assert: (result directories anySatisfy: [ :directory | directory basename = self classToTest package name ]).
]

{ #category : #tests }
DSSerializePackagesWithTonelCommandTest >> testZipFile [
	| command result |
	command := self classToTest new.
	command packages: { self class package. self classToTest package }.
	result := command execute; zipFile.
	self assert: result notNil.
	self assert: result isFile.
	self assert: result extension equals: 'zip'.
	self deny: result size isZero.
	result ensureDelete.
]
