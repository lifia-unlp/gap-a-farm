Class {
	#name : #Sale,
	#superclass : #GafObject,
	#instVars : [
		'date',
		'client',
		'items'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
Sale class >> client: aClient date: aDate [
	^ self new
		date: aDate;
		client: aClient;
		yourself
]

{ #category : #testing }
Sale class >> isVoyageRoot [
	^ true
]

{ #category : #accessing }
Sale >> addItem: aCropSale [
	items add: aCropSale.
	aCropSale sale: self
]

{ #category : #accessing }
Sale >> client [
	^ client
]

{ #category : #accessing }
Sale >> client: anObject [
	client := anObject
]

{ #category : #accessing }
Sale >> date [
	^ date
]

{ #category : #accessing }
Sale >> date: anObject [
	date := anObject
]

{ #category : #initialization }
Sale >> initialize [
   super initialize .
	items := OrderedCollection new.
]

{ #category : #accessing }
Sale >> items [
	^ items
]

{ #category : #removing }
Sale >> items: aCollectionOfItems [
	items do: [ :each | each sale: nil ].
	items := aCollectionOfItems.
	items do: [ :each | each sale: self ]
]

{ #category : #removing }
Sale >> removeItem: item [
	items remove: item
]

{ #category : #accessing }
Sale >> removeLastItem [
	items removeLast
]
