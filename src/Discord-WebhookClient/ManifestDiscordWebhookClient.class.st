"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDiscordWebhookClient,
	#superclass : #PackageManifest,
	#category : 'Discord-WebhookClient'
}

{ #category : #'code-critics' }
ManifestDiscordWebhookClient class >> ruleRBCodeCruftLeftInMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSWebhookClient class' #handleNetworkError #true)) #'2017-06-14T10:19:43.96312+02:00') )
]

{ #category : #'code-critics' }
ManifestDiscordWebhookClient class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'DSWebhookClient class' #postImage #true)) #'2017-06-13T18:29:42.662638+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #handleNetworkError #true)) #'2017-06-14T10:19:46.602459+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #ignoreAnyNetworkError #true)) #'2017-06-14T10:19:57.313379+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #postEmbedRichObject #true)) #'2017-06-14T10:20:11.212445+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #postFormAsScreenshot #true)) #'2017-06-14T10:20:21.700001+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #postMorphAsScreenshot #true)) #'2017-06-14T10:20:33.688037+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #postSimpleMessage #true)) #'2017-06-14T10:20:41.732805+02:00') #(#(#RGMethodDefinition #(#'DSWebhookClient class' #postSimpleMessageWithUsernameAndAvatar #true)) #'2017-06-14T10:20:51.666982+02:00') )
]
