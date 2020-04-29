Class {
	#name : #CropEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'yieldEditorComponent',
		'vulgarNameEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
CropEditor >> allowedCropNames [
	^ {nil}
		,
			(SenasaCatalogue singleton cropVulgarNames
				reject: [ :each | each includes: $* ])
		copyWithoutAll: (self session gapAFarm crops collect: #vulgarName)
]

{ #category : #'subclass-responsibility' }
CropEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {vulgarNameEditorComponent.
		yieldEditorComponent}, 
		super children
]

{ #category : #initialization }
CropEditor >> initializeComponents [
	"Initialize all property components"

	self initializeVulgarNameEditorComponent.
	self initializeYieldEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
CropEditor >> initializeVulgarNameEditorComponent [
	vulgarNameEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'vulgarName'
		subject: subject
		selector: #vulgarName
		label: 'Nombre'
		required: true.
	vulgarNameEditorComponent
		possibleValuesBlock: [ self allowedCropNames ];
		instructions:
			'Solo se admiten cultivos para los que existan principios activos registrados en SENASA'
]

{ #category : #initialization }
CropEditor >> initializeYieldEditorComponent [
	yieldEditorComponent := TextLinePropertyEditorComponent
		id: 'optimalYieldPerPlant'
		subject: subject
		selector: #optimalYieldPerPlant
		label: 'Rinde óptimo (kg/hectárea)'
		required: true
]

{ #category : #rendering }
CropEditor >> renderContentOn: html [
	subject vulgarName
		ifNotNil: [ vulgarNameEditorComponent readOnly: true ].
	super renderContentOn: html
]
