Class {
	#name : #SubstancesForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #'text labels' }
SubstancesForExpertsDashboardComponent >> describeThisMonth: anApplicationStatisticsRecord [
	anApplicationStatisticsRecord farmsActiveThisMonth
		ifEmpty: [ ^ 'Sin actividad' ].
	^ anApplicationStatisticsRecord quantityThisMonth asString , ' / '
		, (anApplicationStatisticsRecord surfaceThisMonth / 10000) asFloat asString
		, 'ha / '
		, anApplicationStatisticsRecord farmsActiveThisMonth size asString
]

{ #category : #'text labels' }
SubstancesForExpertsDashboardComponent >> describeThisWeek: anApplicationStatisticsRecord [
	anApplicationStatisticsRecord farmsActiveThisWeek
		ifEmpty: [ ^ 'Sin actividad' ].
	^ anApplicationStatisticsRecord quantityThisWeek asString , ' / '
		, (anApplicationStatisticsRecord surfaceThisWeek / 10000) asFloat asString
		, 'ha / '
		, anApplicationStatisticsRecord farmsActiveThisWeek size asString
]

{ #category : #accessing }
SubstancesForExpertsDashboardComponent >> hasElementsToShow [
	^ true
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderLegendOn: html [
	^ html
		tableRow: [ html tableData.
			html tableData
				style: 'text-align:center';
				colSpan: 3;
				with: [ html small with: 'Usado / Superficie / Granjas' ] ]
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderTableBodyOn: html [
	| statisticsPerSubstance |
	statisticsPerSubstance := self subtancesWithRecords.
	html
		tableBody: [ statisticsPerSubstance keys asOrderedCollection
				do: [ :substance | 
					html
						tableRow: [ html tableData: substance comercialName.
							html
								tableData: (self describeThisMonth: (statisticsPerSubstance at: substance)).
							html
								tableData: (self describeThisWeek: (statisticsPerSubstance at: substance)) ] ].
			self renderLegendOn: html ]
]

{ #category : #accessing }
SubstancesForExpertsDashboardComponent >> subtancesWithRecords [
	^ self session gapAFarm statistics applicationStatistics
		select: [ :sowing | sowing haveActivity ]
]

{ #category : #private }
SubstancesForExpertsDashboardComponent >> tableHeadingOn: html [
	html tableHead: [ 
		html tableRow: [ 
			html 
				tableHeading: 'Principio activo';
				tableHeading: 'Último mes';
				tableHeading: 'Última semana' ] ]
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> title [
	^ 'Uso de fitosanitarios'
]
