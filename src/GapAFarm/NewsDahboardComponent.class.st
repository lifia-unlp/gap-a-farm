Class {
	#name : #NewsDahboardComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #accessing }
NewsDahboardComponent >> elements [
	^ self session gapAFarm blogPostFor: self session farm
]

{ #category : #rendering }
NewsDahboardComponent >> renderElementsTableOn: html [
	| posts |
	posts := self elements.
	posts ifEmpty: [ ^ self ].
	posts
		from: 1
		to: (rows min: posts size)
		do: [ :post | 
			html
				paragraph: '(' , post date ddmmyyyy , ') ' , (self shorten: post text to: 120) ]
]

{ #category : #'as yet unclassified' }
NewsDahboardComponent >> viewAll [
	^ self
]
