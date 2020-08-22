Class {
	#name : #BatchPlotCreator,
	#superclass : #GAFEditor,
	#instVars : [
		'surface',
		'type',
		'surfaceEditorComponent',
		'typeEditorComponent',
		'numberOfPlots',
		'plotIdsEditorComponent',
		'plotIds'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #callbacks }
BatchPlotCreator >> accept [
   self checkForDuplicatePlotNames. 
	(self children anySatisfy: [ :each | each hasProblems ])
		ifTrue: [ ^ self ].
	self children do: #accept.
	self answer: self createPlots.
]

{ #category : #callbacks }
BatchPlotCreator >> checkForDuplicatePlotNames [
	| existing |
	existing := ((plotIdsEditorComponent bufferedValue splitOn: $,)
		collect: #trimBoth) asSet
		select: [ :each | (self session farm plots collect: #id) includes: each ].
	existing
		do: [ :each | 
			plotIdsEditorComponent
				addProblem: 'Ya existe un lote con este identificador: ' , each ]
]

{ #category : #'subclass-responsibility' }
BatchPlotCreator >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {plotIdsEditorComponent.
	surfaceEditorComponent.
	typeEditorComponent}
]

{ #category : #callbacks }
BatchPlotCreator >> createPlots [
	^ plotIds
		collect: [ :id | 
			(Plot id: id surface: surface)
				type: type;
				yourself ]
]

{ #category : #'subclass-responsibility' }
BatchPlotCreator >> initialize [
	super initialize.
	plotIds := OrderedCollection new.
]

{ #category : #initialization }
BatchPlotCreator >> initializeComponents [
	"Initialize all property components"

	self initializePlotIdsEditorComopnent.
	self initializeSurfaceEditorComponent.
	self initializeTypeEditorComponent
]

{ #category : #initialization }
BatchPlotCreator >> initializePlotIdsEditorComopnent [
	plotIdsEditorComponent := TextAreaPropertyEditorComponent
		id: 'plotNames'
		subject: self
		selector: #plotNames
		label: 'Nombres de los lotes a crear (separados por coma)'
		required: true.
	plotIdsEditorComponent
		instructions:
			'Si utiliza números, complete con ceros adelante para que tengan la misma longitud y luego queden ordenados, p.e., Lote 001, Lote 002, etc.'
]

{ #category : #initialization }
BatchPlotCreator >> initializeSurfaceEditorComponent [
	surfaceEditorComponent := NumberPropertyEditorComponent
		id: 'surface'
		subject: self
		selector: #surface
		label: 'Superficie de los lotes (m2)'
		required: true
]

{ #category : #initialization }
BatchPlotCreator >> initializeTypeEditorComponent [
	typeEditorComponent := DropdownSelectPropertyEditorComponent
		id: 'typeSelector'
		subject: self
		selector: #type
		label: 'Tipo de lote'
		required: true.
	typeEditorComponent possibleValuesBlock: [ Plot types ]
]

{ #category : #accessing }
BatchPlotCreator >> numberOfPlots [
	^ numberOfPlots
]

{ #category : #accessing }
BatchPlotCreator >> numberOfPlots: anObject [
	numberOfPlots := anObject
]

{ #category : #accessing }
BatchPlotCreator >> plotNames [
	^ plotIds asCommaString
]

{ #category : #accessing }
BatchPlotCreator >> plotNames: anObject [
	plotIds := ((anObject splitOn: $,) collect: #trimBoth) asSet asSortedCollection
]

{ #category : #accessing }
BatchPlotCreator >> surface [
	^ surface
]

{ #category : #accessing }
BatchPlotCreator >> surface: anObject [
	surface := anObject
]

{ #category : #accessing }
BatchPlotCreator >> type [
	^ type
]

{ #category : #accessing }
BatchPlotCreator >> type: anObject [
	type := anObject
]
