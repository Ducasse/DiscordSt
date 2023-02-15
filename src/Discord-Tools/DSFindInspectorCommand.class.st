"
I search a given model in open GT-Inspector (as a first inspected model).
"
Class {
	#name : #DSFindInspectorCommand,
	#superclass : #DSAbstractFindMorphCommand,
	#category : 'Discord-Tools-Commands'
}

{ #category : #execute }
DSFindInspectorCommand >> execute [
	World submorphs 
		detect: [ :e | e model class = GTInspector and: [ e model entity = self model ] ] 
		ifFound: [ :aMorph | self morph: aMorph ]
		ifNone: nil
]
