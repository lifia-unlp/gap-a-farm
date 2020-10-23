Class {
	#name : #FarmSnapshotComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'farm'
	],
	#category : #'GapAFarm-ui-admin'
}

{ #category : #accessing }
FarmSnapshotComponent >> farm: anObject [
	farm := anObject
]

{ #category : #rendering }
FarmSnapshotComponent >> renderBasicInfoOn: html [
	html heading
		level: 5;
		with: 'Nombre del establecimiento'.
	html paragraph: farm name
]

{ #category : #rendering }
FarmSnapshotComponent >> renderContentOn: html [
	html container
		style: 'padding-top: 20px';
		with: [ self renderBasicInfoOn: html.
			self renderStatisticsOn: html ]
]

{ #category : #rendering }
FarmSnapshotComponent >> renderCounts: report labeled: rowLabel on: html [
	| counts |
	counts := report eventCounter counts.
	html
		tableRow: [ html
				tableData: rowLabel;
				tableData: (counts at: Sowing ifAbsent: [ 0 ]);
				tableData: (counts at: AdversityReport ifAbsent: [ 0 ]);
				tableData: (counts at: Application ifAbsent: [ 0 ]);
				tableData: (counts at: Harvesting ifAbsent: [ 0 ]) ]
]

{ #category : #rendering }
FarmSnapshotComponent >> renderHeadingsOn: html [
	html
		tableRow: [ html
				tableHeading: 'Período';
				tableHeading: 'Siembra';
				tableHeading: 'Adversidad';
				tableHeading: 'Aplicación';
				tableHeading: 'Cosecha' ]
]

{ #category : #rendering }
FarmSnapshotComponent >> renderStatisticsOn: html [
	| report |
	report := TemporalActivityReport new.
	farm events do: [ :each | report updateWith: each ].
	html heading
		level: 5;
		with: 'Estadisticas de registro'.
	html table
		class: 'table table-hover table-sm';
		with: [ html tableHead: [ self renderHeadingsOn: html ].
			html
				tableBody: [ report monthlyReports
						do:
							[ :each | self renderCounts: each labeled: each month greaseString on: html ].
					self renderCounts: report labeled: 'Total' on: html ] ]
]
