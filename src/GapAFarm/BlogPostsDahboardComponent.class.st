Class {
	#name : #BlogPostsDahboardComponent,
	#superclass : #GAFAbstractWidgetComponent,
	#category : #'GapAFarm-ui-farmer-dashboard'
}

{ #category : #accessing }
BlogPostsDahboardComponent >> elements [
	^ (self session gapAFarm blogPostFor: self session farm)
		asSortedCollection: [ :a :b | a date > b date ]
]

{ #category : #rendering }
BlogPostsDahboardComponent >> renderElementsTableOn: html [
	| posts |
	posts := self elements.
	posts ifEmpty: [ ^ self ].
	posts
		from: 1
		to: (rows min: posts size)
		do: [ :post | 
			html
				paragraph: [ html text: '(' , post date ddmmyyyy , ') '.
					post isAlert
						ifTrue: [ html strong
								style: 'color: red;';
								with: '¡!'.
							html space ].
					html text: (self shorten: post text to: 120) ] ]
]

{ #category : #'as yet unclassified' }
BlogPostsDahboardComponent >> viewAll [
	self parent show: BlogPostsComponentForFarmers new
]
