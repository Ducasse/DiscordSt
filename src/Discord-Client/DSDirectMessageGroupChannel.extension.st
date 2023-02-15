Extension { #name : #DSDirectMessageGroupChannel }

{ #category : #'*Discord-Client' }
DSDirectMessageGroupChannel >> message [
	^ self restApi messageBuilder
		channel: self;
		yourself
]
