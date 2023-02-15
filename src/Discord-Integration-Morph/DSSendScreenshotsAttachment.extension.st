Extension { #name : #DSSendScreenshotsAttachment }

{ #category : #'*Discord-Integration-Morph' }
DSSendScreenshotsAttachment >> addNewWindow [
	| aMenu aHand aPosition |
	aMenu := UIManager default newMenuIn: World for: self.
	((World windowsSatisfying: [ :w | w isCollapsed not and: [ 
			(self includes: w) not ] ])
		asSortedCollection: [ :w1 :w2 | w1 label caseInsensitiveLessOrEqual: w2 label ]) 
		do: [ :w | aMenu add: w label target: self selector: #addMorph: argument: w ].
	aMenu buildTitle: [ :titleMorph | titleMorph title: 'Choose a window to attach' translated ].
	aHand := aMenu activeHand.
	aPosition := aHand position truncated.
	aMenu popUpAt: aPosition forHand: aHand in: World.
	
]

{ #category : #'*Discord-Integration-Morph' }
DSSendScreenshotsAttachment >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ composite morph
		title: [ 'Morph' translated ];
		display: [ | rootMorph |
			rootMorph := DSPanelMorph new.
			rootMorph listDirection: #topToBottom.
			self screenshots do: [ :eachScreenshot | | form |
				form := eachScreenshot form.
				form := form scaledToSize: 400 @ 400.
				rootMorph addMorphBack: form asMorph ].
			rootMorph ];
		when: [ self screenshots notEmpty ];
		yourself
]
