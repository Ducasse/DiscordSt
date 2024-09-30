Extension { #name : 'DSCategoryChannel' }

{ #category : '*Discord-Core-GT' }
DSCategoryChannel >> gtInspectorSubordinateChannelsIn: composition [
	<gtInspectorPresentationOrder: 1>
	^ composition list
		title: [ 'Channels' translated ];
		display: [ self subordinateChannels ];
		when: [ self subordinateChannels notNil ];
		yourself
]
