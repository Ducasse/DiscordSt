"
I search a given model in open GT-Inspector.
I search in any open GT-Inspector pane.
"
Class {
	#name : #DSFindInspectorPaneCommand,
	#superclass : #DSAbstractFindMorphCommand,
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSFindInspectorPaneCommand >> execute [
	World submorphs
		detect: [ :e | 
			e model class = GTInspector
				and: [ (e model panes flatCollect: #presentations) anySatisfy: [ :presentation | 
						presentation entity = self model ] ] ]
		ifFound: [ :aMorph | self morph: aMorph ]
		ifNone: nil
]
