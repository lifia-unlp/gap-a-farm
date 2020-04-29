Class {
	#name : #FarmEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'nameEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
FarmEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {nameEditorComponent.}, 
		super children
]

{ #category : #initialization }
FarmEditor >> initializeComponents [
	"Initialize all property components"

	self initializeNameEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
FarmEditor >> initializeNameEditorComponent [
	nameEditorComponent := TextLinePropertyEditorComponent
		id: 'name'
		subject: subject
		selector: #name
		label: 'Nombre de Granja'
		required: true
]
