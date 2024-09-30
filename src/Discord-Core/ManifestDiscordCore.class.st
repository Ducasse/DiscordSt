"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestDiscordCore',
	#superclass : 'PackageManifest',
	#category : 'Discord-Core-Manifest',
	#package : 'Discord-Core',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestDiscordCore class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSModelJsonMapping class' #write:mappedTo: #true)) #'2017-11-08T13:47:28.032545-03:00') #(#(#RGMethodDefinition #(#'DSModelJsonMapping class' #read:withMapping:on: #true)) #'2017-11-08T13:47:41.186048-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordCore class >> ruleRBExcessiveMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'DSModelJsonMapping class' #DSModelJsonMapping)) #'2017-11-06T16:44:54.419092-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordCore class >> ruleRBExcessiveVariablesRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#DSGuild)) #'2017-11-07T19:40:07.275325-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordCore class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'DSModelJsonMapping class' #DSModelJsonMapping)) #'2017-11-07T11:55:04.095481-03:00') )
]

{ #category : 'code-critics' }
ManifestDiscordCore class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#TDSDataPost #addMimePart: #false)) #'2017-11-27T10:26:01.135285-03:00') )
]
