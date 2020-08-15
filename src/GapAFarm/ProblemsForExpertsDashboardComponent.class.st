Class {
	#name : #ProblemsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #testing }
ProblemsForExpertsDashboardComponent >> adversitiesWithRecords [
	^ self session gapAFarm statistics adversityStatistics
		select: [ :each | each haveActivity ]
]

{ #category : #'text labels' }
ProblemsForExpertsDashboardComponent >> describeThisMonth: anAdversityStatisticsRecord [
	anAdversityStatisticsRecord farmsActiveThisMonth 
		ifEmpty: [ ^ 'Sin actividad' ].
	^ (anAdversityStatisticsRecord surfaceThisMonth / 10000) asFloat asString
		, 'ha / '
		, anAdversityStatisticsRecord farmsActiveThisMonth size asString
]

{ #category : #'text labels' }
ProblemsForExpertsDashboardComponent >> describeThisWeek: anAdversityStatisticsRecord [
	anAdversityStatisticsRecord farmsActiveThisWeek
		ifEmpty: [ ^ 'Sin actividad' ].
	^ (anAdversityStatisticsRecord surfaceThisWeek / 10000) asFloat asString
		, 'ha / '
		, anAdversityStatisticsRecord farmsActiveThisWeek size asString

]

{ #category : #testing }
ProblemsForExpertsDashboardComponent >> hasElementsToShow [
	^ true
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderLegendOn: html [
	^ html
		tableRow: [ html tableData.
			html tableData
				style: 'text-align:center';
				colSpan: 2;
				with: [ html small with: 'Superficie / Granjas' ] ]
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderTableBodyOn: html [
	| statisticsPerTypes |
	statisticsPerTypes := self adversitiesWithRecords.
	html
		tableBody: [ statisticsPerTypes keys asOrderedCollection
				do: [ :type | 
					html
						tableRow: [ html tableData: type.
							html
								tableData: (self describeThisMonth: (statisticsPerTypes at: type)).
							html
								tableData: (self describeThisWeek: (statisticsPerTypes at: type)) ] ].
			self renderLegendOn: html ]
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> tableHeadingOn: html [
	html tableHead: [ 
		html tableRow: [ 
			html 
				tableHeading: 'Tipo';
				tableHeading: 'Último mes';
				tableHeading: 'Última semana' ] ]
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> title [
	^ 'Adversidades'
]
