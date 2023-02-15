"
I am responsible for collecting anonymouse information for a research purpose.
I will be removed, once Juraj Kubelka's PhD is finished.
Using the tool helps me to finish Juraj's PhD and improve the user communication experience.
Thank you for using it :-)
ALL DATA ARE ANONYMOUS

"
Class {
	#name : #DSInformAboutLoadingAction,
	#superclass : #Object,
	#instVars : [
		'loader',
		'data'
	],
	#category : 'Discord-Research'
}

{ #category : #accessing }
DSInformAboutLoadingAction >> data [
	^ data
]

{ #category : #accessing }
DSInformAboutLoadingAction >> data: anObject [
	data := anObject
]

{ #category : #private }
DSInformAboutLoadingAction >> dataHashString [
	| converterClass originalMarkdown |
	converterClass := DSPharoLinkV2Converter.
	originalMarkdown := converterClass urlPrefix, 
		(converterClass defaultUrl ? (converterClass dataQuery -> self data)) asString, 
		converterClass urlSuffix.
	^ originalMarkdown hash asString
]

{ #category : #action }
DSInformAboutLoadingAction >> informAnonymouslyAboutFinishing [
	DSWebhookClient new
		url: 'https://discordapp.com/api/webhooks/413702453062533121/BRYnFdt9D6KqxVLIXYoj2YiUHb4Dpi-22eOCHEnEkZKOVVGHxdFNxXaV5AA6YZJuchg7';
		content: 'Finishing loading (',
			self loader identityHash asString ,') data hash: ', 
			self dataHashString;
		supressNetworkErrors;
		send.
]

{ #category : #action }
DSInformAboutLoadingAction >> informAnonymouslyAboutStarting [
	DSWebhookClient new
		url: 'https://discordapp.com/api/webhooks/413702453062533121/BRYnFdt9D6KqxVLIXYoj2YiUHb4Dpi-22eOCHEnEkZKOVVGHxdFNxXaV5AA6YZJuchg7';
		content: 'Starting loading (', 
			self loader identityHash asString ,') data hash: ', 
			self dataHashString;
		supressNetworkErrors;
		send.
]

{ #category : #accessing }
DSInformAboutLoadingAction >> loader [
	^ loader
]

{ #category : #accessing }
DSInformAboutLoadingAction >> loader: anObject [
	loader := anObject
]
