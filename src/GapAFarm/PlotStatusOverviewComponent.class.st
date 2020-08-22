Class {
	#name : #PlotStatusOverviewComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #summaries }
PlotStatusOverviewComponent >> adversitySummaryForPlot: aPlot [
	^ String
		streamContents: [ :stream | 
			aPlot currentCycle latestAdversity
				ifNotNil: [ :it | 
					stream
						nextPutAll: '<b>';
						nextPutAll: it descriptionOfAdversities;
						nextPutAll: ':</b> hace ';
						nextPutAll: (Date today - it date) asDays truncated printString;
						nextPutAll: ' días (el ';
						nextPutAll: it date ddmmyyyy;
						nextPutAll: '). ' ] ]
]

{ #category : #summaries }
PlotStatusOverviewComponent >> applicationsSummaryForPlot: aPlot [
	^ String
		streamContents: [ :stream | 
			aPlot currentCycle latestApplication
				ifNotNil: [ :it | 
					stream
						nextPutAll: '<b> ';
						nextPutAll: it substance comercialName;
						nextPutAll: '</b> hace ';
						nextPutAll: (Date today - it date) asDays truncated printString;
						nextPutAll: ' días (el ';
						nextPutAll: it date ddmmyyyy;
						nextPutAll: '). ' ] ]
]

{ #category : #rendering }
PlotStatusOverviewComponent >> columnHeadings [
	^ {'Lote' . 'Implantación' . 'Adversidades'. 'Aplicaciones'}
]

{ #category : #rendering }
PlotStatusOverviewComponent >> columnValuesFor: element [
	"{'Lote' . 'Implantación' . 'Adversidades' . 'Aplicaciones'.
	'Cosecha'}"

	^ {(self labelFor: element).
	(self sowingSummaryForPlot: element).
	(self adversitySummaryForPlot: element).
	((self applicationsSummaryForPlot: element)
		, (self withdrawalSummaryForPlot: element))}
]

{ #category : #accessing }
PlotStatusOverviewComponent >> elements [
	^ self session farm plots
]

{ #category : #summaries }
PlotStatusOverviewComponent >> harvestingSummaryForPlot: aPlot [
	^ String
		streamContents: [ :stream | 
			aPlot currentCycle latestHarvest
				ifNotNil: [ :it | 
					stream
						nextPutAll: 'Se comenzó a <b>cosechar ';
						nextPutAll: it crop vulgarName;
						nextPutAll: '</b> hace ';
						nextPutAll: (Date today - it date) asDays truncated printString;
						nextPutAll: ' días (el ';
						nextPutAll: it date ddmmyyyy;
						nextPutAll: '). ' ] ]
]

{ #category : #initialization }
PlotStatusOverviewComponent >> initialize [
	super initialize.
	addEnabled := false.
	editEnabled := false.
	duplicateEnabled := false
]

{ #category : #summaries }
PlotStatusOverviewComponent >> labelFor: aPlot [
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: aPlot id.
			aPlot type ifNotNil: [ :type | stream nextPutAll: ' - ' , type ].
			aPlot contractor
				ifNotNil:
					[ :contractor | contractor ifNotEmpty: [ stream nextPutAll: ' - ' , contractor ] ] ]
]

{ #category : #summaries }
PlotStatusOverviewComponent >> sowingSummaryForPlot: aPlot [
	^ String
		streamContents: [ :stream | 
			aPlot currentCycle latestSowing
				ifNotNil: [ :it | 
					stream
						nextPutAll: '<b>';
						nextPutAll: it crop vulgarName;
						nextPutAll: ':</b> hace ';
						nextPutAll: (Date today - it date) asDays truncated printString;
						nextPutAll: ' días (el ';
						nextPutAll: it date ddmmyyyy;
						nextPutAll: '). ' ] ]
]

{ #category : #summaries }
PlotStatusOverviewComponent >> withdrawalSummaryForPlot: aPlot [
	| message |
	message := [ aPlot endsOfWithdrawalPeriods
		ifEmpty: [ '' ]
		ifNotEmpty: [ :ends | 
			'<span style="color:red">En carencia hasta el ' , ends max ddmmyyyy
				, '. </span>' ] ]
		on: MissingWithdrawalInformationException
		do: [ '<span style="color:red">En carencia por tiempo desconocido</span>' ].
	^ message
]
