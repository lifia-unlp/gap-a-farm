Class {
	#name : #SowingComponent,
	#superclass : #EventsTableComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
SowingComponent >> columnHeadings [
	^ super columnHeadings , {'Cultivo' . 
	'Cantidad'. 'Notas'}
]

{ #category : #rendering }
SowingComponent >> columnValuesFor: element [
	" {'Fecha' . 'Lote' . 'Variedad' . 'Cantidad'. . }}"

	^ (super columnValuesFor: element)
		,
			{element crop vulgarName.
			(element quantity magnitude > 0
				ifTrue: [ element quantity magnitude asString , ' ' , element quantity unit ]
				ifFalse: [ '' ]).
			(self shorten: element comment to: 25)}
]

{ #category : #hooks }
SowingComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Sowing
]

{ #category : #hooks }
SowingComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ SowingEditor
]

{ #category : #accessing }
SowingComponent >> elements [
	^ (self session farm sowings) asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ]
]

{ #category : #callbacks }
SowingComponent >> summaryForEvent: element [
	^ '<b>la implantación de ' , element crop vulgarName , ' del '
		, element date ddmmyyyy , ' en el lote ' , element plot id , ' (que podría haber dado inicio al ciclo actual)</b>'
]
