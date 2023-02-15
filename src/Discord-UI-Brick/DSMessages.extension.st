Extension { #name : #DSMessages }

{ #category : #'*Discord-UI-Brick' }
DSMessages >> gtInspectorMessagesBloc: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite bloc 
		title: [ 'Messages (Bloc)' ];
		display: [ DSMessagesElement new
				dataSource: (DSMessagesDataSource new messages: self; yourself);
				yourself ];
		when: [ self notEmpty ];
		yourself
]

{ #category : #'*Discord-UI-Brick' }
DSMessages >> gtLiveFor: aView [
	<gtView>
	self isEmpty ifTrue: [ ^ aView empty ].
	^ aView explicit 
		title: 'Live';
		priority: -1;
		stencil: [ DSMessagesElement new
				dataSource: (DSMessagesDataSource new messages: self) ]
]
