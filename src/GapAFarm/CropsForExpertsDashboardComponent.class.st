Class {
	#name : #CropsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #accesing }
CropsForExpertsDashboardComponent >> cropsWithRecords [
	^ self session gapAFarm statistics sowingStatistics
		select: [ :sowing | sowing haveActivity ]
]

{ #category : #'text labels' }
CropsForExpertsDashboardComponent >> describeThisMonth: aSowingStatisticsRecord [
	aSowingStatisticsRecord farmsActiveThisMonth
		ifEmpty: [ ^ 'Sin actividad' ].
	^ aSowingStatisticsRecord quantityThisMonth asString , '/'
		,
			((aSowingStatisticsRecord surfaceThisMonth / 10000) asFloat round: 2)
				asString , 'ha/'
		, aSowingStatisticsRecord farmsActiveThisMonth size asString
]

{ #category : #'text labels' }
CropsForExpertsDashboardComponent >> describeThisWeek: aSowingStatisticsRecord [
	aSowingStatisticsRecord farmsActiveThisWeek
		ifEmpty: [ ^ 'Sin actividad' ].
	^ aSowingStatisticsRecord quantityThisWeek asString , ' / '
		,
			((aSowingStatisticsRecord surfaceThisWeek / 10000) asFloat round: 2)
				asString , 'ha / '
		, aSowingStatisticsRecord farmsActiveThisWeek size asString
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> hasElementsToShow [
	^ true
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderLegendOn: html [
	^ html
		tableRow: [ html tableData.
			html tableData
				style: 'text-align:center';
				colSpan: 2;
				with: [ html small with: 'Cantidad / Superficie / Granjas' ] ]
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderTableBodyOn: html [
	| statisticsPerCrop |
	statisticsPerCrop := self cropsWithRecords.
	html
		tableBody: [ (statisticsPerCrop keys
				asSortedCollection: [ :a :b | a vulgarName < b vulgarName ])
				do: [ :crop | 
					html
						tableRow: [ html tableData: crop vulgarName.
							html
								tableData: (self describeThisMonth: (statisticsPerCrop at: crop)).
							html
								tableData: (self describeThisWeek: (statisticsPerCrop at: crop)) ] ].
			self renderLegendOn: html ]
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> tableHeadingOn: html [
	html tableHead: [ 
		html tableRow: [ 
			html 
				tableHeading: 'Cultivo';
				tableHeading: 'Último mes';
				tableHeading: 'Última semana'  ] ]
]

{ #category : #'text labels' }
CropsForExpertsDashboardComponent >> title [
	^ 'Plantación y siembra'
]
