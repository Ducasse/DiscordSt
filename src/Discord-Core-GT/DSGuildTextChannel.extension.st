Extension { #name : 'DSGuildTextChannel' }

{ #category : '*Discord-Core-GT' }
DSGuildTextChannel >> gtInspectorMessages: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite with: [ :aComposite |
		self isAuthenticated ifTrue: [ 
			self messages gtInspectorMessages: composite ] ]
]
