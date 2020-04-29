Class {
	#name : #GAFAbstractDashboardComponent,
	#superclass : #GAFAbstractComponent,
	#category : #'GapAFarm-ui-common'
}

{ #category : #initialization }
GAFAbstractDashboardComponent >> initialize [ 
	super initialize.
	self initializeComponents
]

{ #category : #initialization }
GAFAbstractDashboardComponent >> initializeComponents [ 
	^self subclassResponsibility.
]

{ #category : #rendering }
GAFAbstractDashboardComponent >> renderContentOn: html [
	| widgets |
	widgets := self sortedWigets.
	html
		row: [ html
				column: [ widgets
						ifNotEmpty: [ (1 to: widgets size by: 2)
								do: [ :pos | html render: (widgets at: pos) ] ] ]
				mediumSize: 6.
			html
				column: [ widgets size > 1
						ifTrue: [ (2 to: widgets size by: 2)
								do: [ :pos | html render: (widgets at: pos) ] ] ]
				mediumSize: 6 ]
]

{ #category : #'as yet unclassified' }
GAFAbstractDashboardComponent >> sortedWigets [
	^ (self widgets select: [ :each | each hasElementsToShow ])
		asSortedCollection: [ :a :b | a sizeOfColumn <= b sizeOfColumn ]
]

{ #category : #initialization }
GAFAbstractDashboardComponent >> widgets [ 
	^self subclassResponsibility.
]
