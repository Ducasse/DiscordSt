Class {
	#name : #DSShareTextCommand,
	#superclass : #DSShareCommand,
	#instVars : [
		'wholeText',
		'selectedTextInterval',
		'selectedText',
		'morph'
	],
	#category : 'Discord-Integration-Rubric'
}

{ #category : #execute }
DSShareTextCommand >> execute [
	| items text |
	items := DSSendItems new.	
	text := self userMessage.
	items userTextMessageItem text: text.
	self addMorphScreenshot: morph to: items.
	items informationItem addPharoAndOsVersion.
	DSSendDialogMorph new
		items: items;
		extent: 400@500;
		openInWindow
]

{ #category : #accessing }
DSShareTextCommand >> morph [
	^ morph
]

{ #category : #accessing }
DSShareTextCommand >> morph: anObject [
	morph := anObject
]

{ #category : #accessing }
DSShareTextCommand >> selectedText [
	^ selectedText
]

{ #category : #accessing }
DSShareTextCommand >> selectedText: anObject [
	selectedText := anObject
]

{ #category : #accessing }
DSShareTextCommand >> selectedTextInterval [
	^ selectedTextInterval
]

{ #category : #accessing }
DSShareTextCommand >> selectedTextInterval: anObject [
	selectedTextInterval := anObject
]

{ #category : #accessing }
DSShareTextCommand >> userMessage [
	^ DSUtility markdownOf: (selectedText ifEmpty: [ wholeText ])
]

{ #category : #accessing }
DSShareTextCommand >> wholeText [
	^ wholeText
]

{ #category : #accessing }
DSShareTextCommand >> wholeText: anObject [
	wholeText := anObject
]
