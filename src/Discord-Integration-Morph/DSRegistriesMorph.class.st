Class {
	#name : #DSRegistriesMorph,
	#superclass : #PanelMorph,
	#instVars : [
		'registries'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSRegistriesMorph class >> empty [
	<gtExample>
	^ self new
		extent: 300@100;
		yourself
]

{ #category : #examples }
DSRegistriesMorph class >> emptyInWindow [
	<example>
	^ self empty openInWindow
]

{ #category : #examples }
DSRegistriesMorph class >> twoWebhooks [
	<gtExample>
	^ self empty
		registries: DSRegistries twoWebhooks;
		yourself
]

{ #category : #examples }
DSRegistriesMorph class >> twoWebhooksAndOneClient [
	<gtExample>
	^ self empty
		registries: DSRegistries twoWebhooksAndOneClient;
		yourself
]

{ #category : #examples }
DSRegistriesMorph class >> twoWebhooksAndOneClientInWindow [
	<example>
	^ self twoWebhooksAndOneClient openInWindow
]

{ #category : #examples }
DSRegistriesMorph class >> twoWebhooksInWindow [
	<example>
	^ self twoWebhooks openInWindow
]

{ #category : #initialization }
DSRegistriesMorph >> initialize [
	super initialize.
	registries := DSNoRegistries uniqueInstance.
	self 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent;
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: 8;
		cellPositioning: #leftCenter.
	self addMorphBack: self newDropListMorph.
]

{ #category : #enumerating }
DSRegistriesMorph >> morphItems [
	^ self registries collect: [ :eachRegistry | 
		DSRegistryItemMorph new
		registry: eachRegistry;
		yourself. ]
]

{ #category : #'instance creation' }
DSRegistriesMorph >> newDropListMorph [
	^ (MorphDropListMorph
			on: self
			list: #morphItems
			selected: #selection
			changeSelected: #selection:
			useIndex: false)
				hResizing: #spaceFill;
				vResizing: #shrinkWrap;
				yourself.
]

{ #category : #accessing }
DSRegistriesMorph >> registries [
	^ registries
]

{ #category : #accessing }
DSRegistriesMorph >> registries: anObject [
	registries := anObject.
	self changed: #morphItems.
	self changed: #selection.
]

{ #category : #accessing }
DSRegistriesMorph >> selection [
	<return: #DSRegistry or: nil>
	^ self registries selection
			ifNotNil: [ :aRegistry | DSRegistryItemMorph new 
				registry: aRegistry;
				yourself ]
]

{ #category : #accessing }
DSRegistriesMorph >> selection: aMorph [
	self registries selection: aMorph registry
]
