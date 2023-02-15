Class {
	#name : #DSRegistryItemMorph,
	#superclass : #PanelMorph,
	#instVars : [
		'registry'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSRegistryItemMorph class >> learningHelpChannel [
	<gtExample>
	^ self new 
		registry: DSWebhookRegistry learningHelpChannel;
		extent: 300@100;
		yourself
]

{ #category : #examples }
DSRegistryItemMorph class >> learningHelpChannelInWindow [
	<example>
	^ self learningHelpChannel openInWindow
]

{ #category : #comparing }
DSRegistryItemMorph >> = anObject [
	^ self class = anObject class and: [ 
		self registry = anObject registry ]
]

{ #category : #initialization }
DSRegistryItemMorph >> initialize [
	super initialize.
	self 			
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent;
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8;
		cellPositioning: #leftCenter.
	self addMorphBack: self newIconMorph.
	self addMorphBack: self newNameMorph.
]

{ #category : #'instance creation' }
DSRegistryItemMorph >> newIconMorph [
	<return: #ImageMorph>
	^ (self iconNamed: #empty) asMorph
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		yourself
]

{ #category : #'instance creation' }
DSRegistryItemMorph >> newNameMorph [
	^ 'uninitialized account' asMorph
			hResizing: #spaceFill;
			vResizing: #shrinkWrap;
			yourself
]

{ #category : #accessing }
DSRegistryItemMorph >> registry [
	^ registry
]

{ #category : #accessing }
DSRegistryItemMorph >> registry: anObject [
	registry == anObject ifTrue: [ ^ self ].
	registry := anObject.
	self updateSubmorphs.
]

{ #category : #private }
DSRegistryItemMorph >> updateSubmorphs [
	self registry icon ifNotNil: [ :form | 
		self submorphs first form: form ].
	self registry name ifNotNil: [ :string | 
		self submorphs second contents: string ].
	
]
