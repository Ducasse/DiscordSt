Extension { #name : #DSWebhookRegistry }

{ #category : #'*Discord-Send-Items' }
DSWebhookRegistry >> send: aDSSendItems [ 
	"Send items using a Discord Webhook."
	DSDiscordWebhookMessageSender new 
		items: aDSSendItems;
		registry: self;
		send
]
