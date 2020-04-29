Class {
	#name : #InventoryComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #callbacks }
InventoryComponent >> addMovement: anInventoryItem [
	| record |
	record := self
		call:
			(InventoryItemMovementEditor
				subject: InventoryItemMovement new
				substance: anInventoryItem substance).
	record
		ifNotNil: [ :it | 
			anInventoryItem addMovement: it.
			anInventoryItem save ]
]

{ #category : #rendering }
InventoryComponent >> applicabilitiesStringFor: element [
	^ (SenasaCatalogue singleton
		applicabilitiesForSubstance: element substance) asCommaString
]

{ #category : #rendering }
InventoryComponent >> balanceStringFor: element [
	^ element balance asString , ' ' , element substance unit
]

{ #category : #rendering }
InventoryComponent >> columnHeadings [
	^ {'Nombre comercial' . 'Aptitud' . 'Cultivos autorizados'.
	'Disponible'} , super columnHeadings
]

{ #category : #rendering }
InventoryComponent >> columnValuesFor: element [
	^ {element substance comercialName.
	(self applicabilitiesStringFor: element).
	(self registeredCropsStringFor: element).
	(self balanceStringFor: element)} , (super columnValuesFor: element)
]

{ #category : #hooks }
InventoryComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ InventoryItem 
]

{ #category : #hooks }
InventoryComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ InventoryItemEditor
]

{ #category : #accessing }
InventoryComponent >> elements [
	^ self session farm inventoryItems
		asSortedCollection: [ :a :b | a substance comercialName < b substance comercialName ]
]

{ #category : #initialization }
InventoryComponent >> initialize [
	super initialize.
	duplicateEnabled := false.
	editEnabled := false.
	viewEnabled := true
]

{ #category : #rendering }
InventoryComponent >> registeredCropsStringFor: element [
	^ (SenasaCatalogue singleton
		registeredCropNamesForSubstance: element substance) asCommaString
]

{ #category : #rendering }
InventoryComponent >> renderSpecificActionsFor: element on: html [
	html div class: 'dropdown-divider'.
	html anchor
		class: 'dropdown-item';
		callback: [ self addMovement: element ];
		with: 'Registrar movimiento'
]

{ #category : #callbacks }
InventoryComponent >> saveAddedElement: anInventoryItem [
	super saveAddedElement: anInventoryItem.
	self session farm addInventoryItem: anInventoryItem.
	self session farm save
]

{ #category : #callbacks }
InventoryComponent >> viewElement: element [
	^self call: (InventoryItemsViewerComponent item: element)
]
