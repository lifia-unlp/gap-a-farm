Class {
	#name : #EventsChronologyComponent,
	#superclass : #EventsTableComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #accessing }
EventsChronologyComponent class >> plot: aPlot [
	| component |
	component := self new.
	component plot: aPlot.
	^ component
]

{ #category : #rendering }
EventsChronologyComponent >> columnHeadings [
	^ {'Fecha' . 'Lote'. 'Tipo de evento' . 'Resumen'}
]

{ #category : #rendering }
EventsChronologyComponent >> columnValuesFor: element [
	^ {(element date ddmmyyyy , ' - ' , element time print24WithoutSeconds ).
	element plot id.
	(self typeDescriptorFor: element).
	(element summaryFor: self)}
]

{ #category : #accessing }
EventsChronologyComponent >> elements [
	^ self session farm events
		asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ]
]

{ #category : #initialization }
EventsChronologyComponent >> initialize [
	super initialize.
	addEnabled := false.
	editEnabled := false.
	duplicateEnabled := false.
	removeEnabled := false.
]

{ #category : #summaries }
EventsChronologyComponent >> summaryForAdversityReport: anAdversityReport [
	^ anAdversityReport adversityTypes asCommaString , ' ('
		, anAdversityReport descriptionOfAdversities , ')'
		,
			(anAdversityReport crop
				ifNil: [ '' ]
				ifNotNil: [ :it | ' en ' , it vulgarName ])
]

{ #category : #summaries }
EventsChronologyComponent >> summaryForApplication: anApplication [
	^ anApplication substance comercialName
		,
			(anApplication quantity
				ifNil: [ '' ]
				ifNotNil:
					[ :quantity | ' (', quantity printString , ' ' , anApplication substance unit, ')' ])
		,
			(anApplication crop
				ifNil: [ '' ]
				ifNotNil: [ :crop | ' sobre ' , crop vulgarName ])
]

{ #category : #summaries }
EventsChronologyComponent >> summaryForCropSale: aCropSale [
	^ aCropSale sale client , ': ' , aCropSale crop vulgarName , ' ('
		, aCropSale kilograms asString , ' Kg)'
]

{ #category : #summaries }
EventsChronologyComponent >> summaryForHarvesting: aHarvesting [
	| stream |
	stream := String new writeStream.
	stream
		nextPutAll: aHarvesting crop vulgarName;
		nextPutAll: ' - ';
		nextPutAll: aHarvesting quantity printString;
		nextPutAll: ' Kg'.
	aHarvesting otherUnit
		ifNotNil: [ :it | 
			stream
				nextPutAll: ' / ';
				nextPutAll: it printString ].
	^ stream contents
]

{ #category : #summaries }
EventsChronologyComponent >> summaryForSowing: aSowing [
	| stream |
	stream := String new writeStream.
	stream nextPutAll: aSowing crop vulgarName.
	aSowing cultivarName
		ifNotEmpty: [ :it | 
			stream
				nextPutAll: ' (';
				nextPutAll: it;
				nextPutAll: ')' ].
	stream nextPutAll: ' - '.
	stream nextPutAll: aSowing quantity printString.
	^ stream contents
]

{ #category : #rendering }
EventsChronologyComponent >> typeDescriptorFor: element [
	^ {(Application -> 'Aplicación').
	(CropSale -> 'Venta').
	(Harvesting -> 'Cosecha').
	(AdversityReport -> 'Adversidad').
	(Sowing -> 'Implantación')} asDictionary at: element class
]
