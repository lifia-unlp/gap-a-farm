Class {
	#name : #SubstancesForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #accessing }
SubstancesForExpertsDashboardComponent >> elements [ 
	^((self session gapAFarm users flatCollect: [ :user | user farms ]) flatCollect: [ :farm | farm aplications ]) select: [ :each | each date isAfter: ((Date today) subtractDays: 30) ]
]

{ #category : #private }
SubstancesForExpertsDashboardComponent >> inThisMonth: elements of: ingredient [
	^ elements size
]

{ #category : #private }
SubstancesForExpertsDashboardComponent >> inThisWeek: elements of: ingredient [
	^ (elements
		select:
			[ :application | application date isAfter: (Date today subtractDays: 7) ])
		size
]

{ #category : #rendering }
SubstancesForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
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
									(self
										inThisMonth: (applicationsPerSubstance at: substance)
										of: substance).
							html
								tableData:
									(self
										inThisWeek: (applicationsPerSubstance at: substance)
										of: substance) ] ] ]
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
