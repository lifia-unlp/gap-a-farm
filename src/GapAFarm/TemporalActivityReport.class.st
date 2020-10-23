Class {
	#name : #TemporalActivityReport,
	#superclass : #ActivityReport,
	#instVars : [
		'monthlyReports'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #printing }
TemporalActivityReport >> daylyReports [
	^ (monthlyReports flatCollect: [ :each | each daylyReports ])
		asSortedCollection: [ :a :b | a date < b date ]
]

{ #category : #printing }
TemporalActivityReport >> eventCounter [
	| counter |
	counter := SpeciesCounter new.
	monthlyReports do: [ :each | counter add: each eventCounter ].
	^ counter
]

{ #category : #printing }
TemporalActivityReport >> group [
	^'N/A'
]

{ #category : #printing }
TemporalActivityReport >> groupingCriteria [
	^ 'criteria'
]

{ #category : #initialization }
TemporalActivityReport >> initialize [
	monthlyReports := Dictionary new
]

{ #category : #accessing }
TemporalActivityReport >> monthlyReports [
	^ monthlyReports values asSortedCollection: [ :a :b | a month < b month ]
]

{ #category : #updating }
TemporalActivityReport >> updateWith: anEvent [
	| report |
	report := monthlyReports at: anEvent date month ifAbsent: [ nil ].
	report
		ifNil: [ monthlyReports
				at: anEvent date month
				put: (MonthlyActivityReport with: anEvent) ]
		ifNotNil: [ report updateWith: anEvent ]
]
