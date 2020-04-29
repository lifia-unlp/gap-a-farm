Class {
	#name : #PlotEditor,
	#superclass : #GAFEditor,
	#instVars : [
		'idPEditorComponent',
		'surfaceEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #callbacks }
PlotEditor >> accept [
	self checkIfPlotIdIsAlreadyInUse.
	super accept
]

{ #category : #testing }
PlotEditor >> checkIfPlotIdIsAlreadyInUse [
	(self session farm
		isPlotIdInUse: idPEditorComponent bufferedValue
		byOtherThan: subject)
		ifTrue: [ idPEditorComponent
				addProblem: 'Ya existe un lote con ese identificador' ]
]

{ #category : #'subclass-responsibility' }
PlotEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {idPEditorComponent.
		surfaceEditorComponent}, 
		super children
]

{ #category : #initialization }
PlotEditor >> initializeComponents [
	"Initialize all property components"

	self initializeIdEditorComponent.
	self initializeSurfaceEditorComponent.
	super initializeComponents
]

{ #category : #initialization }
PlotEditor >> initializeIdEditorComponent [
	idPEditorComponent := TextLinePropertyEditorComponent
		id: 'plotId'
		subject: subject
		selector: #id
		label: 'Identificador del lote'
		required: true
]

{ #category : #initialization }
PlotEditor >> initializeSurfaceEditorComponent [
	surfaceEditorComponent := NumberPropertyEditorComponent
		id: 'surface'
		subject: subject
		selector: #surface
		label: 'Superficie del Lote (m2)'
		required: true
]
