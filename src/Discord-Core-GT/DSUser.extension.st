Extension { #name : 'DSUser' }

{ #category : '*Discord-Core-GT' }
DSUser >> gtInspectorDirectChannels: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite fastTree
		title: [ 'Direct Channels' translated ];
		display: [ self directChannels ];
		when: [ self directChannels notEmpty ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]
