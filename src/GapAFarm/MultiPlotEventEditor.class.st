Class {
	#name : #MultiPlotEventEditor,
	#superclass : #EventEditor,
	#instVars : [
		'selectedPlots'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #callbacks }
MultiPlotEventEditor >> accept [
	(self children anySatisfy: [ :each | each hasProblems ])
		ifTrue: [ ^ self ].
	self children do: #accept.
	self
		answer:
			(selectedPlots
				collect: [ :each | 
					subject copy
						plot: each;
						yourself ])
]

{ #category : #initialization }
MultiPlotEventEditor >> initializePlotEditorComponent [
	plotEditorComponent := MultipleSelectPropertyEditorComponent
		id: 'plotSelector'
		subject: self
		selector: #selectedPlots
		label: 'Lotes afectados - Cultivos'
		required: true.
	plotEditorComponent
		rows: (10 min: self plots size);
		possibleValuesBlock: [ self plots ];
		labelsBlock: [ :each | self labelForPlot: each ];
		instructions: 'mantenga oprimido Ctrl para seleccionar varios'.
	subject plot
		ifNotNil: [ plotEditorComponent
				readOnly: true;
				label: 'Lote afectado - Cultivo' ]
]

{ #category : #accessing }
MultiPlotEventEditor >> selectedPlots [
	^ selectedPlots
]

{ #category : #accessing }
MultiPlotEventEditor >> selectedPlots: anObject [
	selectedPlots := anObject
]

{ #category : #initialization }
MultiPlotEventEditor >> subject: anEvent [
	selectedPlots := {anEvent plot}.
	super subject: anEvent
]
