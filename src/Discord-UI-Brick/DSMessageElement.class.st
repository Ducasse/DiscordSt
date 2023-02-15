Class {
	#name : #DSMessageElement,
	#superclass : #DSBlocElement,
	#instVars : [
		'message',
		'containerElement'
	],
	#category : 'Discord-UI-Brick'
}

{ #category : #examples }
DSMessageElement class >> content [
	<gtExample>
	^ self new 
		message: DSMessage content;
		yourself
]

{ #category : #examples }
DSMessageElement class >> embedAll [
	<gtExample>
	^ self new 
		message: DSMessage embedAll;
		yourself
]

{ #category : #examples }
DSMessageElement class >> embedDescription [
	<gtExample>
	^ self new 
		message: DSMessage embedDescription;
		yourself
]

{ #category : #examples }
DSMessageElement class >> embedScreenshot [
	<gtExample>
	^ self new 
		message: DSMessage embedScreenshot;
		yourself
]

{ #category : #examples }
DSMessageElement class >> empty [
	<gtExample>
	^ self new 
		message: DSMessage empty;
		yourself
]

{ #category : #initialization }
DSMessageElement >> initialize [
	super initialize.
	self layout: BlLinearLayout horizontal.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self border: (BlBorder paint: Color veryLightGray width: 1).

]

{ #category : #accessing }
DSMessageElement >> message [
	^ message
]

{ #category : #accessing }
DSMessageElement >> message: anObject [
	message := anObject.
	self updateChildren.
]

{ #category : #'instance creation' }
DSMessageElement >> newAuthorLogoElement [
	| logoBackground iconExtent |
	iconExtent := DSIcons discord extent.
	logoBackground := BlBackground builder
		image: DSIcons discord;
		build.
	^ BlElement new
		size: iconExtent;
		geometry: (BlEllipse extent: iconExtent);
		background: logoBackground;
		yourself.
]

{ #category : #'instance creation' }
DSMessageElement >> newAuthorNameElement [
	| authorText authorElement |
	authorText := self message authorName asRopedText.
	authorText fontSize: 16; oblique.
	authorElement := BlTextElement new.
	authorElement text: authorText.
	authorElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c padding: (BlInsets right: 5) ].
	^ authorElement.
]

{ #category : #'instance creation' }
DSMessageElement >> newContentElement [
	^ self newEditorElementForString: self message content asString.
]

{ #category : #'instance creation' }
DSMessageElement >> newMessageContainterElement [
	| element |
	element := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent ];
			addChild: self newMessageHeadingElement;
			yourself.
	self message content isEmptyOrNil ifFalse: [ 
		element addChild: self newContentElement ].
	self message embeds do: [ :eachEmbed | 
		element addChild: (DSEmbedElement new embed: eachEmbed; yourself) ].
	^ element
]

{ #category : #'instance creation' }
DSMessageElement >> newMessageHeadingElement [
	"It includes author name, bot indicator, timestamp."
	| element |
	element := BlElement new
			layout: (BlLinearLayout horizontal alignBottomLeft; yourself);
			constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent.
				c padding: (BlInsets all: 2) ];
			margin: (BlInsets all: 2);
			addChild: self newAuthorNameElement;
			yourself.
	self message timestamp isNil ifFalse: [
		element addChild: self newTimestampElement ].
	^ element
]

{ #category : #'instance creation' }
DSMessageElement >> newTimestampElement [
	| dateText timestampElement dateAndTime dateString |
	dateAndTime := self message timestamp asDateAndTime.
	dateString := dateAndTime asDate = Date today
		ifTrue: [ dateAndTime asTime print24 ]
		ifFalse: [ dateAndTime asDate yyyymmdd ].
	dateText := dateString asRopedText.
	dateText foreground: Color gray.
	timestampElement := BlTextElement new.
	timestampElement text: dateText.
	timestampElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent.
			c padding: (BlInsets left: 5 right: 5) ].
	^ timestampElement
]

{ #category : #updating }
DSMessageElement >> updateChildren [
	self removeChildren.
	self addChild: self newAuthorLogoElement.
	self addChild: self newMessageContainterElement.
]
