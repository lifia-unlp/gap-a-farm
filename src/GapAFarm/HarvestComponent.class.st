Class {
	#name : #HarvestComponent,
	#superclass : #EventsTableComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
HarvestComponent >> columnHeadings [
	^ super columnHeadings , { 'Cultivo' . 'Cantidad'. 'Notas'}
]

{ #category : #rendering }
HarvestComponent >> columnValuesFor: element [
	" {'Fecha' . 'Lote' . 'Variedad' . 'Cantidad'. 'Superficie (m2)'. }}"

	^ (super columnValuesFor: element)
		,
			{element crop vulgarName.
			(self quantityStringFor: element).
			(self shorten: element comment to: 25)}
]

{ #category : #hooks }
HarvestComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Harvesting 
]

{ #category : #hooks }
HarvestComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ HarvestingEditor
]

{ #category : #accessing }
HarvestComponent >> elements [
	^ (self session farm harvestings) asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ]
]

{ #category : #rendering }
HarvestComponent >> quantityStringFor: aHarvesing [
	| stream |
	stream := String new writeStream.
	stream
		nextPutAll: aHarvesing quantity printString;
		nextPutAll: ' Kg'.
	aHarvesing otherUnit
		ifNotNil: [ :it | 
			it magnitude > 0
				ifTrue: [ stream
						nextPutAll: ' / ';
						nextPutAll: it printString ] ].
	^ stream contents
]

{ #category : #callbacks }
HarvestComponent >> summaryForEvent: element [
	^ '<b>la cosecha de ' , element crop vulgarName , ' del '
		, element date ddmmyyyy , ' en el lote ' , element plot id , '</b>'
]
