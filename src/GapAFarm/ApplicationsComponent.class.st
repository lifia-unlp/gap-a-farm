Class {
	#name : #ApplicationsComponent,
	#superclass : #EventsTableComponent,
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #rendering }
ApplicationsComponent >> columnHeadings [
	^ super columnHeadings , {'Cultivo' . 'Producto' . 'Cantidad'}

]

{ #category : #rendering }
ApplicationsComponent >> columnValuesFor: element [
	" {'Fecha' . 'Lote' . 'Producto' . 'Dosis'}"

	^ (super columnValuesFor: element)
		,
			{(element crop ifNil: [ '' ] ifNotNil: [ :it | it vulgarName ]).
			element substance comercialName.
			(element quantity printString , ' ' , element substance unit)}
		
]

{ #category : #hooks }
ApplicationsComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Application
]

{ #category : #hooks }
ApplicationsComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ ApplicationEditor
]

{ #category : #hooks }
ApplicationsComponent >> elements [
	^ (self session farm aplications) asSortedCollection: [ :a :b | a dateAndTime > b dateAndTime ]
]

{ #category : #adding }
ApplicationsComponent >> saveAddedElement: aCollectionOfApplications [
	aCollectionOfApplications
		do: [ :each | super saveAddedElement: each ]
]

{ #category : #callbacks }
ApplicationsComponent >> summaryForEvent: element [
	^ '<b>la aplicación de ' , element substance comercialName , ' del '
		, element date ddmmyyyy , ' en el lote ' , element plot id , '</b>'
]
