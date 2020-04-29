Class {
	#name : #PlotsManagementComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
PlotsManagementComponent >> addManyElements [
	(self call: (BatchPlotCreator subject: nil))
		ifNotNil:
			[ :plots | plots do: [ :plot | self saveAddedElement: plot ] ]
]

{ #category : #rendering }
PlotsManagementComponent >> columnHeadings [
	^ {'ID' . 'Superficie (m2)'. 'Notas' },super columnHeadings
]

{ #category : #rendering }
PlotsManagementComponent >> columnValuesFor: element [
	^ {element id.
	element surface.
	(self shorten: element comment to: 45)}
		, (super columnValuesFor: element)
]

{ #category : #hooks }
PlotsManagementComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Plot
]

{ #category : #hooks }
PlotsManagementComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ PlotEditor
]

{ #category : #accessing }
PlotsManagementComponent >> elements [
	^ self session farm plots
]

{ #category : #rendering }
PlotsManagementComponent >> renderAddButtonOn: html [
	addEnabled
		ifTrue: [ html
				paragraph: [ html anchor
						id: 'addOnePlot';
						callback: [ self addElement ];
						with: [ html formButton
								bePrimary;
								with: 'Agregar uno' ].
					html space.
					html anchor
						id: 'addmanyPlots';
						callback: [ self addManyElements ];
						with: [ html formButton
								bePrimary;
								with: 'Agregar muchos' ] ] ]
]

{ #category : #callbacks }
PlotsManagementComponent >> saveAddedElement: aPlot [
	super saveAddedElement: aPlot.
	self session farm addPlot: aPlot.
	self session farm save
]
