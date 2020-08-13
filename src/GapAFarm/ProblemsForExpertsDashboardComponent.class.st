Class {
	#name : #ProblemsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #'as yet unclassified' }
ProblemsForExpertsDashboardComponent >> calculateInfo: reports [
	| surface farms |
	surface:= (reports inject: 0 into: [ :sum :report | sum + report plot surface ]) truncated.
	farms := ((self session gapAFarm farms) select: [ :farm | farm haveEventIn: reports ]).
	^(surface / 10000) asFloat asString ,' / ', (farms size) asString 
]

{ #category : #accessing }
ProblemsForExpertsDashboardComponent >> elements [
	^((self session gapAFarm users flatCollect: [ :user | user farms ]) flatCollect: [ :farm | farm problems ]) select: [ :each | each date isAfter: ((Date today) subtractDays: 30) ].
	
]

{ #category : #'as yet unclassified' }
ProblemsForExpertsDashboardComponent >> inThisMonth: reports [
	reports isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: reports ]
]

{ #category : #'as yet unclassified' }
ProblemsForExpertsDashboardComponent >> inThisWeek: reports [
	| reportsInWeek |
	reportsInWeek:= reports select: [ :report | report date isAfter:(Date today subtractDays:7)].
	reportsInWeek isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: reportsInWeek  ]
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderTableBodyOn: html [
	| adversitiesPerTypes |
	adversitiesPerTypes := Dictionary new. 
	self elements do: [ :each | each adversityTypes do: [ :type | (adversitiesPerTypes at: type ifAbsentPut: OrderedCollection new)  add:each]   ].
	
	html
		tableBody: [ adversitiesPerTypes keys asOrderedCollection 
				do: [ :type | 
					html
						tableRow: [ html tableData: type.
							html tableData: (self inThisMonth: (adversitiesPerTypes at: type)).
							html tableData: (self inThisWeek: (adversitiesPerTypes at: type)) ] ].
					html 
						tableRow: [ 
							html 
								tableData:' '.
							html 
								tableData: [ html small with: 'Hecs / Granjas'].
							html 
								tableData: [ html small with: 'Hecs / Granjas'] ] ]
]

{ #category : #'as yet unclassified' }
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
