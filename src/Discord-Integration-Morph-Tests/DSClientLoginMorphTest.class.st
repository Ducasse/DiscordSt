"
A DSClientLoginMorphTest is a test class for testing the behavior of DSClientLoginMorph
"
Class {
	#name : #DSClientLoginMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'window'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSClientLoginMorphTest >> classToTest [
	^ DSClientLoginMorph
]

{ #category : #running }
DSClientLoginMorphTest >> tearDown [
	window ifNotNil: #delete.
	super tearDown.
]

{ #category : #tests }
DSClientLoginMorphTest >> testEmail [
	morph := self classToTest filled.
	self assert: morph email equals: 'contact@example.com'.
	self assert: morph submorphs first getTextFromView equals: 'contact@example.com' asText.
	
]

{ #category : #tests }
DSClientLoginMorphTest >> testOnEmailUpdateDo [
	| resultEmail |
	morph := self classToTest empty.
	morph onEmailUpdateDo: [ :email | resultEmail := email ].
	window := morph openInWindow.
	morph email: 'contact@example.com'.
	self assert: resultEmail equals: 'contact@example.com'.
]

{ #category : #tests }
DSClientLoginMorphTest >> testOnLoginRequestDo [
	| resultEmail resultPassword |
	"Fix Travis-CI issue, where the Pharo window extent is 10@10
	and thus the simulateClick does not work (morph's window size is 410@83."
	DisplayScreen actualScreenSize < (400@400) ifTrue: [ 
		self skip: 'This does not work on ', DisplayScreen actualScreenSize asString, ' window size.' ].
	morph := self classToTest filled.
	morph onLoginRequestDo: [ :email :password | resultEmail := email. resultPassword := password ].
	window := morph openInWindow.
	morph submorphs third simulateClick.
	self assert: resultEmail equals: 'contact@example.com'.
	self assert: resultPassword equals: 'secret password'.
	
]

{ #category : #tests }
DSClientLoginMorphTest >> testOnPasswordUpdateDo [
	| resultEmail |
	morph := self classToTest empty.
	morph onPasswordUpdateDo: [ :email | resultEmail := email ].
	window := morph openInWindow.
	morph password: 'secret'.
	self assert: resultEmail equals: 'secret'.
]

{ #category : #tests }
DSClientLoginMorphTest >> testPassword [
	morph := self classToTest filled.
	self assert: morph password value equals: 'secret password'.
	self assert: morph submorphs second getTextFromView equals: 'secret password' asText.
	
]
