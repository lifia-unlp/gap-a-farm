Class {
	#name : #SalesComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
SalesComponent >> columnHeadings [
	^ { 'Fecha'. 'Cliente'. 'Productos' }, super columnHeadings
]

{ #category : #rendering }
SalesComponent >> columnValuesFor: element [
	^ {element date asDate ddmmyyyy.
	element client.
	(self productsStringFor: element)} , (super columnValuesFor: element)
]

{ #category : #hooks }
SalesComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Sale
]

{ #category : #hooks }
SalesComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ SaleEditor 
]

{ #category : #callbacks }
SalesComponent >> elements [
	^ (self session farm sales) asSortedCollection: [ :a :b | a date > b date ]
]

{ #category : #adding }
SalesComponent >> initialize [
	super initialize.
	viewEnabled := true.
	editEnabled := false.
	duplicateEnabled := false
]

{ #category : #rendering }
SalesComponent >> productsStringFor: element [
	^ (element items
		collect: [ :each | 
			each crop vulgarName , ': ' , each kilograms greaseString , ' Kg ('
				, each plot id , ')' ]) asCommaString
]

{ #category : #adding }
SalesComponent >> saveAddedElement: aSale [
	super saveAddedElement: aSale.
	self session farm addSale: aSale.
	aSale items
		do: [ :aCropSale | 
			aCropSale
				date: aSale date;
				time: Time now.
			(aCropSale plot)
				addEvent: aCropSale;
				save ].
	self session farm save
]

{ #category : #callbacks }
SalesComponent >> viewElement: element [
	^self call: (SaleViewerComponent sale: element)
]
