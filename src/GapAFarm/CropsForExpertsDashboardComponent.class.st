Class {
	#name : #CropsForExpertsDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-expert-dashboard'
}

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> calculateInfo: sowingsPerCrop [
	| quantity surface farms |
	quantity:= 
		(sowingsPerCrop inject: 0 into: [ :sum :sowing | sum + sowing quantity magnitude ]) truncated.
	surface:= 
		(sowingsPerCrop inject: 0 into: [ :sum :sowing | sum + sowing plot surface ]) truncated.
	farms := ((self session gapAFarm farms) select: [ :farm | farm haveSowingsIn: sowingsPerCrop ]).
	^quantity asString , ' ', (sowingsPerCrop at: 1) quantity unitSmall
		,' / ', (surface / 10000) asFloat asString 
		,' / ', (farms size) asString 
]

{ #category : #accessing }
CropsForExpertsDashboardComponent >> elements [
	^ ((self session gapAFarm users flatCollect: [ :user | user farms ])
		flatCollect: [ :farm | farm sowings ])
		select: [ :each | each date isAfter: (Date today subtractDays: 30) ]
]

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> inThisMonth: sowingsPerCrop [
	sowingsPerCrop isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: sowingsPerCrop  ]
]

{ #category : #'as yet unclassified' }
CropsForExpertsDashboardComponent >> inThisWeek: sowingsPerCrop [
	| sowingsInWeek |
	sowingsInWeek:= sowingsPerCrop select: [ :sowing | sowing date isAfter:(Date today subtractDays:7)].
	sowingsInWeek isEmpty 
	ifTrue: [ ^'No hay datos' ]
	ifFalse: [ ^self calculateInfo: sowingsInWeek  ]
]

{ #category : #rendering }
CropsForExpertsDashboardComponent >> renderContentOn: html [
	html table
		class: 'table table-hover table-sm';
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
								tableData: (self inThisMonth: (sowingsPerCrop at: crop)).
							html
								tableData: (self inThisWeek: (sowingsPerCrop at: crop)) ] ]. 
					html tableRow: [ 
							html tableData:' '.
							html tableData: [ html small with: 'Plantado / Hecs / Granjas'].
							html tableData: [ html small with: 'Plantado / Hecs / Granjas'] ]	]
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
