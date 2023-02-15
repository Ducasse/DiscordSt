Class {
	#name : #DSRubTextLenghtDisplayer,
	#superclass : #RubScrolledTextSideRuler,
	#instVars : [
		'lineAnnotation',
		'rowMorph'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #querying }
DSRubTextLenghtDisplayer class >> key [
	^ #dstextlenght
]

{ #category : #examples }
DSRubTextLenghtDisplayer class >> loremIpsum [
	<gtExample>
	<label: 'Indication of a maximum text lenght'>
	| textModel |
	textModel := RubScrolledTextModel new.
	textModel text: (String loremIpsum: (DSConstants maxMessageLenght + 1)).
	^ textModel newScrolledText 
			beWrapped;
			extent: 400@300;
			withRulerNamed: #dstextlenght;
			yourself.
]

{ #category : #examples }
DSRubTextLenghtDisplayer class >> loremIpsumOpenInWindow [
	<example>
	^ self loremIpsum openInWindow
]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> backgroundColor [
	^ self paragraphProvider backgroundColor darker
]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> computedHeightFrom: aRectangle [
	self exceedsMessageLenghtLimit ifFalse: [ ^ 0 ].
	^ rowMorph ifNil: [0] ifNotNil: [rowMorph height]
]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> exceedTextColor [
	^ Color red
]

{ #category : #testing }
DSRubTextLenghtDisplayer >> exceedsMessageLenghtLimit [
	^ self text size > DSConstants maxMessageLenght
]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> fontToUse [
	^ RubAbstractTextArea lineNumbersFont 
]

{ #category : #initialization }
DSRubTextLenghtDisplayer >> initialize [
	super initialize.
	self side: #bottom.
]

{ #category : #geometry }
DSRubTextLenghtDisplayer >> manageLayoutInBounds: aRectangle [
	| ret |
	ret := super manageLayoutInBounds: aRectangle.
	self updateContents.
	^ ret
]

{ #category : #geometry }
DSRubTextLenghtDisplayer >> noteNewOwner: aMorph [
	super noteNewOwner: aMorph.
	self color: self backgroundColor.
	lineAnnotation := RubTextFieldArea new.
	lineAnnotation withoutAnyDecorator.
	lineAnnotation backgroundColor: Color transparent.
	lineAnnotation font: self fontToUse.
	lineAnnotation beReadOnly.
	lineAnnotation textColor: self textColor.
	rowMorph := self theme
		newRowIn: self
		for:
			{(self spacer: 2).
			lineAnnotation }.
	rowMorph color: Color transparent.
	rowMorph hResizing: #spaceFill.
	lineAnnotation hResizing: #spaceFill.
	self addMorph: rowMorph
]

{ #category : #'event handling' }
DSRubTextLenghtDisplayer >> selectionChanged [
	self exceedsMessageLenghtLimit ifTrue: [ self updateContents ].
	super selectionChanged
]

{ #category : #'submorphs-accessing' }
DSRubTextLenghtDisplayer >> spacer: anInteger [
	^ Morph new
		borderWidth: 0;
		color: Color transparent;
		extent: anInteger@3
]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> textColor [
	^ self textArea lineNumbersTextColor muchDarker

]

{ #category : #accessing }
DSRubTextLenghtDisplayer >> textLenghtInfo [
	^ Text streamContents: [ :aStream |
			aStream
				withAttribute:
					(TextColor new
						color: self exceedTextColor;
						yourself)
				do: [ aStream
						nextPutAll: 'Text too long: ';
						print: self text size;
						nextPutAll: ' characters (max. ';
						print: DSConstants maxMessageLenght;
						nextPutAll: '), cursor at ';
						print: self textArea pointIndex ] ]
]

{ #category : #'event handling' }
DSRubTextLenghtDisplayer >> updateContents [
	rowMorph ifNil: [ ^ self ].
	self textArea selectionStart ifNil: [ ^self ].
	self lines ifNil: [ ^self ].
	lineAnnotation
		beEditableWhile: [ lineAnnotation setTextWith: self textLenghtInfo.
			self layoutChanged ].
	rowMorph position: self innerBounds topLeft.
	rowMorph width: self innerBounds width
]
