Class {
	#name : #CropsComponent,
	#superclass : #GAFAbstractTableWithFilterAndActionsComponent,
	#category : #'GapAFarm-ui-expert'
}

{ #category : #adding }
CropsComponent >> addElement [
	| theCrop |
	theCrop := super addElement.
	theCrop
		ifNotNil: [ (self userAcceptsToBatchAddIngredientesFor: theCrop)
				ifTrue: [ self batchAddIngredientsForCrop: theCrop ] ].
	^ theCrop
]

{ #category : #callbacks }
CropsComponent >> batchAddIngredientsForCrop: aCrop [
	self call: (BachAddActiveIngredientsComponent crop: aCrop)
]

{ #category : #rendering }
CropsComponent >> columnHeadings [
	^ {'Nombre vulgar' . 'Rinde óptimo (kg/hectárea)'}, super columnHeadings
]

{ #category : #rendering }
CropsComponent >> columnValuesFor: element [
	^ {element vulgarName.
	element optimalYieldPerPlant}, (super columnValuesFor: element)
]

{ #category : #hooks }
CropsComponent >> elementClass [
	"Returns the class of elements to edit and add"

	^ Crop
]

{ #category : #hooks }
CropsComponent >> elementEditorClass [
	"Returns the class of editor used to edit elements"

	^ CropEditor
]

{ #category : #callbacks }
CropsComponent >> elements [
	^ self session gapAFarm crops
]

{ #category : #initialization }
CropsComponent >> initialize [
	super initialize.
	duplicateEnabled := false.
	removeEnabled := false.
	viewEnabled := true
]

{ #category : #adding }
CropsComponent >> userAcceptsToBatchAddIngredientesFor: aCrop [
	^ self
		confirm:
			aCrop vulgarName
				,
					' se agregó con éxito, ¿quiere agregar los principios activos registrados para el mismo?'
]

{ #category : #callbacks }
CropsComponent >> viewElement: aCrop [
	self
		call:
			(CropViewer new
				crop: aCrop;
				yourself)
]
