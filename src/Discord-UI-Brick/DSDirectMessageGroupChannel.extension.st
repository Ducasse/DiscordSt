Extension { #name : #DSDirectMessageGroupChannel }

{ #category : #'*Discord-UI-Brick' }
DSDirectMessageGroupChannel >> gtInspectorMessagesBloc: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite with: [ :aComposite |
		self isAuthenticated ifTrue: [ 
			self messages gtInspectorMessagesBloc: composite ] ]
]
