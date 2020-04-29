Class {
	#name : #TableFilterComponent,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'column',
		'filter',
		'columns'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #'instance creation' }
TableFilterComponent class >> columns: aCollection [
	^ self new
		columns: aCollection;
		yourself
]

{ #category : #accessing }
TableFilterComponent >> column [
	^ column
]

{ #category : #accessing }
TableFilterComponent >> column: anObject [
	column := anObject
]

{ #category : #accessing }
TableFilterComponent >> columns [
	^ columns
]

{ #category : #accessing }
TableFilterComponent >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
TableFilterComponent >> filter [
	^ filter
]

{ #category : #accessing }
TableFilterComponent >> filter: anObject [
	^ filter := anObject
]

{ #category : #initialization }
TableFilterComponent >> initialize [
	super initialize.
	filter := ''
]

{ #category : #rendering }
TableFilterComponent >> renderContentOn: html [
	html form
		style: 'margin-bottom: 20px;';
		with: [ html
				row: [ html
						column: [ html select
								formControl;
								list: {nil} , columns;
								on: #column of: self ]
						mediumSize: 4.
					html
						column: [ html textInput
								on: #filter of: self;
								formControl ]
						mediumSize: 4.
					html
						column: [ html formButton
								bePrimary;
								with: 'Filtrar'.
							filter
								ifNotEmpty: [ html space.
									html formButton
										bePrimary;
										callback: [ filter := ''.
											column := nil ];
										with: 'Limpiar' ] ]
						mediumSize: 4 ] ]
]

{ #category : #filtering }
TableFilterComponent >> shouldFilter [
	^ column notNil & filter notEmpty
]
