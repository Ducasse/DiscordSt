Extension { #name : #DSDirectMessageChannel }

{ #category : #'*Discord-Client' }
DSDirectMessageChannel >> message [
	^ self restApi messageBuilder
		channel: self;
		yourself
]
