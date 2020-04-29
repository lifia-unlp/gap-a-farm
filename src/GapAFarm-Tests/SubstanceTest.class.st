Class {
	#name : #SubstanceTest,
	#superclass : #TestCase,
	#category : #'GapAFarm-Tests-tests'
}

{ #category : #tests }
SubstanceTest >> testWithdrawalTimeFor [
	"'abamectina' is allowed for Acelga"

	| conAbamectinaaSolamente acelga |
	acelga := Crop name: 'Acelga' yield: 0.
	conAbamectinaaSolamente := Substance new
		comercialName: 'Con abamectina solamente'.
	conAbamectinaaSolamente
		addActiveIngredient: (ActiveIngredient tradeName: 'abamectina').
	self
		should: [ conAbamectinaaSolamente withdrawalTimeFor: acelga ]
		raise: MissingWithdrawalInformationException.
	conAbamectinaaSolamente
		addWithdrawalRecommendation: (WithdrawalRecommendation daysToWait: 1 crop: acelga referenceUrl: '').
	self
		assert:
			(conAbamectinaaSolamente
				withdrawalTimeFor: acelga)
		equals: 1
]

{ #category : #tests }
SubstanceTest >> testWithdrawalTimeFor_WithFullyExemptSubstance [
	"'aceite de soja' is totally exempt"

	| conAceiteDeSojaSolamente |
	conAceiteDeSojaSolamente := Substance new
		comercialName: 'Con aceite de soja solamente'.
	conAceiteDeSojaSolamente
		addActiveIngredient: (ActiveIngredient tradeName: 'aceite de soja').
	self
		assert:
			(conAceiteDeSojaSolamente
				withdrawalTimeFor: (Crop name: 'Tomate' yield: 0))
		equals: 0
]

{ #category : #tests }
SubstanceTest >> testWithdrawalTimeFor_WithPartiallyExemptSubstance [
	"'azoxistrobina' is excempt only for a few, including Tabacco and not Potato"

	| conAzoxistrobinaSolamente |
	conAzoxistrobinaSolamente := Substance new
		comercialName: 'Con azoxistrobina solamente'.
	conAzoxistrobinaSolamente
		addActiveIngredient: (ActiveIngredient tradeName: 'azoxistrobina').
	self
		assert:
			(conAzoxistrobinaSolamente
				withdrawalTimeFor: (Crop name: 'Tabaco' yield: 0))
		equals: 0.
	self
		should: [ conAzoxistrobinaSolamente
				withdrawalTimeFor: (Crop name: 'Papa' yield: 0) ]
		raise: MissingWithdrawalInformationException
]
