Extension { #name : 'DSDirectMessageChannel' }

{ #category : '*Discord-Core-GT' }
DSDirectMessageChannel >> gtInspectorMessages: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite with: [ :aComposite |
			self messages gtInspectorMessages: composite ]
]
