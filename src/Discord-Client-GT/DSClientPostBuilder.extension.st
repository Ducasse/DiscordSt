Extension { #name : 'DSClientPostBuilder' }

{ #category : '*Discord-Client-GT' }
DSClientPostBuilder >> gtChildren [
	^ { self post. self channel } reject: #isNil
]
