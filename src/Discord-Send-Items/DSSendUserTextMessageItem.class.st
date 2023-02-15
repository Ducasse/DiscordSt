Class {
	#name : #DSSendUserTextMessageItem,
	#superclass : #DSSendItem,
	#instVars : [
		'text'
	],
	#category : 'Discord-Send-Items'
}

{ #category : #examples }
DSSendUserTextMessageItem class >> loremIpsum [
	<gtExample>
	<label: 'Basic example with Lorem Ipsum content.'>
	^ self new 
		text: (String loremIpsum: 200);
		yourself
]

{ #category : #visiting }
DSSendUserTextMessageItem >> accept: aVisitor [
	^ aVisitor visitDSSendUserTextMessageItem: self
]

{ #category : #accessing }
DSSendUserTextMessageItem >> children [
	^ #()
]

{ #category : #'gt-inspector-extension' }
DSSendUserTextMessageItem >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite text
		title: [ 'Text' translated ];
		display: [ self text ];
		withGhostText: 'Empty text message...';
		yourself
]

{ #category : #initialization }
DSSendUserTextMessageItem >> initialize [
	super initialize.
	text := ''.
]

{ #category : #testing }
DSSendUserTextMessageItem >> isUserTextMessageItem [
	^ true
]

{ #category : #enumerating }
DSSendUserTextMessageItem >> onContentChangedDo: oneArgBlock [
	"Register for content changes. The block receives the announcement."

	^ self announcer when: DSContentChangedAnnouncement do: oneArgBlock
]

{ #category : #accessing }
DSSendUserTextMessageItem >> text [
	^ text
]

{ #category : #accessing }
DSSendUserTextMessageItem >> text: aStringOrText [
	text = aStringOrText ifTrue: [ ^ self ].
	text := aStringOrText.
	self announcer announce: (DSContentChangedAnnouncement new
		object: self;
		state: aStringOrText;
		yourself)
]
