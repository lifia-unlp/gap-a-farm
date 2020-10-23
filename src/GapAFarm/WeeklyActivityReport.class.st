Class {
	#name : #WeeklyActivityReport,
	#superclass : #ActivityReport,
	#instVars : [
		'week',
		'daylyReports'
	],
	#category : #'GapAFarm-statistics'
}

{ #category : #'instance creation' }
WeeklyActivityReport class >> with: anEvent [
	^ self new
		updateWith: anEvent;
		yourself
]

{ #category : #accessing }
WeeklyActivityReport >> daylyReports [
	^ daylyReports  select: #notNil
]

{ #category : #printing }
WeeklyActivityReport >> eventCounter [
	| counter |
	counter := SpeciesCounter new.
	daylyReports
		do: [ :each | each ifNotNil: [ counter add: each eventCounter ] ].
	^ counter
]

{ #category : #printing }
WeeklyActivityReport >> group [
	^ week printString
]

{ #category : #printing }
WeeklyActivityReport >> groupingCriteria [
	^ 'week'
]

{ #category : #initialization }
WeeklyActivityReport >> initialize [
	daylyReports := Array new: 7
]

{ #category : #updating }
WeeklyActivityReport >> updateWith: anEvent [
	| report |
	week
		ifNil: [ week := anEvent date asWeek ]
		ifNotNil: [ week ~= anEvent date asWeek
				ifTrue: [ ^ self error: 'Date mismatch between event and report' ] ].
	report := daylyReports at: anEvent date dayOfWeek.
	report
		ifNil: [ daylyReports
				at: anEvent date dayOfWeek
				put: (DaylyActivityReport with: anEvent) ]
		ifNotNil: [ report updateWith: anEvent ]
]

{ #category : #accessing }
WeeklyActivityReport >> week [
	^ week
]
