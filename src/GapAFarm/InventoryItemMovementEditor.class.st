Class {
	#name : #InventoryItemMovementEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'quantityEditorComponent',
		'dateEditorComponent',
		'reasonEditorComponent',
		'substance'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'instance creation' }
InventoryItemMovementEditor class >> subject: aSubject [
	self error: 'Use #subject:substance: instead'
]

{ #category : #'instance creation' }
InventoryItemMovementEditor class >> subject: anInventoryRecord substance: aSubstance [
	^ self new
		substance: aSubstance;
		subject: anInventoryRecord;
		yourself
]

{ #category : #'subclass-responsibility' }
InventoryItemMovementEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {dateEditorComponent. reasonEditorComponent.
		quantityEditorComponent.
		}, 
		super children
]

{ #category : #initialization }
InventoryItemMovementEditor >> initializeComponents [
	"Initialize all property components"

	self initializeDateEditorComponent.
	self initializeReadonEditorComponent.
	self initializeQuantityEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
InventoryItemMovementEditor >> initializeDateEditorComponent [
	dateEditorComponent := DatePropertyEditorComponent
		id: 'date'
		subject: subject
		selector: #date
		label: 'Fecha'
		required: true
]

{ #category : #initialization }
InventoryItemMovementEditor >> initializeQuantityEditorComponent [
	quantityEditorComponent := NumberPropertyEditorComponent
		id: 'quantity'
		subject: subject
		selector: #quantity
		label: 'Cantidad (' , substance unit , ')'
		required: true.
	quantityEditorComponent
		instructions: 'Utilice números negativos para indicar egresos.'
]

{ #category : #initialization }
InventoryItemMovementEditor >> initializeReadonEditorComponent [
	reasonEditorComponent := TextLinePropertyEditorComponent
		id: 'reason'
		subject: subject
		selector: #reason
		label: 'Fuente/Destino'
		required: true.
	reasonEditorComponent
		instructions:
			'Si aumenta el stock, indice la fuente; si disminuye indique el destino.'
]

{ #category : #accessing }
InventoryItemMovementEditor >> substance: anObject [
	substance := anObject
]
