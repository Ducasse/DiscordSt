Extension { #name : 'DSGuilds' }

{ #category : '*Discord-Core-GT' }
DSGuilds >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: -9>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item members ];
		expandedUntil: 0;
		yourself
]

{ #category : '*Discord-Core-GT' }
DSGuilds >> gtInspectorServers: composite [
	<gtInspectorPresentationOrder: -10>
	^ composite fastTree
		title: [ 'Servers' translated ];
		display: [ self ];
		when: [ self notEmpty ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]
