Class {
	#name : #SubstanceEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'comercialNameEditorComponent',
		'activeIngredientsEditorComponent',
		'manufacturerEditorComponent',
		'unitEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #callbacks }
SubstanceEditor >> accept [
	self checkIfCommercialNameIsAlreadyInUse.
	super accept
]

{ #category : #accessing }
SubstanceEditor >> activeIngredients [ 
	^ ActiveIngredient selectAll asSortedCollection: [ :a :b | a tradeName < b tradeName ]
]

{ #category : #private }
SubstanceEditor >> checkIfCommercialNameIsAlreadyInUse [
	(self session gapAFarm
		isSubstanceCommercialNameInUse: comercialNameEditorComponent bufferedValue
		byOtherThan: subject)
		ifTrue: [ comercialNameEditorComponent
				addProblem: 'Ya existe un producto con ese nombre' ]
]

{ #category : #'subclass-responsibility' }
SubstanceEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {comercialNameEditorComponent.
	manufacturerEditorComponent.
	unitEditorComponent.
	activeIngredientsEditorComponent} , super children
]

{ #category : #initialization }
SubstanceEditor >> initializeActiveIngredienteEditorComponent [
	activeIngredientsEditorComponent := MultipleSelectPropertyEditorComponent
		id: 'activeIngredients'
		subject: subject
		selector: #activeIngredients
		label: 'Principios activos (controlados por SENASA)'
		required: false.
	activeIngredientsEditorComponent
		possibleValuesBlock: [ self activeIngredients ];
		instructions: 'mantenga oprimido Ctrl para seleccionar mas de uno'
]

{ #category : #initialization }
SubstanceEditor >> initializeComercialNameEditorComponent [
	comercialNameEditorComponent := TextLinePropertyEditorComponent
		id: 'comercialName'
		subject: subject
		selector: #comercialName
		label: 'Nombre Comercial'
		required: true
]

{ #category : #initialization }
SubstanceEditor >> initializeComponents [
	"Initialize all property components"

	self initializeComercialNameEditorComponent.
	self initializeManufaturerEditorComponent.
	self initializeActiveIngredienteEditorComponent.
	self initializeUnitEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
SubstanceEditor >> initializeManufaturerEditorComponent [
	manufacturerEditorComponent := TextLinePropertyEditorComponent
		id: 'manufacturer'
		subject: subject
		selector: #manufacturer
		label: 'Fabricante'
		required: false
]

{ #category : #initialization }
SubstanceEditor >> initializeUnitEditorComponent [
	unitEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'unit'
		subject: subject
		selector: #unit
		label: 'Unidad de medida'
		required: true.
	unitEditorComponent possibleValuesBlock: [ Substance units ]
]
