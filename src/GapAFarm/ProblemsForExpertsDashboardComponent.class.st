Class {
	#name : #ProblemsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #accessing }
ProblemsForExpertsDashboardComponent >> elements [
	^((self session gapAFarm users flatCollect: [ :user | user farms ]) flatCollect: [ :farm | farm problems ]) select: [ :each | each date isAfter: ((Date today) subtractDays: 30) ].
	
]

{ #category : #'as yet unclassified' }
ProblemsForExpertsDashboardComponent >> inThisMonth: reports of: type [
	^ reports size
]

{ #category : #'as yet unclassified' }
ProblemsForExpertsDashboardComponent >> inThisWeek: elements of: type [
	^ (elements
		select: [ :issue | issue date isAfter: (Date today subtractDays: 7) ])
		size
]

{ #category : #rendering }
ProblemsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
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
							html tableData: (self inThisMonth: (adversitiesPerTypes at: type) of: type).
							html tableData: (self inThisWeek: (adversitiesPerTypes at: type) of: type) ] ] ]
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
