Extension { #name : #DSMessage }

{ #category : #'*Discord-UI-Brick' }
DSMessage >> gtInspectorBloc: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite bloc
		title: [ 'Bloc' translated ];
		display: [ DSMessageElement new message: self; yourself ];
		when: [ self hasContent or: [ self hasEmbeds ] ];
		yourself
]

{ #category : #'*Discord-UI-Brick' }
DSMessage >> gtLiveFor: aView [
	<gtView>
	(self hasContent or: [ self hasEmbeds ]) ifFalse: [ ^ aView empty ].
	^ aView explicit 
		title: 'Live';
		priority: 0;
		stencil: [ DSMessageElement new message: self ]
]
