"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordSendItems,
	#superclass : #PackageManifest,
	#category : 'Discord-Send-Items'
}

{ #category : #'code-critics' }
ManifestDiscordSendItems class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DSSendItems #ensureItem:ofClass: #false)) #'2017-12-28T13:55:27.751074-03:00') )
]
