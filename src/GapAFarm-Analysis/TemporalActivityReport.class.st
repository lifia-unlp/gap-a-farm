Class {
	#name : #TemporalActivityReport,
	#superclass : #ActivityReport,
	#instVars : [
		'monthlyReports'
	],
	#category : #'GapAFarm-Analysis'
}

{ #category : #printing }
TemporalActivityReport >> daylyReports [
	^ (monthlyReports flatCollect: [ :each | each daylyReports ])
		asSortedCollection: [ :a :b | a date < b date ]
]

{ #category : #printing }
TemporalActivityReport >> eventCounts [
	| counter |
	counter := SpeciesCounter new.
	monthlyReports do: [ :each | counter add: each eventCounts ].
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
	^ monthlyReports
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
