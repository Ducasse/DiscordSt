Extension { #name : 'Object' }

{ #category : '*Discord-Core' }
Object >> discordAccept: aVisitor [ 
	"Double dispatch for Discord library."
	^ aVisitor visitObject: self
]
