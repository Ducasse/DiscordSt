Extension { #name : 'TDSObjectTree' }

{ #category : '*Discord-Core-GT' }
TDSObjectTree >> gtChildren [
	"Return children to display in a GT-Inspector tree view.
	Subclasses are encouradged to override it."
	^ #()
]

{ #category : '*Discord-Core-GT' }
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

{ #category : '*Discord-Core-GT' }
TDSObjectTree >> gtTreeExpandedUntil [
	^ 2
]
