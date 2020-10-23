Class {
	#name : #MonthlyActivityReport,
	#superclass : #ActivityReport,
	#instVars : [
		'month',
		'weeklyReports'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #'instance creation' }
MonthlyActivityReport class >> with: anEvent [
	^ self new
		updateWith: anEvent;
		yourself
]

{ #category : #accessing }
MonthlyActivityReport >> daylyReports [
	^ weeklyReports flatCollect: [ :each | each daylyReports ]
]

{ #category : #printing }
MonthlyActivityReport >> eventCounter [
	| counter |
	counter := SpeciesCounter new.
	weeklyReports do: [ :each | counter add: each eventCounter ].
	^ counter
]

{ #category : #printing }
MonthlyActivityReport >> group [
	^ month printString
]

{ #category : #printing }
MonthlyActivityReport >> groupingCriteria [
	^ 'month'
]

{ #category : #initialization }
MonthlyActivityReport >> initialize [
	weeklyReports := Dictionary new
]

{ #category : #accessing }
MonthlyActivityReport >> month [
	^ month
]

{ #category : #updating }
MonthlyActivityReport >> updateWith: anEvent [
	| report |
	month
		ifNil: [ month := anEvent date month ]
		ifNotNil: [ month ~= anEvent date month
				ifTrue: [ ^ self error: 'Date mismatch between event and report' ] ].
	report := weeklyReports at: anEvent date asWeek ifAbsent: [ nil ].
	report
		ifNil: [ weeklyReports
				at: anEvent date asWeek
				put: (WeeklyActivityReport with: anEvent) ]
		ifNotNil: [ report updateWith: anEvent ]
]

{ #category : #accessing }
MonthlyActivityReport >> weeklyReports [
	^weeklyReports 
]
