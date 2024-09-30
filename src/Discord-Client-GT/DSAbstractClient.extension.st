Extension { #name : 'DSAbstractClient' }

{ #category : '*Discord-Client-GT' }
DSAbstractClient >> gtInspectorDirectChannels: composite [
	<gtInspectorPresentationOrder: 3>
	^ composite fastList
		title: [ 'Direct Channels' translated ];
		display: [ self directChannels ];
		when: [ self isAuthenticated ];
		selectionAct: [ :presentation | | id |
			id := presentation rawSelection recipients first id.
			Clipboard clipboardText: id asString. ]
			entitled: 'Copy Recipient''s id';
		enableFilter;
		yourself
]

{ #category : '*Discord-Client-GT' }
DSAbstractClient >> gtInspectorMembers: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite fastTree
		title: [ 'Members' translated ];
		display: [ self servers ];
		when: [ self isAuthenticated ];
		children: [ :item | item members ];
		expandedUntil: 0;
		yourself
]

{ #category : '*Discord-Client-GT' }
DSAbstractClient >> gtInspectorServers: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite fastTree
		title: [ 'Servers' translated ];
		display: [ self servers ];
		when: [ self isAuthenticated ];
		children: [ :item | item children ];
		expandedUntil: 1;
		yourself
]
