"
I represent Discord API version 6.
"
Class {
	#name : 'DSRestApiSix',
	#superclass : 'DSRestApi',
	#instVars : [
		'apiUrl',
		'authentication'
	],
	#category : 'Discord-Client-REST-Api',
	#package : 'Discord-Client',
	#tag : 'REST-Api'
}

{ #category : 'initialization' }
DSRestApiSix class >> initialize [
	self initializeHTTPStatusCodes.
	
]

{ #category : 'initialization' }
DSRestApiSix class >> initializeHTTPStatusCodes [
	<script>
	"ZnStatusLine code: 200"
	ZnConstants httpStatusCodes
		at: 429 put: 'Too Many Requests';
		yourself.
		
]

{ #category : 'accessing' }
DSRestApiSix class >> versionNumber [
	^ 6
]

{ #category : 'accessing' }
DSRestApiSix >> apiUrl [
	"Return root URL used for Discord communication."
	^ apiUrl ifNil: [ apiUrl := DSConstants defaultRestApiSixUrl ]
]

{ #category : 'accessing' }
DSRestApiSix >> apiUrl: anObject [
	apiUrl := anObject
]

{ #category : 'defaults - url' }
DSRestApiSix >> avatarsUrl [
	"Return Discord's Avatars URL."
	^ 'https://cdn.discordapp.com/avatars' asZnUrl
]

{ #category : 'initialization-release' }
DSRestApiSix >> beBot [
	authentication := DSBotAuthentication new.
]

{ #category : 'defaults - url' }
DSRestApiSix >> channelMessageUrlForId: messageId andChannelId: channelIdString [ 
	"Get a URL to return a specific message in the channel. 
	If operating on a guild channel, this endpoints requires the 'READ_MESSAGE_HISTORY' 
	permission to be present on the current user. Returns a message object on success.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-message"
	^ (self channelMessagesUrlForId: channelIdString) / messageId asString
]

{ #category : 'defaults - url' }
DSRestApiSix >> channelMessagesUrlForId: channelIdString [ 
	"Get a URL to get messages of an existing channel, or
	send a message to the particular text Guild or DM channel.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-messages
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	^ self channelsUrl / channelIdString asString / 'messages'
]

{ #category : 'defaults - url' }
DSRestApiSix >> channelsUrl [
	"Get a channels URL"
	^ self apiUrl / 'channels'
]

{ #category : 'public - user' }
DSRestApiSix >> directChannels [
	"Return collection of dirrect channels.
	See https://discordapp.com/developers/docs/resources/user#get-user-dms"
	<return: #DSChannels of: #DSDirectMessageChannel>
	| response |
	response := self newZnClientAuthenticated
		url: self usersMeChannelsUrl;
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | channels |
			channels := DSModelJsonMapping 
				read: #CollectionOfSortedChannels 
				withMapping: #collectionOfSortedChannelsMappingFor:
				on: response contents readStream.
			channels do: [ :eachChannel | eachChannel restApi: self ].
			channels ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
	
]

{ #category : 'public - user' }
DSRestApiSix >> directMessageWith: aDSUser [ 
	| response entity |
	entity := ZnEntity text: (self class jsonMappingClass
		write: aDSUser mappedTo: #recipientMappingFor:).
	entity contentType: ZnMimeType applicationJson.
	response := self newZnClientAuthenticated
		url: self usersMeChannelsUrl;
		entity: entity;
		post;
		response.
	^ response isSuccess 
		ifTrue: [ | channel |
			channel := DSModelJsonMapping 
				read: DSDirectMessageChannel 
				withMapping: #guildDMChannelMappingFor:
				on: response contents readStream.
			channel restApi: self.
			channel ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
	
]

{ #category : 'private' }
DSRestApiSix >> doTwoFactorAuthenticationRequest: aZnResponse ticket: ticketString [ 
	| code response jsonObject token |
	code := DSTwoFactorNotificationRequiered new
		signal: 'Provide Two-Factor-Authentication Code';
		code.
	response := self newZnClientWithUserAgent 
		url: self apiUrl / 'auth' / 'mfa' / 'totp';
		entity: (ZnEntity text: '{"ticket": "', ticketString asString, '", "code": "', code asString, '"}');
		contentType: ZnMimeType applicationJson;
		post;
		response.
	response isSuccess 
		ifTrue: [ 
			jsonObject := NeoJSONObject fromString: response contents.
			token := jsonObject at: self tokenKey.
			token ifNil: [ 
				self 
					raiseLoginErrorOn: response 
					message: 'Cannot login', String cr, response contents asString ].
			self token: token ]
		ifFalse: [ 
			 self raiseLoginErrorOn: response message: response contents asString ]
]

{ #category : 'public' }
DSRestApiSix >> editMessage: aDSMessage content: aString embed: aDSEmbed [ 
	"Edit a previously sent message. 
	You can only edit messages that have been sent by the current user. 
	Returns a message object. Fires a Message Update Gateway event.
	See https://discordapp.com/developers/docs/resources/channel#edit-message"
	^ self 
		editMessageId: aDSMessage id 
		inChannelId: aDSMessage channelId 
		content: aString 
		embed: aDSEmbed
]

{ #category : 'public' }
DSRestApiSix >> editMessageId: messageId inChannelId: channelId content: contentString embed: embedObject [
	"Edit a previously sent message. 
	You can only edit messages that have been sent by the current user. 
	Returns a message object. Fires a Message Update Gateway event.
	See https://discordapp.com/developers/docs/resources/channel#edit-message"
	| response url |
	url := self channelMessageUrlForId: messageId andChannelId: channelId.
	response := self newZnClientAuthenticated
		url: url;
		entity: (ZnEntity text: (self editMessagePayloadForContent: contentString embed: embedObject));
		contentType: ZnMimeType applicationJson;
		patch;
		response.
	^ response isSuccess
		ifTrue: [ self parseMessage: response ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'json - conversions' }
DSRestApiSix >> editMessagePayloadForContent: contentString embed: aDSEmbed [ 
	"Return a JSON string that represents Edit Message payload.
	See https://discordapp.com/developers/docs/resources/channel#edit-message"
	| dictionary |
	dictionary := NeoJSONObject new
		at: 'content' put: contentString;
		at: 'embed' put: aDSEmbed;
		yourself.
	^ DSModelJsonMapping write: dictionary mappedTo: #editMessagePayloadMappingFor:
]

{ #category : 'json - conversions' }
DSRestApiSix >> emailAndPasswordJson [
	"Return JSON string with email and password.
	It represents a JSON format used for login."
	^ DSModelJsonMapping 
		write: self session mappedTo: #clientSessionEmailAndPasswordMappingFor:
]

{ #category : 'public accessing' }
DSRestApiSix >> guildChannelsOf: aDSUserGuild [
	"Return Guild Channel objects.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
	^ (self guildChannelsUsingId: aDSUserGuild id)
]

{ #category : 'defaults - url' }
DSRestApiSix >> guildChannelsUrlForId: snowflake [ 
	"Return Discord API URL to ask for guild channels.
	snowflake is an Guild Id.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
	^ self guildsUrl / snowflake asString / 'channels'
]

{ #category : 'public accessing' }
DSRestApiSix >> guildChannelsUsingId: guildId [
	"Returns a list of guild channel objects.
	See https://discordapp.com/developers/docs/resources/guild#get-guild-channels"
	| response |
	response := (self newZnClientAuthenticated)
		url: (self guildChannelsUrlForId: guildId);
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | channels |
			channels := DSModelJsonMapping 
				read: #CollectionOfSortedChannels 
				withMapping: #collectionOfSortedChannelsMappingFor:
				on: response contents readStream.
			channels do: [ :eachChannel | eachChannel restApi: self ].
			channels ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'defaults - url' }
DSRestApiSix >> guildMembersUrlForId: snowflake [
	"Return Discord API URL to ask for list of guild members.
	snowflake is a Guild Id.
	See https://discordapp.com/developers/docs/resources/guild#list-guild-members" 
	^ self guildsUrl / snowflake asString / 'members'
]

{ #category : 'defaults - url' }
DSRestApiSix >> guildsUrl [
	"Return a root Discord Guilds URL to perform opperation and questions about Guild(s),
	e.g., ask for existing channels."
	^ self apiUrl / 'guilds'
]

{ #category : 'initialization' }
DSRestApiSix >> initialize [
	super initialize.
	authentication := DSUserAuthentication new.
]

{ #category : 'public' }
DSRestApiSix >> listGuildMembersOfGuildId: guildId [
	"Returns a list of guild member objects that are members of the guild.
	See https://discordapp.com/developers/docs/resources/guild#list-guild-members"

	| params |
	params := Dictionary new
		at: 'limit' put: 1000 asString; 
		yourself.

	^ self listGuildMembersOfGuildId: guildId queryParams: params
]

{ #category : 'private - communication' }
DSRestApiSix >> listGuildMembersOfGuildId: guildId queryParams: associations [
	"Returns a list of guild member objects that are members of the guild.
	See https://discordapp.com/developers/docs/resources/guild#list-guild-members
	
	Field	Type	Description	Default
	limit	integer	max number of members to return (1-1000)	1
	after	snowflake	the highest user id in the previous page	0
	"

	| response url |
	url := self guildMembersUrlForId: guildId.
	url queryAddAll: associations.
	response := self newZnClientAuthenticated
		url: url;
		get;
		response.
	^ response isSuccess
		ifTrue: [ self parseGuildMembers: response ]
		ifFalse: [ DSUnauthorizedOperationError new
				response: response;
				signal: response contents ]
]

{ #category : 'public' }
DSRestApiSix >> login [
	| response |
	self resetCache.
	response := self newZnClientWithUserAgent
		url: self loginAuthUrl;
		entity: (ZnEntity text: self emailAndPasswordJson);
		contentType: ZnMimeType applicationJson;
		post;
		response.
	response isSuccess 
		ifTrue: [ self processLoginResponse: response ]
		ifFalse: [ DSCannotLoginError new 
			response: response;
			signal: response contents ]
]

{ #category : 'defaults - url' }
DSRestApiSix >> loginAuthUrl [
	"Return authentication URL to login with email and password."
	^ self apiUrl / 'auth' / 'login'
]

{ #category : 'public' }
DSRestApiSix >> logout [
	| response |
	response := self newZnClientAuthenticated
		url: self logoutAuthUrl;
		entity: (ZnEntity text: self tokenJson);
		contentType: ZnMimeType applicationJson;
		post;
		response.
	response isSuccess
		ifTrue: [ self session resetToken. ]
		ifFalse: [ DSUnauthorizedOperationError new 
			response: response;
			signal: response contents ].
	

]

{ #category : 'defaults - url' }
DSRestApiSix >> logoutAuthUrl [
	"Return authentication URL to logout from Discord."
	^ self apiUrl / 'auth' / 'logout'
]

{ #category : 'public - user' }
DSRestApiSix >> me [
	"Return User object that identyfies the logged user.
	See https://discordapp.com/developers/docs/resources/user#user-object"
	^ self 
		cacheAt: 'me'
		ifAbsentPut: [ self newMeUser ]
]

{ #category : 'public' }
DSRestApiSix >> meGuilds [
	"Returns a list of user guild objects the current user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	^ self 
		cacheAt: 'meGuilds'
		ifAbsentPut: [ self newMeGuilds ]
]

{ #category : 'public - channel' }
DSRestApiSix >> messageBuilder [
	^ DSClientPostBuilder new
		restApi: self;
		yourself
]

{ #category : 'public accessing' }
DSRestApiSix >> messageForId: messageId inChannelId: channelId [
	"Return DSMessage object of a specific id in the specific channel id."

	| url response |
	url := self channelMessageUrlForId: messageId andChannelId: channelId.
	response := self newZnClientAuthenticated
		url: url;
		get;
		response.
	^ response isSuccess
		ifTrue:
			[ self parseMessage: response ]
		ifFalse: [ DSUnauthorizedOperationError new
				response: response;
				signal: response contents ]
]

{ #category : 'public - channel' }
DSRestApiSix >> messagesAfter: aDSMessage inChannel: aDSGuildTextChannel [ 
	<return: #DSMessages of: #DSMessage>
	| queryParams |
	queryParams := Dictionary new
		at: 'after' put: aDSMessage id; 
		yourself.
	^ self messagesForChannelId: aDSGuildTextChannel id queryParams: queryParams
]

{ #category : 'public - channel' }
DSRestApiSix >> messagesBefore: aDSMessage inChannel: aDSGuildTextChannel [ 
	<return: #DSMessages of: #DSMessage>
	| queryParams |
	queryParams := Dictionary new
		at: 'before' put: aDSMessage id; 
		yourself.
	^ self messagesForChannelId: aDSGuildTextChannel id queryParams: queryParams
]

{ #category : 'public - channel' }
DSRestApiSix >> messagesForChannel: aChannel [ 
	"Returns the messages for a channel. If operating on a guild channel, 
	this endpoint requires the 'READ_MESSAGES' permission to be present on the current user. 
	Returns an array of message objects on success.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-messages"
	^ self messagesForChannelId: aChannel id
]

{ #category : 'private - communication' }
DSRestApiSix >> messagesForChannelId: channelId [ 
	"Returns the messages for a channel. If operating on a guild channel, 
	this endpoint requires the 'READ_MESSAGES' permission to be present on the current user. 
	Returns an array of message objects on success.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-messages"
	| url response |
	url := self channelMessagesUrlForId: channelId.
	response := (self newZnClientAuthenticated)
		url: url;
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | messages |
			messages := DSModelJsonMapping 
				read: #CollectionOfMessages 
				withMapping: #collectionOfMessagesMappingFor:
				on: response contents readStream.
			messages do: [ :eachMessage | eachMessage restApi: self ].
			messages ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'private - communication' }
DSRestApiSix >> messagesForChannelId: channelId queryParams: associations [
	<return: #DSMessages of: #DSMessage>
	"Returns the messages for a channel. If operating on a guild channel, 
	this endpoint requires the 'READ_MESSAGES' permission to be present on the current user. 
	Returns an array of message objects on success.
	associations can include:
		around -> snowflake message id
		before -> snowflake message id
		after  -> snowflake message id
		limit  -> integer representing max number of messages to return (1-100, default 50)
		around, before, after are mutually exclusive.
	See https://discordapp.com/developers/docs/resources/channel#get-channel-messages"
	| url response |
	url := self channelMessagesUrlForId: channelId.
	url queryAddAll: associations.
	response := (self newZnClientAuthenticated)
		url: url;
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | messages |
			messages := DSModelJsonMapping 
				read: #CollectionOfMessages 
				withMapping: #collectionOfMessagesMappingFor:
				on: response contents readStream.
			messages do: [ :eachMessage | eachMessage restApi: self ].
			messages ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'instance creation' }
DSRestApiSix >> newMeGuilds [
	"Returns a list of user guild objects the current user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	| response |
	response := (self newZnClientAuthenticated)
		url: self usersMeGuildsUrl;
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | guilds |
			guilds := DSModelJsonMapping 
				read: #CollectionOfGuilds 
				withMapping: #collectionOfGuildsMappingFor:
				on: response contents readStream.
			guilds do: [ :eachGuild | eachGuild restApi: self ].
			guilds ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'instance creation' }
DSRestApiSix >> newMeUser [
	"Return User object that represent the authenticated user"
	| response |
	response := (self newZnClientAuthenticated)
		url: self usersMeUrl;
		get;
		response.
	^ response isSuccess 
		ifTrue: [ | user |
			user := DSModelJsonMapping 
				read: DSUser
				withMapping: #userMappingFor:
				on: response contents readStream.
			user restApi: self.
			^ user ]
		ifFalse: [ DSUnauthorizedOperationError new
			response: response;
			signal: response contents ]
]

{ #category : 'instance creation' }
DSRestApiSix >> newZnClientAuthenticated [
	self session isAuthenticated ifFalse: [ 
		DSTokenRequiredError signal: 'Cannot authorize the client.' ].
	^ authentication accept: self
]

{ #category : 'instance creation' }
DSRestApiSix >> newZnClientWithUserAgent [
	"Return new object with correct User Agent.
	See https://discordapp.com/developers/docs/reference#user-agent"
	^ DSUtility newZnClientWithUserAgent
]

{ #category : 'private - parsing' }
DSRestApiSix >> parseGuildMembers: response [
	| members |
	members := DSModelJsonMapping
		read: #CollectionOfGuildMembers
		withMapping: #collectionOfGuildMembersMappingFor:
		on: response contents readStream.
	members do: [ :eachMember | eachMember user restApi: self ].
	^ members
]

{ #category : 'private - parsing' }
DSRestApiSix >> parseMessage: response [
	| message |
	message := DSModelJsonMapping
		read: DSMessage
		withMapping: #messageMappingFor:
		on: response contents readStream.
	message restApi: self.
	^ message
]

{ #category : 'defaults - json' }
DSRestApiSix >> passwordKey [
	"Return Dictionary key name that holds password message on unsuccessfull login."
	^ 'password'
]

{ #category : 'private' }
DSRestApiSix >> processLoginResponse: aZnResponse [ 
	"Login may require a Two-Factor-Authentication"
	 | jsonObject token mfa ticket |
	jsonObject := NeoJSONObject fromString: aZnResponse contents.
	mfa := jsonObject at: 'mfa'.
	token := jsonObject at: self tokenKey.
	token 
		ifNil: [ 
			mfa 
				ifTrue: [ 
					ticket := jsonObject at: 'ticket'.	
					self doTwoFactorAuthenticationRequest: aZnResponse ticket: ticket ]
				ifFalse: [ self raiseLoginErrorOn: aZnResponse message: 'Cannot login' ]
			 ]
		ifNotNil: [ self token: (jsonObject at: self tokenKey) ]
]

{ #category : 'private' }
DSRestApiSix >> raiseLoginErrorOn: aZnResponse message: aString [ 
	DSCannotLoginError new 
		response: aZnResponse;
		signal: aString
]

{ #category : 'public - channel' }
DSRestApiSix >> sendMessage: aDSClientPost answering: aDSMessage signalProgress: aBoolean [ 
	"Send a message to the same text Guild or DM channel as given aDSMessage.
	See https://discordapp.com/developers/docs/resources/channel#create-message"
	<return: #DSMessage>
	^ self sendMessage: aDSClientPost toGuildTextOrDMChannelId: aDSMessage channelId signalProgress: aBoolean
]

{ #category : 'public - channel' }
DSRestApiSix >> sendMessage: aDSClientPost toChannel: aDSChannel signalProgress: aBoolean [ 
	^ self sendMessage: aDSClientPost toGuildTextOrDMChannelId: aDSChannel id signalProgress: aBoolean
]

{ #category : 'private - communication' }
DSRestApiSix >> sendMessage: aDSClientJsonPost toGuildTextOrDMChannelId: channelId signalProgress: aBoolean [
	"Send a message to the particular text Guild or DM channel.
	See https://discordapp.com/developers/docs/resources/channel#create-message"

	| response url entity |
	url := self channelMessagesUrlForId: channelId.
	entity := DSPostToEntityCommand new
		post: aDSClientJsonPost;
		execute;
		entity.
	response := self newZnClientAuthenticated
		url: url;
		signalProgress: aBoolean;
		entity: entity;
		post;
		response.
	^ response isSuccess
		ifTrue: [ self parseMessage: response ]
		ifFalse: [ DSUnauthorizedOperationError new
				response: response;
				signal: response contents ]
]

{ #category : 'json - conversions' }
DSRestApiSix >> toJsonObject: aString [ 
	"Convert string to a JSON object."
	<return: #NeoJSONObject>
	^ NeoJSONObject fromString: aString
]

{ #category : 'json - conversions' }
DSRestApiSix >> tokenJson [
	"Return JSON string with token.
	It represents a JSON format used for logout."
	^ DSModelJsonMapping
		write: self session mappedTo: #clientSessionTokenMappingFor:	
]

{ #category : 'defaults - json' }
DSRestApiSix >> tokenKey [
	"Return dictionary key name that holds token on successfull login."
	^ 'token'
]

{ #category : 'defaults - url' }
DSRestApiSix >> userAvatarFormat: aDSUser [ 
	"Return avatar's format (GIF or Webp)"
	^ (aDSUser avatarHash beginsWith: 'a_')
			ifTrue: [ aDSUser avatarHash asString, '.gif' ]
			ifFalse: [ aDSUser avatarHash asString, '.webp' ]
]

{ #category : 'public' }
DSRestApiSix >> userAvatarUrl: aDSUser [ 
	"Return a user's avatar URL. 
	Return nil if the user has no avatar."
	aDSUser hasAvatar ifFalse: [ ^ nil ].
	^ self avatarsUrl / aDSUser id asString / (self userAvatarFormat: aDSUser) ? ('size' -> 1024)

]

{ #category : 'defaults - url' }
DSRestApiSix >> usersMeChannelsUrl [
	^ self usersMeUrl / 'channels'
]

{ #category : 'defaults - url' }
DSRestApiSix >> usersMeGuildsUrl [
	"Return Discord API URL to ask for user guilds objects the authenticated user is a member of.
	See https://discordapp.com/developers/docs/resources/user#get-current-user-guilds"
	^ self usersMeUrl / 'guilds'
]

{ #category : 'defaults - url' }
DSRestApiSix >> usersMeUrl [
	"Return Discord API URL to ask for logged user's information."
	^ self apiUrl / 'users'/ '@me'
]

{ #category : 'visiting' }
DSRestApiSix >> visitDSBotAuthentication: aDSBotAuthentication [ 
	^ self newZnClientWithUserAgent 
		headerAt: 'Authorization' put: 'Bot ', self session token asString;
		yourself
]

{ #category : 'visiting' }
DSRestApiSix >> visitDSUserAuthentication: aDSUserAuthentication [
	^ self newZnClientWithUserAgent 
		headerAt: 'Authorization' put: self session token;
		yourself
]
