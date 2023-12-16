Class {
	#name : #PersistentConfiguration,
	#superclass : #Object,
	#instVars : [
		'blockNewUsers',
		'smtpServer',
		'replyToEmail',
		'superAdminEmail',
		'telegramToken'
	],
	#category : #'GapAFarm-ui-admin'
}

{ #category : #voyage }
PersistentConfiguration class >> isVoyageRoot [
	^ true
]

{ #category : #accessing }
PersistentConfiguration >> blockNewUsers [
	^ blockNewUsers
]

{ #category : #accessing }
PersistentConfiguration >> blockNewUsers: anObject [
	blockNewUsers := anObject
]

{ #category : #initialization }
PersistentConfiguration >> initialize [
	super initialize.
	blockNewUsers := true
]

{ #category : #accessing }
PersistentConfiguration >> replyToEmail [
	^ replyToEmail
]

{ #category : #accessing }
PersistentConfiguration >> replyToEmail: anObject [
	replyToEmail := anObject
]

{ #category : #accessing }
PersistentConfiguration >> smtpServer [
	^ smtpServer
]

{ #category : #accessing }
PersistentConfiguration >> smtpServer: anObject [
	smtpServer := anObject
]

{ #category : #accessing }
PersistentConfiguration >> superAdminEmail [
	^ superAdminEmail
]

{ #category : #accessing }
PersistentConfiguration >> superAdminEmail: anObject [
	superAdminEmail := anObject
]

{ #category : #accessing }
PersistentConfiguration >> telegramToken [

	^ telegramToken
]

{ #category : #accessing }
PersistentConfiguration >> telegramToken: anObject [

	telegramToken := anObject
]
