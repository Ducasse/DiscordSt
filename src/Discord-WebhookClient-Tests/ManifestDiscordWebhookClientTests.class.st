"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordWebhookClientTests,
	#superclass : #PackageManifest,
	#category : 'Discord-WebhookClient-Tests'
}

{ #category : #'code-critics' }
ManifestDiscordWebhookClientTests class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSWebhookPostTest class' #isAbstract #true)) #'2017-05-08T11:19:59.754939-03:00') )
]
