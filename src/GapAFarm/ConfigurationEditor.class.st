Class {
	#name : #ConfigurationEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'smtpServerComponent',
		'replyToEmailComponent',
		'blockNewUsersComponent',
		'superAdminComponent'
	],
	#category : #'GapAFarm-ui-admin'
}

{ #category : #initialization }
ConfigurationEditor >> accept [
	self children do: #accept.
	subject save
]

{ #category : #initialization }
ConfigurationEditor >> cancel [
	self children do: #cancel
]

{ #category : #initialization }
ConfigurationEditor >> children [
	^ {blockNewUsersComponent.
	smtpServerComponent.
	replyToEmailComponent.
	superAdminComponent}
]

{ #category : #initialization }
ConfigurationEditor >> initializeBlockNewUsersComponent [
	blockNewUsersComponent := DropdownSelectPropertyEditorComponent
		id: 'blockNewUsers'
		subject: self session persistentConfiguration
		selector: #blockNewUsers
		label: 'Bloquar a los usuarios nuevos'
		required: true.
	blockNewUsersComponent
		possibleValuesBlock: [ {true . false} ];
		instructions:
			'Si se configura en true, los usuarios que se registren quedarán bloqueados hasta que el administrador los desbloquee'
]

{ #category : #initialization }
ConfigurationEditor >> initializeComponents [
	"Initialize all property components"

	self initializeBlockNewUsersComponent.
	self initializeSmtpServerComponent.
	self initializeReplyToEmailComponent.
	self initializeSuperAdminEmailComponent .
]

{ #category : #initialization }
ConfigurationEditor >> initializeReplyToEmailComponent [
	replyToEmailComponent := TextLinePropertyEditorComponent
		id: 'replyToEmail'
		subject: subject
		selector: #replyToEmail
		label: 'Dirección de remitente para los correos salientes'
		required: false
]

{ #category : #initialization }
ConfigurationEditor >> initializeSmtpServerComponent [
	smtpServerComponent := TextLinePropertyEditorComponent
		id: 'smtpServerComponent'
		subject: subject
		selector: #smtpServer
		label: 'IP del servidor de SMTP para correos salientes'
		required: false
]

{ #category : #initialization }
ConfigurationEditor >> initializeSuperAdminEmailComponent [
	superAdminComponent := TextLinePropertyEditorComponent
		id: 'superAdminEmail'
		subject: subject
		selector: #superAdminEmail
		label: 'Dirección de mail a considerar como administrador principal'
		required: false
]

{ #category : #rendering }
ConfigurationEditor >> renderContentOn: html [
	html container
		style: 'padding-top: 20px';
		with: [ super renderContentOn: html ]
]
