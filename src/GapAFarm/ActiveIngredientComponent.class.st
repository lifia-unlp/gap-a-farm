Class {
	#name : #ActiveIngredientComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #rendering }
ActiveIngredientComponent >> columnHeadings [
	^ {'Nombre' . 'URL de referencia'}, super columnHeadings
]

{ #category : #rendering }
ActiveIngredientComponent >> columnValuesFor: element [
	| tradeName |
	tradeName := element tradeName size > 30
		ifTrue: [ (element tradeName copyFrom: 1 to: 30) , ' ...' ]
		ifFalse: [ element tradeName ].
	^ {tradeName.
	element referenceUrl} , (super columnValuesFor: element)
]

{ #category : #hooks }
ActiveIngredientComponent >> elementClass [
	^ ActiveIngredient
]

{ #category : #hooks }
ActiveIngredientComponent >> elementEditorClass [
	^ ActiveIngredientEditor
]

{ #category : #accessing }
ActiveIngredientComponent >> elements [
	^ self session gapAFarm activeIngredients
]

{ #category : #initialization }
ActiveIngredientComponent >> initialize [
	super initialize.
	duplicateEnabled := false.
	removeEnabled := false.
	viewEnabled := true.
]

{ #category : #callbacks }
ActiveIngredientComponent >> viewElement: anActiveIngredient [
	self
		call:
			(ActiveIngredientViewer new
				activeIngredient: anActiveIngredient;
				yourself)
]
