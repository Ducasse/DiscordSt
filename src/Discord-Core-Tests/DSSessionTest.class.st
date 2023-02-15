"
A DSSessionTest is a test class for testing the behavior of DSSession
"
Class {
	#name : #DSSessionTest,
	#superclass : #DSCoreTestCase,
	#instVars : [
		'session'
	],
	#category : 'Discord-Core-Tests-Model'
}

{ #category : #'instance creation' }
DSSessionTest >> newObjectToTest [
	^ self newSession 
]

{ #category : #tests }
DSSessionTest >> testEmail [
	session := self newSession.
	session email: self emailString.
	self assert: session email equals: self emailString.

]

{ #category : #tests }
DSSessionTest >> testEmailPassword [
	session := self newSession.
	session email: self emailString password: self passwordString.
	self assert: session email equals: self emailString.
	self assert: session password equals: self passwordString.
]

{ #category : #tests }
DSSessionTest >> testIsAuthenticated [
	session := self newSession.
	self deny: session isAuthenticated.
]

{ #category : #tests }
DSSessionTest >> testPassword [
	session := self newSession.
	session password: self passwordString.
	self assert: session password equals: self passwordString.
]

{ #category : #tests }
DSSessionTest >> testPrintString [
	session := self newSession.
	self assert: session printString equals: 'Session: unauthenticated'.

]

{ #category : #tests }
DSSessionTest >> testPrintString2 [
	session := self newSession.
	session token: self tokenString.
	self assert: session printString equals: 'Session: authenticated'.

]

{ #category : #tests }
DSSessionTest >> testPrintString3 [
	session := self newSession.
	session email: self emailString.
	session token: self tokenString.
	self assert: session printString equals: 'Session: authenticated as ', self emailString.

]

{ #category : #tests }
DSSessionTest >> testPrintString4 [
	session := self newSession.
	session email: self emailString.
	self assert: session printString equals: 'Session: unauthenticated user ', self emailString.

]

{ #category : #tests }
DSSessionTest >> testResetToken [
	session := self newSession.
	session token: self tokenString.
	session resetToken.
	self assert: session token isEmpty.
]

{ #category : #tests }
DSSessionTest >> testToken [
	session := self newSession.
	session token: self tokenString.
	self assert: session token equals: self tokenString.

]
