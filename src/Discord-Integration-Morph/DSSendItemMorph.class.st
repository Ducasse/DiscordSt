Class {
	#name : #DSSendItemMorph,
	#superclass : #DSPanelMorph,
	#instVars : [
		'item'
	],
	#category : 'Discord-Integration-Morph'
}

{ #category : #initialization }
DSSendItemMorph >> initialize [
	super initialize.
	item := self newSendItem.
]

{ #category : #accessing }
DSSendItemMorph >> item [
	^ item
]

{ #category : #accessing }
DSSendItemMorph >> item: aSendItem [
	| oldItem |
	aSendItem = item ifTrue: [ ^ self ].
	oldItem := item.
	item := aSendItem.
	self itemChangedFrom: oldItem to: aSendItem.
]

{ #category : #'announcement handling' }
DSSendItemMorph >> itemChangedFrom: oldDSSendItem to: newDSSendItem [
	"Performed on item change. Subclasses can perform specific actions."
]

{ #category : #'instance creation' }
DSSendItemMorph >> newSendItem [
	<return: #DSSendItem>
	^ self subclassResponsibility
]
