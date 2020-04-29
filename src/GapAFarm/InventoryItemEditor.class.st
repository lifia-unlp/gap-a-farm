Class {
	#name : #InventoryItemEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'substanceEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
InventoryItemEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {substanceEditorComponent} , super children
]

{ #category : #initialization }
InventoryItemEditor >> initializeComponents [
	"Initialize all property components"

	self initializeSubstanceEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
InventoryItemEditor >> initializeSubstanceEditorComponent [
	substanceEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'substance'
		subject: subject
		selector: #substance
		label: 'Substancia'
		required: true.
	substanceEditorComponent
		labelsBlock: [ :substance | 
			substance
				ifNil: [  ]
				ifNotNil: [ substance comercialName , ' (' , substance unit , ')' ] ].
	substanceEditorComponent
		possibleValuesBlock: [ {nil} , self substances ]
]

{ #category : #accessing }
InventoryItemEditor >> substances [
	^ self session gapAFarm substances
		copyWithoutAll: (self session farm inventoryItems collect: #substance)
]
