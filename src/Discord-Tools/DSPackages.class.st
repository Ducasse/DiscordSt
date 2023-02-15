Class {
	#name : #DSPackages,
	#superclass : #OrderedCollection,
	#category : 'Discord-Tools-Support'
}

{ #category : #'instance creation' }
DSPackages class >> fromClasses: aCollectionOfClasses [ 
	"Return instance of me with given classes and their packages."
	<return: #DSPackages>
	^ (DSSortClassesPerPackageCommand new classes: aCollectionOfClasses; execute; packages)
]

{ #category : #examples }
DSPackages class >> withObjectAndCollectionClasses [
	<gtExample>
	<label: 'Collection with selected Object and Collection class'>
	^ self fromClasses: { Object. OrderedCollection. SortedCollection }
]

{ #category : #'gt-extension' }
DSPackages >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
			title: [ 'Tree' translated ];
			display: [ self ];
			children: [ :item | item children ];
			expandedUntil: 1;
			yourself
]
