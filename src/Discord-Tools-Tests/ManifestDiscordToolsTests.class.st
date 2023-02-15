"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordToolsTests,
	#superclass : #PackageManifest,
	#category : 'Discord-Tools-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestDiscordToolsTests class >> ruleRBTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DSSendActionbarMorphTest #testCancel #false)) #'2017-12-06T09:53:36.614975-03:00') #(#(#RGMethodDefinition #(#DSSendActionbarMorphTest #testCancel2 #false)) #'2017-12-06T09:53:40.136105-03:00') #(#(#RGMethodDefinition #(#DSSendActionbarMorphTest #testSend #false)) #'2017-12-06T09:53:43.736444-03:00') #(#(#RGMethodDefinition #(#DSSendActionbarMorphTest #testSend2 #false)) #'2017-12-06T09:53:47.071348-03:00') )
]
