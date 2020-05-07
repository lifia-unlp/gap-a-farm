Class {
	#name : #BlogPostEditorComponent,
	#superclass : #GAFEditor,
	#instVars : [
		'dateEditorComponent',
		'authorEditorComponent',
		'textEditorComponent',
		'moreInfoUrlEditorComponent',
		'visibleThroughEditorComponent',
		'cropsEditorComponent',
		'adversityTypesEditorComponent',
		'typeEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
BlogPostEditorComponent >> allowedProblemTypes [
	^ AdversityReport types
]

{ #category : #'subclass-responsibility' }
BlogPostEditorComponent >> children [
	^ {dateEditorComponent.
	visibleThroughEditorComponent.
	authorEditorComponent.
	textEditorComponent.
	moreInfoUrlEditorComponent.
	cropsEditorComponent.
	adversityTypesEditorComponent.
	typeEditorComponent}
]

{ #category : #'subclass-responsibility' }
BlogPostEditorComponent >> crops [
	^ self session gapAFarm crops
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeAdversityTypesEditorComponent [
	adversityTypesEditorComponent := MultipleSelectPropertyEditorComponent
		id: #adversityTypes
		subject: subject
		selector: #adversityTypes
		label: 'Tipos de adversidades'
		required: false.
	adversityTypesEditorComponent
		instructions:
			'Seleccione tipos de arversidad si quiere limitar la visibilidad solo a aquellas huertas que las reportaton en el ciclo actual (oprima Ctrl para seleccionar varios)';
		possibleValuesBlock: [ self allowedProblemTypes ];
		rows: self allowedProblemTypes size
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeAuthorEditorComponent [
	authorEditorComponent := TextLinePropertyEditorComponent
		id: 'author'
		subject: subject
		selector: #author
		label: 'Autor'
		required: false
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeComponents [
	"Initialize all property components"

	self
		initializeDateEditorComponent;
		initializeAuthorEditorComponent;
		initializeTextEditorComponent;
		initializeMoreInfoUrlEditorComponent;
		initializeVisibleThroughEditorComponent;
		initializeCropsEditorComponent;
		initializeAdversityTypesEditorComponent;
		initializeTypeEditorComponent
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeCropsEditorComponent [
	cropsEditorComponent := MultipleSelectPropertyEditorComponent
		id: #crops
		subject: subject
		selector: #crops
		label: 'Cultivos'
		required: false.
	cropsEditorComponent
		instructions:
			'Seleccione cultivos si quiere limitar la visibilidad solo a aquellas huertas que los implantaron en el ciclo actual (oprima Ctrl para seleccionar varios)';
		possibleValuesBlock: [ self crops ];
		rows: 10
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeDateEditorComponent [
	dateEditorComponent := DatePropertyEditorComponent
		id: 'date'
		subject: subject
		selector: #date
		label: 'Fecha'
		required: true.
	subject date ifNotNil: [ dateEditorComponent readOnly: true ]
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeMoreInfoUrlEditorComponent [
	moreInfoUrlEditorComponent := TextLinePropertyEditorComponent
		id: 'moreInfoUrl'
		subject: subject
		selector: #moreInfoUrl
		label: 'URL (mas información)'
		required: false
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeTextEditorComponent [
	textEditorComponent := TextAreaPropertyEditorComponent
		id: 'text'
		subject: subject
		selector: #text
		label: 'Texto'
		required: true
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeTypeEditorComponent [
	typeEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'type'
		subject: subject
		selector: #type
		label: 'Typo de mensaje'
		required: true.
	typeEditorComponent possibleValuesBlock: [ BlogPost types ]
]

{ #category : #initialization }
BlogPostEditorComponent >> initializeVisibleThroughEditorComponent [
	visibleThroughEditorComponent := DatePropertyEditorComponent
		id: 'visibleThrough'
		subject: subject
		selector: #visibleThrough
		label: 'Visible hasta'
		required: false
]

{ #category : #rendering }
BlogPostEditorComponent >> renderChildrenOn: html [
	{dateEditorComponent.
	authorEditorComponent.
	typeEditorComponent.
	textEditorComponent.
	moreInfoUrlEditorComponent} do: [ :each | html render: each ].
	html alert
		beInfo;
		with:
			'A continuación podrá restringir o enfocar la visibilidad de su mensaje.'.
	{visibleThroughEditorComponent.
	cropsEditorComponent.
	adversityTypesEditorComponent} do: [ :each | html render: each ]
]
