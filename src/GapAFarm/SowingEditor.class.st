Class {
	#name : #SowingEditor,
	#superclass : #EventEditor,
	#instVars : [
		'quantityEditorComponent',
		'timeToHarvestEditorComponent',
		'harvestDurationEditorComponent',
		'expectedYieldEditorComponent',
		'cropEditorComponent',
		'cultivarEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #callbacks }
SowingEditor >> accept [
	(self children anySatisfy: [ :each | each hasProblems ])
		ifTrue: [ ^ self ].
	self children do: #accept.
	(subject plot currentCycle wouldRestartIfSowing: subject)
		ifTrue: [ self shouldProceed
				ifFalse: [ ^ self cancel ] ].
	self answer: subject
]

{ #category : #accessing }
SowingEditor >> crops [
	^ (self session farm mostFrequentelyPlanted: 10) , {nil}
		, self session gapAFarm crops
]

{ #category : #'subclass-responsibility' }
SowingEditor >> eventSpecificChildren [
	^ {cropEditorComponent.
	cultivarEditorComponent.
	quantityEditorComponent.
	timeToHarvestEditorComponent.
	harvestDurationEditorComponent.
	expectedYieldEditorComponent}
]

{ #category : #'subclass-responsibility' }
SowingEditor >> frequentlyPlantedCrops [
	^ self session farm frequentlyPlantedCrops
]

{ #category : #initialization }
SowingEditor >> initializeComponents [
	"Initialize all property components"

	super initializeComponents.
	self initializeCropEditorComponent.
	self initializeCultivarEditorComponent.
	self initializeQuantityEditorComponent.
	self initializeTimeToHarvestEditorComponent.
	self initializeHarvestDurationEditorComponent.
	self initializeExpectedYieldEditorComponent
]

{ #category : #initialization }
SowingEditor >> initializeCropEditorComponent [
	cropEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'cropSelector'
		subject: subject
		selector: #crop
		label: 'Cultivo'
		required: true.
	cropEditorComponent possibleValuesBlock: [ self crops ]
]

{ #category : #initialization }
SowingEditor >> initializeCultivarEditorComponent [
	cultivarEditorComponent := TextLinePropertyEditorComponent
		id: 'cultivar'
		subject: subject
		selector: #cultivarName
		label: 'Variedad (cultivar)'
		required: false
]

{ #category : #initialization }
SowingEditor >> initializeExpectedYieldEditorComponent [
	expectedYieldEditorComponent := NumberPropertyEditorComponent
		id: 'expectedYield'
		subject: subject
		selector: #expectedYield
		label: 'Rendimiento total esperado (en Kg)'
		required: true
]

{ #category : #initialization }
SowingEditor >> initializeHarvestDurationEditorComponent [
	harvestDurationEditorComponent := NumberPropertyEditorComponent
		id: 'harvestDuration'
		subject: subject
		selector: #harvestDuration
		label: 'Duración estimada de la cosecha (en días)'
		required: true
]

{ #category : #initialization }
SowingEditor >> initializeQuantityEditorComponent [
	quantityEditorComponent := MeasurementPropertyEditorComponent
		id: 'quantity'
		subject: subject
		selector: #quantity
		label: 'Cantidad'
		required: true
		units: {'Plantas' . 'Kg de semilla'}
]

{ #category : #initialization }
SowingEditor >> initializeTimeToHarvestEditorComponent [
	timeToHarvestEditorComponent := NumberPropertyEditorComponent
		id: 'timeToHarvest'
		subject: subject
		selector: #timeToHarvest
		label: 'Tiempo estimado para cosechar (en días)'
		required: true
]

{ #category : #'subclass-responsibility' }
SowingEditor >> renderChildrenOn: html [
	{dateEditorComponent.
	timeEditorComponent.
	plotEditorComponent.
	cropEditorComponent} do: [ :each | html render: each ].
	html render: commentEditorComponent.
	html alert
		beInfo;
		with:
			'La información que se solicita a continuación se utiliza para afrecerle mejores consejos. Si no la tiene, simplemente complete con 0 (cero)'.
	{quantityEditorComponent.
	timeToHarvestEditorComponent.
	harvestDurationEditorComponent.
	expectedYieldEditorComponent} do: [ :each | html render: each ]
]

{ #category : #callbacks }
SowingEditor >> shouldProceed [
	^ self
		confirm:
			'En el lote <b>' , subject plot id , '</b> hay actualmente <b>'
				, subject plot currentCycle crop vulgarName
				, '</b> ¿está seguro de que quiere dar inicio a un nuevo ciclo plantando <b>'
				, subject crop vulgarName , '</b>?'
]
