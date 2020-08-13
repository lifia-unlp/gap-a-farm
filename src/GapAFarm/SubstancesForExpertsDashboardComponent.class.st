Class {
	#name : #SubstancesForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #'as yet unclassified' }
SubstancesForExpertsDashboardComponent >> calculateInfo: applications [
	| quantity surface farms |
	quantity:= 
		(applications inject: 0 into: [ :sum :application | sum + application quantity ]) truncated.
	surface:= 
		(applications inject: 0 into: [ :sum :application | sum + application plot surface ]) truncated.
	farms := ((self session gapAFarm farms) select: [ :farm | farm haveEventIn: applications ]).
	^quantity asString ,(applications at: 1) substance unit
		,' / ', (surface / 10000) asFloat asString 
		,' / ', (farms size) asString 
]

{ #category : #accessing }
SubstancesForExpertsDashboardComponent >> elements [ 
	^((self session gapAFarm users flatCollect: [ :user | user farms ]) flatCollect: [ :farm | farm aplications ]) select: [ :each | each date isAfter: ((Date today) subtractDays: 30) ]
]

{ #category : #'as yet unclassified' }
SubstancesForExpertsDashboardComponent >> inThisMonth: applications [
	applications isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: applications ]
]

{ #category : #'as yet unclassified' }
SubstancesForExpertsDashboardComponent >> inThisWeek: applications [
	| applicationsInWeek |
	applicationsInWeek:= 
		applications select: [ :report | report date isAfter:(Date today subtractDays:7)].
	applicationsInWeek isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: applicationsInWeek  ]
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderTableBodyOn: html [
	| applicationsPerSubstance |
	applicationsPerSubstance := Dictionary new.
	self elements
		do: [ :each | 
			(applicationsPerSubstance
				at: each substance
				ifAbsentPut: OrderedCollection new) add: each ].
	html
		tableBody: [ applicationsPerSubstance keys asOrderedCollection
				do: [ :substance | 
					html
						tableRow: [ html tableData: substance comercialName.
							html
								tableData:
									(self inThisMonth: (applicationsPerSubstance at: substance)).
							html
								tableData:
									(self inThisWeek: (applicationsPerSubstance at: substance)) ] ].
					html 
						tableRow: [ 
							html 
								tableData:' '.
							html 
								tableData: [ html small with: 'Uso/Hecs/Granjas'].
							html 
								tableData: [ html small with: 'Uso/Hecs/Granjas'] ] ]
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
