"
I keep Neo JSON mappings between Discord objects and their JSON representations.
"
Class {
	#name : 'DSModelJsonMapping',
	#superclass : 'Object',
	#category : 'Discord-Core-Utility',
	#package : 'Discord-Core',
	#tag : 'Utility'
}

{ #category : 'mapping - message' }
DSModelJsonMapping class >> attachmentMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSAttachment do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #filename.
	      mapping mapAccessor: #fileSize to: #size.
			mapping mapAccessor: #url.
			mapping mapAccessor: #proxyUrl to: #proxy_url.
			mapping mapAccessor: #height.
			mapping mapAccessor: #width ].
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> channelTypeMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSChannelType customDo: [ :mapping |
			mapping 
				"We do not need an enconder as it is used only for reading."
				decoder: [ :anInteger | 
					DSChannelType newFromNumber: anInteger ] ].
	DSChannelType allChannelTypes do: [ :eachType | 
		aNeoJSONMapper 
			for: eachType customDo: [ :mapping |
				mapping
					encoder: [ :anInstance | anInstance typeNumber ] ] ]
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfAttachmentsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfAttachments customDo: [ :mapping |
			mapping listOfElementSchema: DSAttachment ].
	self attachmentMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfEmbedsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfEmbeds customDo: [ :mapping |
			mapping listOfElementSchema: DSEmbed ].
	self embedMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfEmojisMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfEmojis customDo: [ :mapping |
			mapping listOfElementSchema: DSEmoji ].
	self emojiMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> collectionOfFieldsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfFields customDo: [ :mapping |
			mapping listOfElementSchema: DSEmbedField ].
	self embedFieldMappingFor: aNeoJSONMapper.

]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> collectionOfGuildMembersMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfGuildMembers customDo: [ :mapping |
			mapping listOfType: DSGuildMembers andElementSchema: DSGuildMember ].
	self guildMemberMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> collectionOfGuildsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfGuilds customDo: [ :mapping |
			mapping listOfType: DSGuilds andElementSchema: DSGuild ].
	self guildMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfMessagesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfMessages customDo: [ :mapping |
			mapping listOfType: DSMessages andElementSchema: DSMessage ].
	self messageMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> collectionOfOverwritesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfOverwrites customDo: [ :mapping |
			mapping listOfElementSchema: DSOverwrite ].
	self overwriteMappingFor: aNeoJSONMapper.

]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> collectionOfPresenceUpdatesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfPresenceUpdates customDo: [ :mapping |
			mapping listOfElementSchema: DSPresenceUpdate ].
	self presenceUpdateMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfReactionsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfReactions customDo: [ :mapping |
			mapping listOfElementSchema: DSReaction ].
	self reactionMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfRolesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfRoles customDo: [ :mapping |
			mapping listOfElementSchema: DSRole ].
	self roleMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> collectionOfSortedChannelsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfSortedChannels customDo: [ :mapping |
			mapping reader: [ :jsonReader | | specifiedChannels |
					specifiedChannels := jsonReader nextAs: #CollectionOfSpecifiedChannels.
					DSSortChannelsCommand new 
						channels: specifiedChannels;
						execute;
						sortedChannels ].
			mapping writer: [ :jsonWriter :aCollection | | flattenedChannels |
				flattenedChannels := DSFlattenChannelsOrderByIdCommand new 
					channels: aCollection;
					execute;
					flattenedChannels.
				jsonWriter nextPut: flattenedChannels ] ].
	self 
		collectionOfSpecifiedChannelsMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> collectionOfSpecifiedChannelsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfSpecifiedChannels customDo: [ :mapping |
			mapping reader: [ :jsonReader | | unspecifiedChannels |
					unspecifiedChannels := jsonReader nextAs: #CollectionOfUnspecifiedChannels.
					unspecifiedChannels collect: #asSpecifiedChannel ].
			mapping writer: [ :jsonWriter :anObject |
				jsonWriter nextPut: anObject ] ].
	self 
		collectionOfUnspecifiedChannelsMappingFor: aNeoJSONMapper;
		guildTextChannelMappingFor: aNeoJSONMapper;
		guildVoiceChannelMappingFor: aNeoJSONMapper;
		guildDMChannelMappingFor: aNeoJSONMapper;
		guildDMGroupChannelMappingFor: aNeoJSONMapper;
		guildCategoryChannelMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> collectionOfUnspecifiedChannelsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfUnspecifiedChannels customDo: [ :mapping |
			mapping listOfType: DSChannels andElementSchema: DSUnspecifiedChannel ].
	self unspecifiedChannelMappingFor: aNeoJSONMapper.

]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> collectionOfUsersMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfUsers customDo: [ :mapping |
			mapping listOfElementSchema: DSUser ].
	self userMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> collectionOfVoiceStatesMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #CollectionOfVoiceStates customDo: [ :mapping |
			mapping listOfElementSchema: DSVoiceState ].
	self voiceStateMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSModelJsonMapping class >> colorMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: Color customDo: [ :mapping |
			mapping 
				encoder: [ :aColor | 
					(aColor blue * 255) asInteger 
						+ ((aColor green * 255) asInteger << 8) 
						+ ((aColor red * 255) asInteger << 16) ];
				decoder: [ :anInteger | 
					Color 
						r: (anInteger >> 16) / 255 
						g: (anInteger >> 8 bitClear: 16776960) / 255 
						b: (anInteger bitClear: 16776960) / 255 ] ]
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> connectionStatusMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSConnectionStatus 
		customDo: [ :mapping | 
			"We do not need an enconder as it is used only for reading."
			mapping decoder: [ :aString |
				DSConnectionStatus newFromString: aString ] ].
	DSConnectionStatus allStatuses do: [ :eachStatus |
		aNeoJSONMapper 
			for: eachStatus customDo: [ :mapping | 
				mapping encoder: [ :anInstance | anInstance statusString ] ] ].
]

{ #category : 'mapping - basic' }
DSModelJsonMapping class >> dateAndTimeMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DateAndTime customDo: [ :mapping |
			mapping 
				encoder: [ :aDateAndTime | aDateAndTime asString ];
				decoder: [ :aStringOrNil | 
					aStringOrNil ifNotNil: [ :aString | aString asDateAndTime ] ] ]
]

{ #category : 'mapping - basic' }
DSModelJsonMapping class >> durationInSecondsMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #DurationInSeconds customDo: [ :mapping |
			mapping 
				encoder: [ :aDuration | aDuration asSeconds ];
				decoder: [ :anIntegerOrNil | 
					anIntegerOrNil ifNotNil: [ :anInteger | anInteger seconds ] ] ]
]

{ #category : 'mapping - payload' }
DSModelJsonMapping class >> editMessagePayloadMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: NeoJSONObject do: [ :mapping |
	      mapping mapAccessor: #content.
	      (mapping mapAccessor: #embed) valueSchema: DSEmbed ].
	self embedMappingFor: aNeoJSONMapper
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedAuthorMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbedAuthor do: [ :mapping |
			(mapping mapAccessor: #name).
	      (mapping mapAccessor: #url) valueSchema: ZnUrl.
			(mapping mapAccessor: #iconUrl to: #icon_url) valueSchema: ZnUrl.
			(mapping mapAccessor: #proxyIconUrl to: #proxy_icon_url) valueSchema: ZnUrl ].
	self urlMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedFieldMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbedField do: [ :mapping |
	      (mapping mapAccessor: #name).
			(mapping mapAccessor: #value).
			(mapping mapAccessor: #isInline to: #inline) ].

]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedFooterMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbedFooter do: [ :mapping |
	      (mapping mapAccessor: #text).
			(mapping mapAccessor: #iconUrl to: #icon_url) valueSchema: ZnUrl.
			(mapping mapAccessor: #proxyIconUrl to: #proxy_icon_url) valueSchema: ZnUrl ].
	self urlMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedImageMappingFor: aNeoJSONMapper [
	self image: DSEmbedImage mappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbed do: [ :mapping |
	      (mapping mapAccessor: #title).
			(mapping mapAccessor: #type).
			(mapping mapAccessor: #description).
			(mapping mapAccessor: #url) valueSchema: ZnUrl.
			(mapping mapAccessor: #timestamp) valueSchema: DateAndTime.
			(mapping mapAccessor: #color) valueSchema: Color.
			(mapping mapAccessor: #footer) valueSchema: DSEmbedFooter.
			(mapping mapAccessor: #image) valueSchema: DSEmbedImage.
			(mapping mapAccessor: #thumbnail) valueSchema: DSEmbedThumbnail.
			(mapping mapAccessor: #video) valueSchema: DSEmbedVideo.
			(mapping mapAccessor: #provider) valueSchema: DSEmbedProvider.
			(mapping mapAccessor: #author) valueSchema: DSEmbedAuthor.
			(mapping mapAccessor: #fields) valueSchema: #CollectionOfFields. ].
	self 
		urlMappingFor: aNeoJSONMapper;
		dateAndTimeMappingFor: aNeoJSONMapper;
		colorMappingFor: aNeoJSONMapper;
		embedFooterMappingFor: aNeoJSONMapper;
		embedImageMappingFor: aNeoJSONMapper;
		embedThumbnailMappingFor: aNeoJSONMapper;
		embedVideoMappingFor: aNeoJSONMapper;
		embedProviderMappingFor: aNeoJSONMapper;
		embedAuthorMappingFor: aNeoJSONMapper;
		collectionOfFieldsMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedProviderMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbedProvider do: [ :mapping |
	      (mapping mapAccessor: #name).
			(mapping mapAccessor: #url) valueSchema: ZnUrl ].
	self urlMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedThumbnailMappingFor: aNeoJSONMapper [
	self image: DSEmbedThumbnail mappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - embed' }
DSModelJsonMapping class >> embedVideoMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmbedVideo do: [ :mapping |
	      (mapping mapAccessor: #url) valueSchema: ZnUrl.
			(mapping mapAccessor: #height).
			(mapping mapAccessor: #width) ].
	self urlMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> emojiMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSEmoji do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #name.
	      (mapping mapAccessor: #roles) valueSchema: #CollectionOfRoles.
			(mapping mapAccessor: #user) valueSchema: DSUser.
			mapping mapAccessor: #requireColons to: #require_colons.
			mapping mapAccessor: #managed ].
	self
		collectionOfRolesMappingFor: aNeoJSONMapper;
		userMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> gameMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGame
		do: [ :mapping | 
			mapping allowNil.
			mapping mapAccessor: #name.
			mapping mapAccessor: #type.
			(mapping mapAccessor: #url) valueSchema: ZnUrl ].
	self 
		urlMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> guildCategoryChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSCategoryChannel do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping 
				mapProperty: #type 
				getter: [ :object | object type ] 
				setter: [ :object :value | "ignore" ]) valueSchema: DSChannelGuildTextType.
			(mapping mapAccessor: #guildId to: #guild_id).
			(mapping mapAccessor: #position).			
			(mapping mapAccessor: #permissionOverwrites to: #permission_overwrites) 
				valueSchema: #CollectionOfOverwrites.
			(mapping mapAccessor: #name).
			(mapping mapAccessor: #nsfw) ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfOverwritesMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> guildDMChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSDirectMessageChannel do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping 
				mapProperty: #type 
				getter: [ :object | object type ] 
				setter: [ :object :value | "ignore" ]) valueSchema: DSChannelGuildTextType.
			(mapping mapAccessor: #lastMessageId to: #last_message_id). 
			(mapping mapAccessor: #recipients) valueSchema: #CollectionOfUsers ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> guildDMGroupChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSDirectMessageGroupChannel do: [ :mapping |
			mapping mapAccessor: #id.
			(mapping 
				mapProperty: #type 
				getter: [ :object | object type ] 
				setter: [ :object :value | "ignore" ]) valueSchema: DSChannelGuildTextType.
			mapping mapAccessor: #name.
			mapping mapAccessor: #lastMessageId to: #last_message_id. 
			(mapping mapAccessor: #recipients) valueSchema: #CollectionOfUsers.
			mapping mapAccessor: #icon.
			mapping mapAccessor: #ownerId to: #owner_id ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> guildMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGuild
		do: [ :mapping | 
			mapping mapAccessor: #id.
			mapping mapAccessor: #name.
			mapping mapAccessor: #iconHash to: #icon.
			mapping mapAccessor: #splashHash to: #splash.
			mapping mapAccessor: #ownerId to: #owner_id.
			mapping mapAccessor: #region.
			mapping mapAccessor: #afkChannelId to: #afk_channel_id.
			(mapping mapAccessor: #afkTimeout to: #afk_timeout) valueSchema: #DurationInSeconds.
			mapping mapAccessor: #embedEnabled to: #embed_enabled.
			mapping mapAccessor: #embedChannelId to: #embed_channel_id.
			mapping mapAccessor: #verificationLevel to: #verification_level.
			mapping mapAccessor: #defaultMessageNotifications to: #default_message_notifications.
			mapping mapAccessor: #explicitContentFilter to: #explicit_content_filter.
			(mapping mapAccessor: #roles) valueSchema: #CollectionOfRoles.
			(mapping mapAccessor: #emojis) valueSchema: #CollectionOfEmojis.
			mapping mapAccessor: #features.
			mapping mapAccessor: #mfaLevel to: #mfa_level.
			mapping mapAccessor: #applicationId to: #application_id.
			mapping mapAccessor: #widgetEnabled to: #widget_enabled.
			mapping mapAccessor: #widgetChannelId to: #widget_channel_id.
			(mapping mapAccessor: #joinedAt to: #joined_at) valueSchema: DateAndTime.
			mapping mapAccessor: #large.
			mapping mapAccessor: #unavailable.
			mapping mapAccessor: #memberCount to: #member_count.
			(mapping mapAccessor: #voiceStates to: #voice_states) valueSchema: #CollectionOfVoiceStates.
			(mapping mapAccessor: #members) valueSchema: #CollectionOfGuildMembers.
			(mapping mapAccessor: #channels) valueSchema: #CollectionOfSortedChannels.
			(mapping mapAccessor: #presences) valueSchema: #CollectionOfPresenceUpdates ].
	self 
		durationInSecondsMappingFor: aNeoJSONMapper;
		collectionOfRolesMappingFor: aNeoJSONMapper;
		collectionOfEmojisMappingFor: aNeoJSONMapper;
		dateAndTimeMappingFor: aNeoJSONMapper;
		collectionOfVoiceStatesMappingFor: aNeoJSONMapper;
		collectionOfGuildMembersMappingFor: aNeoJSONMapper;
		collectionOfSortedChannelsMappingFor: aNeoJSONMapper;
		collectionOfPresenceUpdatesMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> guildMemberMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGuildMember
		do: [ :mapping | 
			(mapping mapAccessor: #user) valueSchema: DSUser.
			mapping mapAccessor: #nick.
			mapping mapAccessor: #roleIds to: #roles.
			(mapping mapAccessor: #joinedAt to: #joined_at) valueSchema: DateAndTime.
			mapping mapAccessor: #deaf.
			mapping mapAccessor: #mute ].
	self 
		userMappingFor: aNeoJSONMapper;
		dateAndTimeMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> guildTextChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGuildTextChannel do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping 
				mapProperty: #type 
				getter: [ :object | object type ] 
				setter: [ :object :value | "ignore" ]) valueSchema: DSChannelGuildTextType.
			(mapping mapAccessor: #guildId to: #guild_id).
			(mapping mapAccessor: #position).			
			(mapping mapAccessor: #permissionOverwrites to: #permission_overwrites) 
				valueSchema: #CollectionOfOverwrites.
			(mapping mapAccessor: #name).
			(mapping mapAccessor: #topic).
			(mapping mapAccessor: #nsfw).
			(mapping mapAccessor: #lastMessageId to: #last_message_id).
			(mapping mapAccessor: #icon).
			(mapping mapAccessor: #parentId to: #parent_id) ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfOverwritesMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> guildVoiceChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSGuildVoiceChannel do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping 
				mapProperty: #type 
				getter: [ :object | object type ] 
				setter: [ :object :value | "ignore" ]) valueSchema: DSChannelGuildTextType.
			(mapping mapAccessor: #guildId to: #guild_id).
			(mapping mapAccessor: #position).			
			(mapping mapAccessor: #permissionOverwrites to: #permission_overwrites) 
				valueSchema: #CollectionOfOverwrites.
			(mapping mapAccessor: #name).
			(mapping mapAccessor: #bitrate).
			(mapping mapAccessor: #userLimit to: #user_limit).
			(mapping mapAccessor: #parentId to: #parent_id) ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfOverwritesMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSModelJsonMapping class >> image: anImageClass mappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: anImageClass do: [ :mapping |
	      (mapping mapAccessor: #url) valueSchema: ZnUrl.
	      (mapping mapAccessor: #proxyUrl to: #proxy_url) valueSchema: ZnUrl.
			(mapping mapAccessor: #height).
			(mapping mapAccessor: #width) ].
	self urlMappingFor: aNeoJSONMapper.
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonAllPropertiesChannel [
	^ '{"id":"376680041881962816","type":0,"guild_id":"376204541188962822","position":1,"permission_overwrites":',
	self jsonCollectionOfOverwritesOne,
	',"name":"the name of the channel (2-100 characters)","topic":"the channel topic (0-1024 characters)","nsfw":false,"last_message_id":"372200541188962021","bitrate":1204,"user_limit":24,"recipients":',
	self jsonCollectionOfUsersOne, 
	',"icon":"309350229021696111","owner_id":"319350229021696243","application_id":"319347229021696269","parent_id":"371083041588962823"}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonAttachment [
	^ '{"id":"376014041878912856","filename":"file.jpg","size":32143,"url":"http://cdn.example.com/attachment.jpg","proxy_url":"http://proxy.example.com/attachment.jpg","height":512,"width":768}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonChannelCategory [
	^ 
	'{"id":"41771983423143939","type":4,"guild_id":"290926798629997250","position":0,"permission_overwrites":[],"name":"Test","nsfw":false}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonChannelDirectMessage [
	^ '{"id":"319674150115610528","type":1,"last_message_id":"3343820033257021450","recipients":[{"id":"82198898841029460","username":"test","discriminator":"9999","avatar":"33ecab261d4681afa4d85a04691c4a01"}]}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonChannelDirectMessageGroup [
	^ '{"id":"319674150115710528","type":3,"name":"Some test channel","last_message_id":"3343820033257021450","recipients":[{"id":"82198898841029460","username":"test","discriminator":"9999","avatar":"33ecab261d4681afa4d85a04691c4a01"},{"id":"82198810841029460","username":"test2","discriminator":"9999","avatar":"33ecab261d4681afa4d85a10691c4a01"}],"icon":"an icon hash","owner_id":"82198810841029460"}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonChannelGuildText [
	^ '{"id":"41771983423143937","type":0,"guild_id":"41771983423143937","position":6,"permission_overwrites":[],"name":"general","topic":"24/7 chat about how to gank Mike #2","nsfw":true,"last_message_id":"155117677105512449","icon":"309350229021696111","parent_id":"41771983423143939"}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonChannelGuildVoice [
	^ '{"id":"41771983423143938","type":2,"guild_id":"41771983423143937","position":5,"permission_overwrites":[],"name":"ROCKET CHEESE","bitrate":64000,"user_limit":0,"parent_id":"41771983423143939"}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfAttachmentsOne [
	^ '[', self jsonAttachment, ']'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonCollectionOfChannelsOne [
	^ '[', self jsonAllPropertiesChannel, ']'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonCollectionOfChannelsThree [
	^ '[', self jsonChannelGuildText, ',', self jsonChannelGuildVoice, ',', self jsonChannelCategory, ']'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonCollectionOfChannelsTwo [
	^ '[', self jsonChannelGuildText, ',', self jsonChannelGuildVoice, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfEmbedsOne [
	^ '[', self jsonEmbedOneField, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfEmojisOne [
	^ '[', self jsonEmoji, ']'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonCollectionOfGuildMembersOne [
	^ '[', self jsonGuildMember, ']'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonCollectionOfGuildsOne [
	^ '[', self jsonGuild, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfMessagesOne [
	^ '[', self jsonMessage, ']'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonCollectionOfOverwritesOne [
	^ '[', self jsonOverwriteRole, ']'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonCollectionOfPresenceUpdatesOne [
	^ '[', self jsonPresenceUpdate, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfReactionsOne [
	^ '[', self jsonReaction, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfRolesOne [
	^ '[', self jsonRole, ']'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonCollectionOfUsersOne [
	^ '[', self jsonUser, ']'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonCollectionOfVoiceStatesOne [
	^ '[', self jsonVoiceState, ']'
]

{ #category : 'json example - payload' }
DSModelJsonMapping class >> jsonEditMessagePayload [
	^ '{"content":"any string","embed":', self jsonEmbedOneField, '}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedAuthor [
	^ '{"name":"name of author","url":"https://example.com/author.html","icon_url":"http://cdn.example.com/author_icon.png","proxy_icon_url":"http://image.example.com/author_icon.png"}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedField [
	^ '{"name":"name of the field","value":"value of the field","inline":true}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedFieldFalse [
	^ '{"name":"name of the not-inlined field","value":"value of the not-inlined field","inline":false}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedFieldsOne [
	^ '[', self jsonEmbedField, ']'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedFieldsTwo [
	^ '[', self jsonEmbedField, ',', self jsonEmbedFieldFalse, ']'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedFooter [
	^ '{"text":"footer text","icon_url":"http://cdn.example.com/icon.png","proxy_icon_url":"http://image.example.com/icon.png"}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedImage [
	^ '{"url":"http://cdn.example.com/image.jpg","proxy_url":"http://proxy.example.com/image.jpg","height":618,"width":967}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedOneField [
	^ '{"title":"title of embed","type":"rich","description":"description of embed","url":"http://example.com/embed.html","timestamp":"2017-11-03T15:21:38.579+00:00","color":16711680,"footer":',
	self jsonEmbedFooter, 
	',"image":', self jsonEmbedImage,
	',"thumbnail":', self jsonEmbedThumbnail,
	',"video":', self jsonEmbedVideo,
	',"provider":', self jsonEmbedProvider,
	',"author":', self jsonEmbedAuthor,
	',"fields":', self jsonEmbedFieldsOne, '}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedProvider [
	^ '{"name":"name of provider","url":"http://example.com/provider.html"}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedThumbnail [
	^ '{"url":"http://cdn.example.com/thumbnail.jpg","proxy_url":"http://proxy.example.com/thumbnail.jpg","height":128,"width":64}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonEmbedVideo [
	^ '{"url":"http://example.com/video.html","height":768,"width":1024}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonEmoji [
	^ '{"id":"41274983523343936","name":"emoji name","roles":',
	self jsonCollectionOfRolesOne,
	',"user":', self jsonUser, 
	',"require_colons":true,"managed":false}'
]

{ #category : 'json examples - embed' }
DSModelJsonMapping class >> jsonGame [
	^ '{"name":"Rocket League","type":1,"url":"https://www.twitch.tv/123"}'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonGuild [
	^ '{"id":"41771983423143921","name":"guild name (2-100 characters)","icon":"icon hash","splash":"splash hash","owner_id":"41771983763143932","region":"voice_region.id","afk_channel_id":"41771983423143920","afk_timeout":300,"embed_enabled":true,"embed_channel_id":"41771983423143921","verification_level":0,"default_message_notifications":1,"explicit_content_filter":2,"roles":',
	self jsonCollectionOfRolesOne, ',"emojis":', self jsonCollectionOfEmojisOne, ',"features":"enabled guild features","mfa_level":1,"application_id":"31771923763143932","widget_enabled":true,"widget_channel_id":"41771983423143921","joined_at":"2017-11-03T15:21:38.579+00:00","large":true,"unavailable":false,"member_count":108,"voice_states":', self jsonCollectionOfVoiceStatesOne, ',"members":', self jsonCollectionOfGuildMembersOne, ',"channels":', self jsonCollectionOfChannelsThree, ',"presences":', self jsonCollectionOfPresenceUpdatesOne, '}'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonGuildMember [
	^ '{"user":', self jsonUser, ',"nick":"this users guild nickname (if one is set)","roles":["80351110222677913"],"joined_at":"2015-04-26T06:26:56.936+00:00","deaf":false,"mute":false}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonMessage [
	^ '{"id":"376084041888962816","channel_id":"376284541188962813","author":',
	self jsonUser,
	',"content":"contents of the message","timestamp":"2015-11-01T15:21:38.579002+03:00","edited_timestamp":"2015-11-01T15:22:31.579001+03:00","tts":true,"mention_everyone":false,"mentions":',
	self jsonCollectionOfUsersOne, 
	',"mention_roles":["309350229021696116"],"attachments":',
	self jsonCollectionOfAttachmentsOne, ',"embeds":', self jsonCollectionOfEmbedsOne, 
	',"reactions":', self jsonCollectionOfReactionsOne, 
	',"nonce":"my-private-id","pinned":true,"webhook_id":"376084041888962823","type":0}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonOverwriteMember [
	^ '{"id":"376082041888961714","type":"member","allow":123,"deny":345}'
]

{ #category : 'json examples - channel' }
DSModelJsonMapping class >> jsonOverwriteRole [
	^ '{"id":"376082041888961711","type":"role","allow":987,"deny":654}'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonPresenceUpdate [
	^ '{"user":', self jsonUser, ',"roles":["80351110222677913"],"game":',
	self jsonGame, ',"guild_id":"60251110222617911","status":"idle"}'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonPresenceUpdateWithGameNull [
	^ '{"user":{"id":"286153065164308480"},"game":null,"status":"idle"}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonReaction [
	^ '{"count":5,"me":true,"emoji":', self jsonEmoji, '}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonRecipient [
	^ '{"recipient_id":"80351110224678912"}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonRole [
	^ '{"id":"41771983423143936","name":"WE DEM BOYZZ!!!!!!","color":3447003,"hoist":true,"position":1,"permissions":66321471,"managed":false,"mentionable":false}'
]

{ #category : 'json examples - message' }
DSModelJsonMapping class >> jsonUser [
	^ '{"id":"80351110224678912","username":"Nelly","discriminator":"1337","avatar":"8342729096ea3675442027381ff50dfe","bot":false,"mfa_enabled":false,"verified":true,"email":"nelly@discordapp.com"}'
]

{ #category : 'json examples - guild' }
DSModelJsonMapping class >> jsonVoiceState [
	^ '{"guild_id":"157733188964188161","channel_id":"157733188964188160","user_id":"80351110224678912","session_id":"90326bd25d71d39b9ef95b299e3872ff","deaf":false,"mute":false,"self_deaf":false,"self_mute":true,"suppress":false}'
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> messageMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSMessage do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #channelId to: #channel_id.
	      (mapping mapAccessor: #author) valueSchema: DSUser.
	      mapping mapAccessor: #content.
	      (mapping mapAccessor: #timestamp) valueSchema: DateAndTime.
	      (mapping mapAccessor: #editedTimestamp to: #edited_timestamp) valueSchema: DateAndTime.
			mapping mapAccessor: #isTextToSpeech to: #tts.
			mapping mapAccessor: #hasMentionEveryone to: #mention_everyone.
			(mapping mapAccessor: #mentions) valueSchema: #CollectionOfUsers.
			(mapping mapAccessor: #mentionRoleIds to: #mention_roles).
			(mapping mapAccessor: #attachments) valueSchema: #CollectionOfAttachments.
			(mapping mapAccessor: #embeds) valueSchema: #CollectionOfEmbeds.
			(mapping mapAccessor: #reactions) valueSchema: #CollectionOfReactions.
			mapping mapAccessor: #nonce.
			mapping mapAccessor: #isPinnedInChannel to: #pinned.
			mapping mapAccessor: #webhookId to: #webhook_id.
			mapping mapAccessor: #type ].
	self 
		userMappingFor: aNeoJSONMapper;
		dateAndTimeMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper;
		collectionOfAttachmentsMappingFor: aNeoJSONMapper;
		collectionOfEmbedsMappingFor: aNeoJSONMapper;
		collectionOfReactionsMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> overwriteMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSOverwrite do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping mapAccessor: #type).
			(mapping mapAccessor: #allow).
			(mapping mapAccessor: #deny) ].
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> presenceUpdateMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSPresenceUpdate
		do: [ :mapping | 
			(mapping mapAccessor: #user) valueSchema: DSUser.
			mapping mapAccessor: #roleIds to: #roles.
			(mapping mapAccessor: #game) valueSchema: DSGame.
			mapping mapAccessor: #guildId to: #guild_id.
			(mapping mapAccessor: #status) valueSchema: DSConnectionStatus ].
	self 
		userMappingFor: aNeoJSONMapper;
		gameMappingFor: aNeoJSONMapper;
		connectionStatusMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> reactionMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSReaction do: [ :mapping |
	      mapping mapAccessor: #count.
	      mapping mapAccessor: #me.
	      (mapping mapAccessor: #emoji) valueSchema: DSEmoji ].
	self emojiMappingFor: aNeoJSONMapper.
]

{ #category : 'public' }
DSModelJsonMapping class >> read: jsonSchema withMapping: messageSymbol on: aReadStream [ 
	"Read a JSON string using json schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	| reader |
	reader := (NeoJSONReader on: aReadStream).
	self perform: messageSymbol with: reader.
	^ reader nextAs: jsonSchema
]

{ #category : 'public' }
DSModelJsonMapping class >> readMessages: aJSON [
	^ self read: #CollectionOfMessages withMapping: #collectionOfMessagesMappingFor: on: aJSON readStream
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> recipientMappingFor: aNeoJSONMapper [ 
	aNeoJSONMapper
		for: DSUser do: [ :mapping |
	      mapping mapAccessor: #id to: #recipient_id ].
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> roleMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSRole do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #name.
	      (mapping mapAccessor: #color) valueSchema: Color.
			mapping mapAccessor: #hoist.
			mapping mapAccessor: #position.
			mapping mapAccessor: #permissions.
			mapping mapAccessor: #managed.
			mapping mapAccessor: #mentionable ].
	self colorMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> specifiedChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: #SpecifiedChannel customDo: [ :mapping |
			mapping reader: [ :jsonReader | | unspecifiedChannel |
				unspecifiedChannel := jsonReader nextAs: DSUnspecifiedChannel.
				unspecifiedChannel asSpecifiedChannel ].
			mapping writer: [ :jsonWriter :anObject |
				jsonWriter nextPut: anObject ] ].
	self 
		unspecifiedChannelMappingFor: aNeoJSONMapper;
		guildTextChannelMappingFor: aNeoJSONMapper;
		guildVoiceChannelMappingFor: aNeoJSONMapper;
		guildDMChannelMappingFor: aNeoJSONMapper;
		guildDMGroupChannelMappingFor: aNeoJSONMapper;
		guildCategoryChannelMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - channel' }
DSModelJsonMapping class >> unspecifiedChannelMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSUnspecifiedChannel do: [ :mapping |
	      (mapping mapAccessor: #id).
			(mapping mapAccessor: #type) valueSchema: DSChannelType.
			(mapping mapAccessor: #guildId to: #guild_id).
			(mapping mapAccessor: #position).			
			(mapping mapAccessor: #permissionOverwrites to: #permission_overwrites) 
				valueSchema: #CollectionOfOverwrites.
			(mapping mapAccessor: #name).
			(mapping mapAccessor: #topic).
			(mapping mapAccessor: #nsfw).
			(mapping mapAccessor: #lastMessageId to: #last_message_id).
			(mapping mapAccessor: #bitrate).
			(mapping mapAccessor: #userLimit to: #user_limit).
			(mapping mapAccessor: #recipients) valueSchema: #CollectionOfUsers.
			(mapping mapAccessor: #icon).
			(mapping mapAccessor: #ownerId to: #owner_id).
			(mapping mapAccessor: #applicationId to: #application_id).
			(mapping mapAccessor: #parentId to: #parent_id) ].
	self 
		channelTypeMappingFor: aNeoJSONMapper;
		collectionOfOverwritesMappingFor: aNeoJSONMapper;
		collectionOfUsersMappingFor: aNeoJSONMapper.
]

{ #category : 'mapping - basic' }
DSModelJsonMapping class >> urlMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: ZnUrl customDo: [ :mapping |
			mapping 
				encoder: [ :aZnUrl | aZnUrl asString ];
				decoder: [ :aStringOrNil | 
					aStringOrNil ifNotNil: [ :aString | aString asZnUrl ] ] ]
]

{ #category : 'mapping - message' }
DSModelJsonMapping class >> userMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSUser do: [ :mapping |
	      mapping mapAccessor: #id.
	      mapping mapAccessor: #username.
	      mapping mapAccessor: #discriminator.
	      mapping mapAccessor: #avatarHash to: #avatar.
	      mapping mapAccessor: #isBot to: #bot.
			mapping mapAccessor: #isMfaEnabled to: #mfa_enabled.
			mapping mapAccessor: #isVerified to: #verified.
			mapping mapAccessor: #email ].
]

{ #category : 'mapping - guild' }
DSModelJsonMapping class >> voiceStateMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DSVoiceState
		do: [ :mapping | 
			mapping mapAccessor: #guildId to: #guild_id.
			mapping mapAccessor: #channelId to: #channel_id.
			mapping mapAccessor: #userId to: #user_id.
			mapping mapAccessor: #sessionId to: #session_id.
			mapping mapAccessor: #deaf.
			mapping mapAccessor: #mute.
			mapping mapAccessor: #selfDeaf to: #self_deaf.
			mapping mapAccessor: #selfMute to: #self_mute.
			mapping mapAccessor: #suppress ]
]

{ #category : 'public' }
DSModelJsonMapping class >> write: aDSObject as: schema mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			prettyPrint: false;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: aDSObject as: schema ].
]

{ #category : 'public' }
DSModelJsonMapping class >> write: aDSObject mappedTo: mappingSymbol [ 
	"Return a JSON string representation of the Discord object."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			prettyPrint: false;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: aDSObject ].
]

{ #category : 'public' }
DSModelJsonMapping class >> writeMessages: aDSMessages [
	^ self write: aDSMessages mappedTo: #collectionOfMessagesMappingFor:
]
