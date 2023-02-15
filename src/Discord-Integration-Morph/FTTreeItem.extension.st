Extension { #name : #FTTreeItem }

{ #category : #'*Discord-Integration-Morph' }
FTTreeItem >> actualChildren [
	^ children
]

{ #category : #'*Discord-Integration-Morph' }
FTTreeItem >> gtInspectorActualChildrenIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Actual Tree' translated ];
		display: [ self actualChildren ];
		when: [ self actualChildren notNil ];
		children: [ :eachItem | eachItem children ];
		format: [ :eachItem | 
			eachItem data asString,
			(self isExpanded 
				ifTrue: [ ' (expanded)' ] 
				ifFalse: [ ' (collapsed)' ] ) ];
		expandedUntil: 3;
		yourself.
]

{ #category : #'*Discord-Integration-Morph' }
FTTreeItem >> gtInspectorPossibleChildrenIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Possible Tree' translated ];
		display: [ self possibleChildren ];
		when: [ (self class >> #children) isSubclassResponsibility not and: [ 
				[ self children notNil ] on: Error do: [ :exception | false ] ] ];
		children: [ :eachItem | eachItem possibleChildren ];
		format: [ :eachItem | 
			eachItem data asString,
			(self isExpanded 
				ifTrue: [ ' (expanded)' ] 
				ifFalse: [ ' (collapsed)' ] ) ];
		expandedUntil: 3;
		yourself.
]

{ #category : #'*Discord-Integration-Morph' }
FTTreeItem >> possibleChildren [
	^ self children
]
