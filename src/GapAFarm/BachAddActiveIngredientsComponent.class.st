Class {
	#name : #BachAddActiveIngredientsComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'crop',
		'selectedIngredients',
		'selectedIngredientsComponent'
	],
	#category : #'GapAFarm-ui-expert'
}

{ #category : #'instance creation' }
BachAddActiveIngredientsComponent class >> crop: aCrop [
	^ self new
		crop: aCrop;
		yourself
]

{ #category : #callbacks }
BachAddActiveIngredientsComponent >> accept [
	selectedIngredientsComponent accept.
	selectedIngredientsComponent hasProblems
		ifTrue: [ ^ self ].
	selectedIngredients
		do: [ :each | 
			ActiveIngredient new
				tradeName: each;
				save ].
	self answer
]

{ #category : #private }
BachAddActiveIngredientsComponent >> activeIngredients [
	| registered existing |
	registered := SenasaCatalogue singleton
		registeredIngredientsForCropNamed: crop vulgarName.
	existing := self session gapAFarm activeIngredients
		collect: #tradeName.
	^ registered copyWithoutAll: existing
]

{ #category : #callbacks }
BachAddActiveIngredientsComponent >> cancel [
	^ self answer
]

{ #category : #accessing }
BachAddActiveIngredientsComponent >> crop [
	^ crop
]

{ #category : #accessing }
BachAddActiveIngredientsComponent >> crop: anObject [
	crop := anObject.
	selectedIngredientsComponent
		possibleValuesBlock: [ self activeIngredients ]
]

{ #category : #initialization }
BachAddActiveIngredientsComponent >> initialize [
	super initialize.
	selectedIngredients := OrderedCollection new.
	selectedIngredientsComponent := MultipleSelectPropertyEditorComponent
		id: 'selectedIngredients'
		subject: self
		selector: #selectedIngredients
		label: 'Ingredientes a agregar'
		required: true.
	selectedIngredientsComponent
		instructions: 'Mantenga oprimido el botón Ctrl para seleccionar más de uno';
		rows: 20
]

{ #category : #rendering }
BachAddActiveIngredientsComponent >> renderButtonsOn: html [
	html
		paragraph: [ html formButton
				bePrimary;
				callback: [ self accept ];
				with: 'Aceptar'.
			html space.
			html formButton
				beSecondary;
				callback: [ self cancel ];
				with: 'Cancelar' ]
]

{ #category : #rendering }
BachAddActiveIngredientsComponent >> renderContentOn: html [
	html
		form: [ html render: selectedIngredientsComponent.
			self renderProblemsOn: html.
			self renderButtonsOn: html ]
]

{ #category : #rendering }
BachAddActiveIngredientsComponent >> renderProblemsOn: html [
	selectedIngredientsComponent problems
		do: [ :each | 
			html alert
				beDanger;
				with: each ]
]

{ #category : #accessing }
BachAddActiveIngredientsComponent >> selectedIngredients [
	^ selectedIngredients
]

{ #category : #accessing }
BachAddActiveIngredientsComponent >> selectedIngredients: anObject [
	selectedIngredients := anObject
]
