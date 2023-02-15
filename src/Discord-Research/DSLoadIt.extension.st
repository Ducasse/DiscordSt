Extension { #name : #DSLoadIt }

{ #category : #'*Discord-Research' }
DSLoadIt >> informAboutFinishedLoading [
	DSInformAboutLoadingAction new 
		loader: self;
		data: self data;
		informAnonymouslyAboutFinishing.
]

{ #category : #'*Discord-Research' }
DSLoadIt >> informAboutStartingLoading [
	DSInformAboutLoadingAction new 
		loader: self;
		data: self data;
		informAnonymouslyAboutStarting.
]
