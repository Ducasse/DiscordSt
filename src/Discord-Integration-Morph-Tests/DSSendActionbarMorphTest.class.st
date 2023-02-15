"
A DSScreenshotSendbarMorphTest is a test class for testing the behavior of DSScreenshotSendbarMorph
"
Class {
	#name : #DSSendActionbarMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'window'
	],
	#category : 'Discord-Integration-Morph-Tests'
}

{ #category : #running }
DSSendActionbarMorphTest >> classToTest [
	^ DSSendActionbarMorph 
]

{ #category : #running }
DSSendActionbarMorphTest >> tearDown [
	super tearDown.
	window ifNotNil: #delete
]

{ #category : #tests }
DSSendActionbarMorphTest >> testCancel [
	| result |
	morph := self classToTest new.
	window := morph openInWindow.
	morph onCancelDo: [ :ann | result := ann ].
	morph cancel.
	self assert: result notNil.
	self assert: result equals: #cancelAction.
]

{ #category : #tests }
DSSendActionbarMorphTest >> testCancel2 [
	| result |
	morph := self classToTest new.
	window := morph openInWindow.
	morph onCancelSend: #value: to: [ :ann | result := ann ].
	morph cancel.
	self assert: result notNil.
	self assert: result equals: #cancelAction.
]

{ #category : #tests }
DSSendActionbarMorphTest >> testDefault [
	morph := self classToTest new.
	window := morph openInWindow.
	self assert: window isSystemWindow.
]

{ #category : #tests }
DSSendActionbarMorphTest >> testSend [
	| result |
	morph := self classToTest new.
	window := morph openInWindow.
	morph onSendDo: [ :ann | result := ann ].
	morph send.
	self assert: result notNil.
	self assert: result equals: #sendAction.
]

{ #category : #tests }
DSSendActionbarMorphTest >> testSend2 [
	| result |
	morph := self classToTest new.
	window := morph openInWindow.
	morph onSendSend: #value: to: [ :ann | result := ann ].
	morph send.
	self assert: result notNil.
	self assert: result equals: #sendAction.
]
