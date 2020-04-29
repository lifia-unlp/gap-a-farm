Class {
	#name : #SaleListItemEditor,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'items',
		'sale',
		'selectedCrop',
		'quantity',
		'selectedPlot'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #callbacks }
SaleListItemEditor >> accept [
 	sale items: items.
	
]

{ #category : #adding }
SaleListItemEditor >> addItem [
	selectedCrop
		ifNil: [ problems add: 'Debe seleccionar un cultivo'.
			^ self ].
	selectedPlot
		ifNil: [ problems add: 'Debe seleccionar un lote'.
			^ self ].
	(quantity isNotNil and: [ quantity > 0 ])
		ifFalse: [ problems add: 'La cantidad debe ser mayor a 0'.
			^ self ].
	items
		add:
			(CropSale new
				crop: selectedCrop;
				plot: selectedPlot;
				kilograms: quantity;
				yourself).
	selectedCrop := nil.
	selectedPlot := nil.
	quantity := nil
]

{ #category : #callbacks }
SaleListItemEditor >> cancel [
	^ self
]

{ #category : #testing }
SaleListItemEditor >> hasProblems [
	^ (self children anySatisfy: #hasProblems) | items isEmpty
]

{ #category : #initialization }
SaleListItemEditor >> initialize [
	items := OrderedCollection new.
	problems := OrderedCollection new.
]

{ #category : #accessing }
SaleListItemEditor >> problems [
	^ (self children flatCollect: #problems)
		,
			(items
				ifEmpty:
					[ {'Todavía no ha agregado items a la venta. Recuerde oprimir el botón [+] para agregar los items.'} ]
				ifNotEmpty: [ Set new ])
]

{ #category : #adding }
SaleListItemEditor >> removeRowWith: item [
	items remove: item
]

{ #category : #rendering }
SaleListItemEditor >> renderContentOn: html [
	html label: 'Productos'.
	"	problems
		do: [ :each | 
			html alert
				beDanger;
				with: each ]."
	problems := OrderedCollection new.
	self renderElementsTableOn: html
]

{ #category : #rendering }
SaleListItemEditor >> renderCropSelectorOn: html [
	html select
		formControl;
		list: {nil} , self session gapAFarm crops;
		callback: [ :value | selectedCrop := value ];
		selected: selectedCrop;
		id: 'crop-selector'
]

{ #category : #rendering }
SaleListItemEditor >> renderElementsTableOn: html [
	html table
		class: 'table table-bordered table-sm';
		style: 'margin-top: 10px;';
		with: [ html
				tableHead: [ html
						tableRow: [ html tableData
								style: 'width: 40%;';
								with: 'Producto'.
							html tableData
								style: 'width: 35%;';
								with: 'Lote'.
							html tableData
								style: 'width: 20%;';
								with: 'Cantidad'.
							html tableData
								style: 'width: 5%;';
								with: '' ] ].
			html
				tableBody: [ self renderExitingItemsRowsOn: html.
					self renderNewItemRowOn: html ] ]
]

{ #category : #rendering }
SaleListItemEditor >> renderExitingItemsRowsOn: html [
	^ items
		do: [ :item | 
			html
				tableRow: [ html
						tableData: (item crop ifNil: [ 'N/A' ] ifNotNil: [ :it | it vulgarName ]);
						tableData: (item plot ifNil: [ 'N/A' ] ifNotNil: [ :it | it id ]);
						tableData: item kilograms greaseString.
					html tableData
						class: 'text-right';
						with: [ html formButton
								beSmall;
								beDanger;
								callback: [ self removeRowWith: item ];
								with: [ html span class: 'fa fa-minus' ] ] ] ]
]

{ #category : #rendering }
SaleListItemEditor >> renderNewItemRowOn: html [
	html
		tableRow: [ html
				tableData: [ self renderCropSelectorOn: html ];
				tableData: [ self renderPlotSelectorOn: html ];
				tableData: [ self renderQuantityEditorOn: html ].
			html tableData
				class: 'text-right';
				with: [ html formButton
						beSmall;
						bePrimary;
						callback: [ self addItem ];
						with: [ html span class: 'fa fa-plus' ] ] ]
]

{ #category : #rendering }
SaleListItemEditor >> renderPlotSelectorOn: html [
	html select
		formControl;
		list: {nil} , self session farm plots;
		labels: [ :each | each ifNil: [  ] ifNotNil: [ :it | it id ] ];
		callback: [ :value | selectedPlot := value ];
		selected: selectedPlot;
		id: 'crop-selector'
]

{ #category : #rendering }
SaleListItemEditor >> renderQuantityEditorOn: html [
	html numberInput
		formControl;
		step: 0.01;
		placeholder: '0.00';
		size: 10;
		noAutocomplete;
		callback:
				[ :value | quantity := value ifEmpty: [ nil ] ifNotEmpty: [ :it | it asNumber ] ];
		value: (quantity ifNil: [ '' ]);
		id: 'quantity'
]

{ #category : #accessing }
SaleListItemEditor >> sale [
	^ sale
]

{ #category : #accessing }
SaleListItemEditor >> sale: aSale [
	sale := aSale.
	items := aSale items
		collect: [ :each | 
			each copy
				sale: nil;
				yourself ]
]
