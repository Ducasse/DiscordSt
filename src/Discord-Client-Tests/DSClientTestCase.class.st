"
A DSClientTestCase is an abstract test class for testing the behavior of the Discord client.
"
Class {
	#name : 'DSClientTestCase',
	#superclass : 'DSCoreTestCase',
	#category : 'Discord-Client-Tests',
	#package : 'Discord-Client-Tests'
}

{ #category : 'testing' }
DSClientTestCase class >> isAbstract [
	^ self = DSClientTestCase
]

{ #category : 'running' }
DSClientTestCase >> classToTest [
	^ DSClient
]

{ #category : 'accessing' }
DSClientTestCase >> externalEmail [
	"Return Discord email login used for real testing.
	The value is secret, for that reason, we recomend you to set it in your environment.
	For example, if you use Travir-CI.org, you can set environments in settings."
	^ Smalltalk os environment at: 'DISCORD_ST_TEST_CASE_LOGIN_EMAIL' ifAbsent: nil.
]

{ #category : 'accessing' }
DSClientTestCase >> externalPassword [
	"Return Discord password login used for real testing.
	The value is secret, for that reason, we recomend you to set it in your environment.
	For example, if you use Travir-CI.org, you can set environments in settings."
	^ Smalltalk os environment at: 'DISCORD_ST_TEST_CASE_LOGIN_PASSWORD' ifAbsent: nil.
]

{ #category : 'instance creation' }
DSClientTestCase >> newClient [
	^ self classToTest new
]
