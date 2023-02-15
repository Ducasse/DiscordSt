Extension { #name : #DSRubricEditorContextMenu }

{ #category : #'*Discord-Integration-Calypso' }
DSRubricEditorContextMenu >> excludeInCalypsoMethodContext [
	<excludeShareOnDiscord>
	^ (editorModel class = RubScrolledTextModel) and: [ 
		editorModel interactionModel isKindOf: ClyMethodCodeEditorTool ]
]
