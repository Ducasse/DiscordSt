"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordRegistryCore,
	#superclass : #PackageManifest,
	#category : 'Discord-Registry-Core'
}

{ #category : #'code-critics' }
ManifestDiscordRegistryCore class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSRegistries class' #addRegistryFromPragma: #true)) #'2018-01-04T16:57:20.883451-03:00') )
]
