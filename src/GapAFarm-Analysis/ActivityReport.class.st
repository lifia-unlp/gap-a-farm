Class {
	#name : #ActivityReport,
	#superclass : #Object,
	#category : #'GapAFarm-Analysis'
}

{ #category : #printing }
ActivityReport >> asJson [
	| dict |
	dict := Dictionary new.
	self eventCounts speciesCountDictionary
		keysAndValuesDo: [ :key :value | dict at: key name put: value ].
	dict at: self groupingCriteria put: self group.
	^ dict asJson
]

{ #category : #printing }
ActivityReport >> eventCounts [
	^ self subclassResponsibility
]

{ #category : #printing }
ActivityReport >> group [
	self subclassResponsibility
]

{ #category : #printing }
ActivityReport >> groupingCriteria [
	self subclassResponsibility
]

{ #category : #printing }
ActivityReport >> printOn: aStream [
	self eventCounts printOn: aStream
]
