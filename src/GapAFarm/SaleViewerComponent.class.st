Class {
	#name : #SaleViewerComponent,
	#superclass : #GAFAbstractTableComponent,
	#instVars : [
		'sale'
	],
	#category : #'GapAFarm-ui-farmer'
}

{ #category : #accessing }
SaleViewerComponent class >> sale: sale [
	^ self new
		sale: sale;
		yourself
]

{ #category : #rendering }
SaleViewerComponent >> columnHeadings [
	^ {'Producto'.
	'Cantidad'.
	'Lote'}
]

{ #category : #rendering }
SaleViewerComponent >> columnValuesFor: element [
	^ {element crop.
	element kilograms greaseString , ' Kg'.
	element plot id}
]

{ #category : #accessing }
SaleViewerComponent >> elements [ 
	^sale items
]

{ #category : #rendering }
SaleViewerComponent >> renderContentOn: html [
	html
		row: [ html
				column: [ html paragraph: [ html strong: 'Fecha' ].
					html paragraph: sale date yyyymmdd ]
					mediumSize: 6;
				column: [ html paragraph: [ html strong: 'Cliente' ].
					html paragraph: sale client ]
					mediumSize: 6 ].
	html paragraph: [ html strong: 'Notas' ].
	html paragraph: sale comment.
	html paragraph: [ html strong: 'Descripción de venta' ].
	super renderContentOn: html
]

{ #category : #accessing }
SaleViewerComponent >> sale [
	^ sale
]

{ #category : #accessing }
SaleViewerComponent >> sale: anObject [
	sale := anObject
]
