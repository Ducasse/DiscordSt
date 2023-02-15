Extension { #name : #DSDirectMessageChannel }

{ #category : #'*Discord-UI-Brick' }
DSDirectMessageChannel >> gtInspectorMessagesBloc: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite with: [ :aComposite |
		self isAuthenticated ifTrue: [ 
			self messages gtInspectorMessagesBloc: composite ] ]
]
