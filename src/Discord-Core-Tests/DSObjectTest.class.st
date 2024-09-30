"
A DSObjectTest is a test class for testing the behavior of DSObject
"
Class {
	#name : 'DSObjectTest',
	#superclass : 'DSCoreTestCase',
	#instVars : [
		'object'
	],
	#category : 'Discord-Core-Tests-Model',
	#package : 'Discord-Core-Tests',
	#tag : 'Model'
}

{ #category : 'testing' }
DSObjectTest class >> isAbstract [
	^ self = DSObjectTest 
]
