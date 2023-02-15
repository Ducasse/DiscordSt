"
A DSSortClassesPerPackageCommandTest is a test class for testing the behavior of DSSortClassesPerPackageCommand
"
Class {
	#name : #DSSortClassesPerPackageCommandTest,
	#superclass : #DSToolCommandTest,
	#category : 'Discord-Tools-Tests-Commands'
}

{ #category : #running }
DSSortClassesPerPackageCommandTest >> classToTest [
	^ DSSortClassesPerPackageCommand
]

{ #category : #tests }
DSSortClassesPerPackageCommandTest >> testPackages [
	| command result |
	command := self classToTest new.
	command classes: { DSExtractPlaygroundCodeSnippetCommandTest }.
	result := command execute; packages.
	self assert: result notNil.
	self assert: result size equals: 1.
	self assert: result first item equals: DSExtractPlaygroundCodeSnippetCommandTest package.
	self deny: result first isSelected.
	self assert: result first classes size equals: 1.
	self assert: result first classes first item equals: DSExtractPlaygroundCodeSnippetCommandTest.
	self assert: result first classes first isSelected.
]

{ #category : #tests }
DSSortClassesPerPackageCommandTest >> testPackages2 [
	| command result |
	command := self classToTest new.
	command classes: { self class. DSExtractPlaygroundCodeSnippetCommandTest }.
	result := command execute; packages.
	self assert: result notNil.
	self assert: result size equals: 1.
	self assert: result first item equals: DSExtractPlaygroundCodeSnippetCommandTest package.
	self deny: result first isSelected.
	self assert: result first classes size equals: 2.
	self assert: result first classes first item equals: DSExtractPlaygroundCodeSnippetCommandTest.
	self assert: result first classes first isSelected.
	self assert: result first classes second item equals: self class.
	self assert: result first classes second isSelected.
]
