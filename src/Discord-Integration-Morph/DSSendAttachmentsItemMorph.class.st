Class {
	#name : #DSSendAttachmentsItemMorph,
	#superclass : #DSSendItemMorph,
	#instVars : [
		'table'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #examples }
DSSendAttachmentsItemMorph class >> screenshotsAndPackages [
	<gtExample>
	<label: 'With screenshots and packages'>
	^ self basic 
		item: DSSendAttachmentsItem screenshotsAndPackages;
		yourself
]

{ #category : #examples }
DSSendAttachmentsItemMorph class >> screenshotsAndPackagesInWindow [
	<example>
	^ self screenshotsAndPackages openInWindow
]

{ #category : #'tests-examples' }
DSSendAttachmentsItemMorph class >> testScreenshotsAndPackagesInWindow [
	self shouldBeImplemented
]

{ #category : #examples }
DSSendAttachmentsItemMorph class >> twoRandomMorphs [
	<gtExample>
	<label: 'With a two random morpht attachments'>
	^ self basic 
		item: DSSendAttachmentsItem twoRandomMorphs;
		yourself
]

{ #category : #examples }
DSSendAttachmentsItemMorph class >> twoRandomMorphsInWindow [
	<example>
	^ self twoRandomMorphs openInWindow
]

{ #category : #examples }
DSSendAttachmentsItemMorph class >> withTwoPackages [
	<gtExample>
	<label: 'Collection with selected packages of Object and Collection classes'>
	^ self basic 
		item: DSSendAttachmentsItem twoPackages;
		yourself
]

{ #category : #examples }
DSSendAttachmentsItemMorph class >> withTwoPackagesInWindow [
	<example>
	^ self withTwoPackages openInWindow
]

{ #category : #initialization }
DSSendAttachmentsItemMorph >> initialize [
	super initialize.
	table := self newTable.
	self addMorphBack: table.
]

{ #category : #'announcement handling' }
DSSendAttachmentsItemMorph >> itemChangedFrom: oldDSSendItem to: newDSSendItem [
	table dataSource items: (Array with: newDSSendItem)
]

{ #category : #'instance creation' }
DSSendAttachmentsItemMorph >> newDataSource [
	^ (DSDataSource
		roots: self newDataSourceRoots
		children: [ :eachChild | eachChild children ])
			maxDepth: 1;
			yourself
]

{ #category : #'instance creation' }
DSSendAttachmentsItemMorph >> newDataSourceRoots [
	^ Array with: self item
]

{ #category : #'instance creation' }
DSSendAttachmentsItemMorph >> newSendItem [
	<return: #DSSendItem>
	^ DSSendAttachmentsItem new
]

{ #category : #'instance creation' }
DSSendAttachmentsItemMorph >> newTable [
	^ FTTableMorph new
		allowsDeselection: true;
		beMultipleSelection;
		beResizable;
		dragEnabled: true;
		dropEnabled: true;
		addColumn: self newTableColumn;
		dataSource: self newDataSource;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]

{ #category : #'instance creation' }
DSSendAttachmentsItemMorph >> newTableColumn [
	^ DSTableColumn new
]
