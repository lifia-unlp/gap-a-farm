Class {
	#name : #CropsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #accessing }
CropsForExpertsDashboardComponent >> elements [ 
	^((self session gapAFarm users flatCollect: [ :user | user farms ]) flatCollect: [ :farm | farm sowings ]) select: [ :each | each date isAfter: ((Date today) subtractDays: 30) ]
]

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> inThisMonth: elements of: crop [
	^ (elements
		inject: 0
		into: [ :sum :sowing | sum + sowing quantity magnitude ]) truncated
]

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> inThisWeek: elements of: crop [
	^ ((elements
		select: [ :sowing | sowing date isAfter: (Date today subtractDays: 7) ])
		inject: 0
		into: [ :sum :sowing | sum + sowing quantity magnitude ]) truncated
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover';
		with: [ self tableHeadingOn: html.
				  self renderTableBodyOn: html ].
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderTableBodyOn: html [
	| set sowingsPerCrop |
	sowingsPerCrop := Dictionary new.
	self elements
		do: [ :each | 
			(sowingsPerCrop at: each crop ifAbsentPut: OrderedCollection new)
				add: each ].
	html
		tableBody: [ (sowingsPerCrop keys
				asSortedCollection: [ :a :b | a vulgarName < b vulgarName ])
				do: [ :crop | 
					html
						tableRow: [ html tableData: crop vulgarName.
							html
								tableData: (self inThisMonth: (sowingsPerCrop at: crop) of: crop).
							html
								tableData: (self inThisWeek: (sowingsPerCrop at: crop) of: crop) ] ] ]
]

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> tableHeadingOn: html [
	html tableHead: [ 
		html tableRow: [ 
			html 
				tableHeading: 'Cultivo';
				tableHeading: 'Último mes';
				tableHeading: 'Última semana'  ] ]
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> title [
	^ 'Plantación y siembra'
]
