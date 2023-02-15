Class {
	#name : #DSSendUserTextMessageItemMorph,
	#superclass : #DSSendItemMorph,
	#instVars : [
		'textModel'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendUserTextMessageItemMorph class >> loremIpsum [
	<gtExample>
	<label: 'Basic example with Lorem Ipsum content.'>
	^ self basic 
		item: DSSendUserTextMessageItem loremIpsum;
		yourself
]

{ #category : #examples }
DSSendUserTextMessageItemMorph class >> loremIpsumInWindow [
	<example>
	^ self loremIpsum openInWindow
]

{ #category : #initialization }
DSSendUserTextMessageItemMorph >> initialize [
	super initialize.
	self initializeTextModel.
	self addMorphBack: self newTextMorph.
]

{ #category : #initialization }
DSSendUserTextMessageItemMorph >> initializeTextModel [
	textModel := RubScrolledTextModel new.
	textModel announcer
		when: RubTextUpdatedInModel
		do: [ :ann | item text: textModel getString ]
]

{ #category : #'announcement handling' }
DSSendUserTextMessageItemMorph >> itemChangedFrom: oldDSSendItem to: newDSSendItem [
	textModel setText: newDSSendItem text
]

{ #category : #'instance creation' }
DSSendUserTextMessageItemMorph >> newSendItem [
	^ DSSendUserTextMessageItem new
]

{ #category : #'instance creation' }
DSSendUserTextMessageItemMorph >> newTextMorph [
	| morph |
	morph := textModel newScrolledText
		beWrapped;
		beForPlainText;
		takeKeyboardFocus;
		minHeight: self theme listFont pixelSize * 3;
		hResizing: #spaceFill; 
		vResizing: #spaceFill;
		withGhostText: 'Write a question or comment...';
		withRulerNamed: #dstextlenght;
		autoAccept: true;
		yourself.
	^ morph
]

{ #category : #'private - accessing' }
DSSendUserTextMessageItemMorph >> textModel [
	^ textModel
]
