Class {
	#name : #GAFUser,
	#superclass : #GafObject,
	#instVars : [
		'email',
		'fullname',
		'farms',
		'hashedPassword',
		'isAdmin',
		'isExpert',
		'enabled',
		'lastConnectedDateAndTime'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
GAFUser class >> email: anEmail fullname: aFullName [
	^ GAFUser new
		email: anEmail;
		fullname: aFullName;
		yourself
]

{ #category : #testing }
GAFUser class >> isVoyageRoot [
	^ true
]

{ #category : #testing }
GAFUser class >> voyageCollectionName [
   ^ 'GAFUser'
]

{ #category : #accessing }
GAFUser >> addFarm: aFarm [
	farms add: aFarm 
]

{ #category : #accessing }
GAFUser >> email [
	^ email
]

{ #category : #accessing }
GAFUser >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GAFUser >> enabled [
	^ enabled ifNil: [ ^ true ]
]

{ #category : #accessing }
GAFUser >> enabled: anObject [
	enabled := anObject
]

{ #category : #accessing }
GAFUser >> farms [
	^ farms
]

{ #category : #accessing }
GAFUser >> fullname [
	^ fullname
]

{ #category : #accessing }
GAFUser >> fullname: anObject [
	fullname := anObject
]

{ #category : #accessing }
GAFUser >> hashedPassword [
	^ hashedPassword
]

{ #category : #accessing }
GAFUser >> hashedPassword: anObject [
	hashedPassword := anObject
]

{ #category : #initialization }
GAFUser >> initialize [
	super initialize.
	farms := OrderedCollection new.
	isAdmin := false.
	isExpert := false
]

{ #category : #testing }
GAFUser >> isAdmin [
	^ isAdmin
]

{ #category : #accessing }
GAFUser >> isAdmin: anObject [
	isAdmin := anObject
]

{ #category : #testing }
GAFUser >> isExpert [
	^ isExpert
]

{ #category : #accessing }
GAFUser >> isExpert: anObject [
	isExpert := anObject
]

{ #category : #passwords }
GAFUser >> isValidPassword: aHashedPassword [
	^ aHashedPassword = hashedPassword
]

{ #category : #accessing }
GAFUser >> lastConnectedDateAndTime [
	^ lastConnectedDateAndTime
]

{ #category : #accessing }
GAFUser >> lastConnectedDateAndTime: anObject [
	lastConnectedDateAndTime := anObject
]
