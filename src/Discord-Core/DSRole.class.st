"
I represent a Discord Role Object.

See https://discordapp.com/developers/docs/topics/permissions#role-object

Roles represent a set of permissions attached to a group of users. Roles have unique names, colors, and can be ""pinned"" to the side bar, causing their members to be listed separately. Roles are unique per guild, and can have separate permission profiles for the global context (guild) and channel context.

id	snowflake	role id
name	string	role name
color	integer	integer representation of hexadecimal color code
hoist	bool	if this role is pinned in the user listing
position	integer	position of this role
permissions	integer	permission bit set
managed	bool	whether this role is managed by an integration
mentionable	bool	whether this role is mentionable
		
Roles without colors (color == 0) do not count towards the final computed color in the user list.

"
Class {
	#name : #DSRole,
	#superclass : #DSObject,
	#instVars : [
		'id',
		'name',
		'color',
		'hoist',
		'position',
		'permissions',
		'managed',
		'mentionable'
	],
	#category : 'Discord-Core-Model'
}

{ #category : #accessing }
DSRole >> color [
	^ color
]

{ #category : #accessing }
DSRole >> color: anObject [
	color := anObject
]

{ #category : #accessing }
DSRole >> hoist [
	^ hoist
]

{ #category : #accessing }
DSRole >> hoist: anObject [
	hoist := anObject
]

{ #category : #accessing }
DSRole >> id [
	^ id
]

{ #category : #accessing }
DSRole >> id: anObject [
	id := anObject
]

{ #category : #accessing }
DSRole >> managed [
	^ managed
]

{ #category : #accessing }
DSRole >> managed: anObject [
	managed := anObject
]

{ #category : #accessing }
DSRole >> mentionable [
	^ mentionable
]

{ #category : #accessing }
DSRole >> mentionable: anObject [
	mentionable := anObject
]

{ #category : #accessing }
DSRole >> name [
	^ name
]

{ #category : #accessing }
DSRole >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DSRole >> permissions [
	^ permissions
]

{ #category : #accessing }
DSRole >> permissions: anObject [
	permissions := anObject
]

{ #category : #accessing }
DSRole >> position [
	^ position
]

{ #category : #accessing }
DSRole >> position: anObject [
	position := anObject
]
