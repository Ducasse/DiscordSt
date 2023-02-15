Class {
	#name : #DSEmbedElement,
	#superclass : #DSBlocElement,
	#instVars : [
		'embed'
	],
	#category : 'Discord-UI-Brick'
}

{ #category : #examples }
DSEmbedElement class >> description [
	<gtExample>
	^ self new 
		embed: DSEmbed description;
		yourself
]

{ #category : #examples }
DSEmbedElement class >> screenshot [
	<gtExample>
	^ self new 
		embed: DSEmbed screenshot;
		yourself
]

{ #category : #accessing }
DSEmbedElement >> embed [
	^ embed
]

{ #category : #accessing }
DSEmbedElement >> embed: anObject [
	embed := anObject.
	self updateChildren.
]

{ #category : #initialization }
DSEmbedElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
]

{ #category : #'instance creation' }
DSEmbedElement >> newDescriptionElement [
	^ self newEditorElementForString: self embed description asString.
]

{ #category : #'instance creation' }
DSEmbedElement >> newImageElement [
	| imageElement |
	"imageForm := self embed image asForm."
	imageElement := BlElement new
		size: self embed image extent;
		geometry: (BlRectangle extent: self embed image extent);
		margin: (BlInsets all: 5);
		yourself.
	self embed image hasData 
		ifTrue: [ self setImageBackground: imageElement ]
		ifFalse: [ self setTemporalBackground: imageElement ].
	^ imageElement
]

{ #category : #private }
DSEmbedElement >> setImageBackground: imageElement [
	| imageBackground |
	imageBackground := BlBackground builder
		image: self embed image asForm;
		build.
	imageElement background: imageBackground

]

{ #category : #private }
DSEmbedElement >> setTemporalBackground: imageElement [
	| imageBackground |
	imageBackground := BlBackground builder
		paint: (Color gray alpha: 0.5);
		build.
	imageElement background: imageBackground.
	DSAsyncCommand new
		image: self embed image;
		onSuccess: [ 
			imageBackground := BlBackground builder
				image: self embed image asForm;
				build.
			imageElement background: imageBackground ];
		execute.

]

{ #category : #updating }
DSEmbedElement >> updateChildren [
	self removeChildren.
	self embed hasDescription ifTrue: [ self addChild: self newDescriptionElement ].
	self embed hasImage ifTrue: [ self addChild: self newImageElement ].
]
