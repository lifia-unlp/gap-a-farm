Class {
	#name : #CSVGAFExporter,
	#superclass : #Object,
	#instVars : [
		'events',
		'sortBlock'
	],
	#category : #'GapAFarm-export'
}

{ #category : #'instance creation' }
CSVGAFExporter class >> events: aCollectionOfEvents [
	^ self new events: aCollectionOfEvents
]

{ #category : #exporting }
CSVGAFExporter >> elementRowFor: each [
	self subclassResponsibility
]

{ #category : #accessing }
CSVGAFExporter >> events [
	^ events
]

{ #category : #accessing }
CSVGAFExporter >> events: anObject [
	events := anObject
]

{ #category : #exporting }
CSVGAFExporter >> export [
	| rows |
	rows := Array new writeStream.
	rows nextPut: self headerRow.
	(self events
		asSortedCollection: sortBlock)
		do: [ :each | rows nextPut: (self elementRowFor: each) ].
	^ String
		streamContents: [ :stream | 
			(NeoCSVWriter on: stream)
				separator: $;;
				nextPutAll: rows contents ]
]

{ #category : #exporting }
CSVGAFExporter >> headerRow [
	self subclassResponsibility
]

{ #category : #initialization }
CSVGAFExporter >> initialize [
	sortBlock := [ :a :b | a dateAndTime < b dateAndTime ]
]

{ #category : #accessing }
CSVGAFExporter >> sortBlock [
	^ sortBlock
]

{ #category : #accessing }
CSVGAFExporter >> sortBlock: anObject [
	sortBlock := anObject
]
