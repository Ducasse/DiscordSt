Extension { #name : #DSGuildTextChannel }

{ #category : #'*Discord-UI-Brick' }
DSGuildTextChannel >> gtInspectorMessagesBloc: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite with: [ :aComposite |
		self isAuthenticated ifTrue: [ 
			self messages gtInspectorMessagesBloc: composite ] ]
]
