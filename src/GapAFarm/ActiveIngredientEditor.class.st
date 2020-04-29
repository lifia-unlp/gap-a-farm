Class {
	#name : #ActiveIngredientEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'tradeNameEditorComponent',
		'referenceUrlEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
ActiveIngredientEditor >> allowedNames [
	| ingredientTradeNamesForExistingCrops |
	ingredientTradeNamesForExistingCrops := (self session gapAFarm crops
		collect: #vulgarName)
		flatCollect: [ :cropVulgarName | 
			SenasaCatalogue singleton
				registeredIngredientsForCropNamed: cropVulgarName ]
		as: Set.
	^ {nil}
		,
			(ingredientTradeNamesForExistingCrops
				copyWithoutAll: (self session gapAFarm activeIngredients collect: #tradeName))
				asSortedCollection
]

{ #category : #'subclass-responsibility' }
ActiveIngredientEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {tradeNameEditorComponent.
	referenceUrlEditorComponent} , super children
]

{ #category : #initialization }
ActiveIngredientEditor >> initializeComponents [
	"Initialize all property components"

	self initializeTradeNameEditorComponent.
	self initializeReferenceUrlEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
ActiveIngredientEditor >> initializeReferenceUrlEditorComponent [
	referenceUrlEditorComponent := TextLinePropertyEditorComponent
		id: 'referenceUrl'
		subject: subject
		selector: #referenceUrl
		label: 'URL de referencia'
		required: false
]

{ #category : #initialization }
ActiveIngredientEditor >> initializeTradeNameEditorComponent [
	tradeNameEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'tradeName'
		subject: subject
		selector: #tradeName
		label: 'Nombre'
		required: true.
	tradeNameEditorComponent
		possibleValuesBlock: [ self allowedNames ];
		instructions:
			'Solo se admiten principios activos registrados en SENASA para alguno de los cultivos existentes en el sistema'
]

{ #category : #rendering }
ActiveIngredientEditor >> renderContentOn: html [
	subject tradeName
		ifNotNil: [ tradeNameEditorComponent readOnly: true ].
	super renderContentOn: html
]
