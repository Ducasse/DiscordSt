Extension { #name : 'DSGuildTextChannel' }

{ #category : '*Discord-Client' }
DSGuildTextChannel >> message [
	^ self restApi messageBuilder
		channel: self;
		yourself
]
