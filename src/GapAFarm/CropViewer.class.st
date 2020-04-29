Class {
	#name : #CropViewer,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'crop'
	],
	#category : #'GapAFarm-ui-expert'
}

{ #category : #accessing }
CropViewer >> crop [
	^ crop
]

{ #category : #accessing }
CropViewer >> crop: anObject [
	crop := anObject
]

{ #category : #rendering }
CropViewer >> renderContentOn: html [
	html heading
		level5;
		with: 'Cultivo'.
	html paragraph: crop vulgarName.
	html heading
		level5;
		with: 'Rinde óptimo (por planta)'.
	html paragraph: crop optimalYieldPerPlant.
	crop comment
		ifNotEmpty: [ :it | 
			html heading
				level5;
				with: 'Notes'.
			html paragraph: it ].
	html heading
		level5;
		with: 'Principios activos registrados'.
	html table
		class: 'table table-hover';
		with: [ html
				tableHead: [ html
						tableHeading: 'Principio activo';
						tableHeading: 'Residuo';
						tableHeading: 'Fuente' ].
			html
				tableBody: [ (SenasaCatalogue singleton recordsForCropNamed: crop vulgarName)
						do: [ :record | 
							html
								tableRow: [ | ingredientName |
									ingredientName := record activeIngredientTradeName size > 30
										ifTrue: [ (record activeIngredientTradeName copyFrom: 1 to: 30) , ' ...' ]
										ifFalse: [ record activeIngredientTradeName ].
									html
										tableData: ingredientName;
										tableData: (record residue ifNil: [ 'Exento' ]);
										tableData: record source ] ] ] ]
]
