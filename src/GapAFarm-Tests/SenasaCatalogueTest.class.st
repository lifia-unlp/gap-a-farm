Class {
	#name : #SenasaCatalogueTest,
	#superclass : #TestCase,
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #testing }
SenasaCatalogueTest >> testIsExempt [
	"read https://github.com/AndresMarconi/ProyectoHuertas/wiki#interpretaci%C3%B3n-de-los-datos-importados-desde-senasa"

	| residues exempt nonExempt |
	residues := Dictionary new.
	SenasaCatalogue singleton records
		do: [ :rec | 
			(residues at: rec activeIngredientTradeName ifAbsentPut: Set new)
				add: rec residue ].
	exempt := residues associations
		select: [ :each | each value = (Set with: nil) ].
	nonExempt := residues associations
		reject: [ :each | exempt includes: each ].
	exempt
		do:
			[ :each | self assert: (SenasaCatalogue singleton isExempt: each key) ].
	nonExempt
		do: [ :each | self deny: (SenasaCatalogue singleton isExempt: each key) ].

]

{ #category : #testing }
SenasaCatalogueTest >> testIsExemptFor [

	"'aceite de soja' is totally exempt"
	self
		assert:
			(SenasaCatalogue singleton
				isExempt: 'aceite de soja'
				for: 'Tomate').

	"'azoxistrobina' es except only for a few, including Tobacco but not Tomato"
	self
		assert: (SenasaCatalogue singleton isExempt: 'azoxistrobina' for: 'Tabaco').
	self
		deny:
			(SenasaCatalogue singleton
				isExempt: 'azoxistrobina'
				for: 'Tomate').
				
	"If the crop is nos in the senasa catalog, return false."
	self
		deny: (SenasaCatalogue singleton isExempt: 'azoxistrobina' for: 'No es un cultivo').
	
]

{ #category : #testing }
SenasaCatalogueTest >> testIsSubstanceExemptFor [
	"read https://github.com/AndresMarconi/ProyectoHuertas/wiki#interpretaci%C3%B3n-de-los-datos-importados-desde-senasa"

	| conAceiteDeSojaSolamente |
	conAceiteDeSojaSolamente := Substance new
		comercialName: 'Con aceite de soja solamente'.
	conAceiteDeSojaSolamente
		addActiveIngredient: (ActiveIngredient tradeName: 'aceite de soja').
	self
		assert:
			(SenasaCatalogue singleton
				isSubstanceExempt: conAceiteDeSojaSolamente
				for: (Crop name: 'Tomate' yield: 0))
]
