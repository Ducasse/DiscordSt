Trait {
	#name : #TDSObjectTree,
	#category : 'Discord-Core-Trait'
}

{ #category : #'gt-inspector-extension' }
TDSObjectTree >> gtChildren [
	"Return children to display in a GT-Inspector tree view.
	Subclasses are encouradged to override it."
	^ #()
]

{ #category : #'gt-inspector-extension' }
TDSObjectTree >> gtInspectorObjectTreeIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Tree' translated ];
		display: [ self gtChildren ];
		when: [ self gtChildren notEmpty ];
		children: [ :item | item gtChildren ];
		expandedUntil: self gtTreeExpandedUntil;
		yourself
]

{ #category : #'gt-inspector-extension' }
TDSObjectTree >> gtTreeExpandedUntil [
	^ 2
]
