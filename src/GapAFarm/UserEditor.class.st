Class {
	#name : #UserEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'emailEditorComponent',
		'fullnameEditorComponent',
		'telegramIdEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
UserEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {
		  emailEditorComponent.
		  fullnameEditorComponent.
		  telegramIdEditorComponent }
]

{ #category : #'subclass-responsibility' }
UserEditor >> initializeComponents [

	self
		initializeEmailEditorComponent;
		initializeFullnameEditorComponent;
		initializeTelegramIdEditorComponent
]

{ #category : #'subclass-responsibility' }
UserEditor >> initializeEmailEditorComponent [

	emailEditorComponent := TextLinePropertyEditorComponent
		                        id: 'email'
		                        subject: subject
		                        selector: #email
		                        label: 'Email'
		                        required: true
]

{ #category : #'subclass-responsibility' }
UserEditor >> initializeFullnameEditorComponent [

	fullnameEditorComponent  := TextLinePropertyEditorComponent
		                        id: 'fullname'
		                        subject: subject
		                        selector: #fullname
		                        label: 'Nombre completo'
		                        required: true
]

{ #category : #'subclass-responsibility' }
UserEditor >> initializeTelegramIdEditorComponent [

	telegramIdEditorComponent := NumberPropertyEditorComponent
		                             id: 'telegramId'
		                             subject: subject
		                             selector: #telegramId
		                             label: 'ID de telegram'
		                             required: false
]

{ #category : #'subclass-responsibility' }
UserEditor >> renderContentOn: html [

	html container: [ super renderContentOn: html ]
]
