Class {
	#name : #SaleEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'dateEditorComponent',
		'clientEditorComponent',
		'listComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
SaleEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {dateEditorComponent.
	clientEditorComponent.
	listComponent} , super children
]

{ #category : #initialization }
SaleEditor >> initializeClientEditorComponent [
	clientEditorComponent := TextLinePropertyEditorComponent
		id: 'client'
		subject: subject
		selector: #client
		label: 'Cliente'
		required: true
]

{ #category : #initialization }
SaleEditor >> initializeComponents [
	"Initialize all property components"

	super initializeComponents.
	self initializeDateEditorComponent.
	self initializeClientEditorComponent.
	self initializeListComponent
]

{ #category : #initialization }
SaleEditor >> initializeDateEditorComponent [
	dateEditorComponent := DatePropertyEditorComponent
		id: 'date'
		subject: subject
		selector: #date
		label: 'Fecha'
		required: true
]

{ #category : #initialization }
SaleEditor >> initializeListComponent [
	listComponent := SaleListItemEditor new
		sale: subject;
		yourself
]
