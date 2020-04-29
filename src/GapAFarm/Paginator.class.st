Class {
	#name : #Paginator,
	#superclass : #Object,
	#instVars : [
		'subject',
		'selector',
		'page',
		'elementsPerPage'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #'instance creation' }
Paginator class >> subject: anObject selector: aMessageSelector pageSize: aNumber [
	^ self new
		subject: anObject;
		selector: aMessageSelector;
		elementsPerPage: aNumber;
		yourself
]

{ #category : #accessing }
Paginator >> elementsPerPage [
	^ elementsPerPage
]

{ #category : #accessing }
Paginator >> elementsPerPage: anObject [
	elementsPerPage:= anObject
]

{ #category : #initialization }
Paginator >> initialize [ 
	page := 1
]

{ #category : #initialization }
Paginator >> leftItemsQuantity [
	| first last|
	first:= page - 5.
	last:= page + 5.
	first < 1 ifTrue: [ first:= 1 ] 
	ifFalse: [ last > self pages ifTrue: [ first:= first - (last - self pages) ] ].
	^ first
	
]

{ #category : #accessing }
Paginator >> page [
	^ page
]

{ #category : #accessing }
Paginator >> page: number [
	((number > 0) and: (number <= (self pages)))  
		ifTrue: [ page := number ]
	
]

{ #category : #accessing }
Paginator >> pages [ 
	((self totalElements \\ elementsPerPage) > 0)
		ifTrue: [ ^ (self totalElements quo: elementsPerPage) + 1 ] 
		ifFalse: [ ^ self totalElements quo: elementsPerPage ]
]

{ #category : #rendering }
Paginator >> renderItem: symbol number: aNumber class: aClass on: html [
	html listItem
		class: 'page-item ',aClass ;
		with: [ html anchor
			class: 'page-link';
			callback: [ page := aNumber ];
			with: symbol ]
]

{ #category : #rendering }
Paginator >> renderNextButtonOn: html [
	page = self pages
		ifTrue: [ self
				renderItem: [ html span
						attributeAt: 'title' put: 'Ver';
						class: 'fa fa-arrow-right' ]
				number: page
				class: ' disabled'
				on: html.
			self
				renderItem: 'Final'
				number: page
				class: ' disabled'
				on: html ]
		ifFalse: [ self
				renderItem: [ html span
						attributeAt: 'title' put: 'Ver';
						class: 'fa fa-arrow-right' ]
				number: page + 1
				class: ''
				on: html.
			self
				renderItem: 'Final'
				number: self pages
				class: ''
				on: html ]
]

{ #category : #rendering }
Paginator >> renderPagesOn: html [
	self pages < 10
		ifTrue: [ 1 to: self pages do: [ :pageNumber | 
				page = pageNumber
					ifTrue: [ self
							renderItem: pageNumber
							number: pageNumber
							class: 'active'
							on: html ]
					ifFalse: [ self
							renderItem: pageNumber
							number: pageNumber
							class: ''
							on: html ] ] ]
		ifFalse:
			[ self leftItemsQuantity to: self rigthItemsQuantity do: [ :pageNumber | 
				page = pageNumber
					ifTrue: [ self
							renderItem: pageNumber
							number: pageNumber
							class: 'active'
							on: html ]
					ifFalse: [ self
							renderItem: pageNumber
							number: pageNumber
							class: ''
							on: html ] ] ]
]

{ #category : #rendering }
Paginator >> renderPaginationOn: html [
	self totalElements < elementsPerPage
		ifTrue: [ ^ self ].
	html row
		class: 'd-flex flex-row justify-content-center';
		with: [ html
				navigation: [ html unorderedList
						class: 'pagination';
						style: 'font-size: 0.9rem;';
						with: [ self renderPreviousButtonOn: html.
							self renderPagesOn: html.
							self renderNextButtonOn: html ] ] ]
]

{ #category : #rendering }
Paginator >> renderPreviousButtonOn: html [
	page = 1
		ifTrue: [ self
				renderItem: 'Principio'
				number: page
				class: ' disabled'
				on: html.
			self
				renderItem: [ html span
						attributeAt: 'title' put: 'Ver';
						class: 'fa fa-arrow-left' ]
				number: page
				class: ' disabled'
				on: html ]
		ifFalse: [ self
				renderItem: 'Principio'
				number: 1
				class: ''
				on: html.
			self
				renderItem: [ html span
						attributeAt: 'title' put: 'Ver';
						class: 'fa fa-arrow-left' ]
				number: page - 1
				class: ''
				on: html ]
]

{ #category : #initialization }
Paginator >> rigthItemsQuantity [
	| first last|
	first:= page - 5.
	last:= page + 5.
	last > self pages ifTrue: [ last:= self pages ] 
	ifFalse: [ first < 1 ifTrue: [ last:= last - first ] ].
	^ last
	
]

{ #category : #initialization }
Paginator >> selectElementsIn: collection [
	| total col |
	(elementsPerPage < self totalElements)
	ifTrue: [ 
		total := (self totalElements - (elementsPerPage * (page - 1))).
		col := collection last: total.
		(total > elementsPerPage) 
		ifTrue: [ col := col first: elementsPerPage ]. ]
	ifFalse: [ col:= collection ].
	^ col
]

{ #category : #accessing }
Paginator >> selector [
	^ selector
]

{ #category : #accessing }
Paginator >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
Paginator >> subject [
	^ subject
]

{ #category : #accessing }
Paginator >> subject: anObject [
	subject := anObject
]

{ #category : #accessing }
Paginator >> totalElements [
	^ (subject perform: selector) size
]
