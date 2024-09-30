Extension { #name : 'DSGuild' }

{ #category : '*Discord-Core-GT' }
DSGuild >> gtInspectorChannels: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Channels' translated ];
		display: [ self channels ];
		when: [ self hasChannels or: [ self isAuthenticated ] ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]

{ #category : '*Discord-Core-GT' }
DSGuild >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self members ];
		when: [ self hasMembers or: [ self isAuthenticated ] ];
		children: [ :item | item members ];
		yourself
]
