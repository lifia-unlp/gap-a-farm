Class {
	#name : #ParasolHelperForDataPreparation,
	#superclass : #Object,
	#category : #'GapAFarm-Tests-helpers'
}

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> sampleCrops [
	^ {'Tomate' . 'Pimiento' . 'Pepino'}
		collect: [ :each | Crop name: each yield: 1 ]
]

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> sampleEmail [
	^ 'john@gmail.com'
]

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> sampleFullname [
	^ 'John Doe'
]

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> sampleIngredients [
	^ {'Tomate' . 'Pimiento' . 'Pepino'}
		collect: [ :each | Crop name: each yield: 1 ]
]

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> samplePassword [
	^ 'password'
]

{ #category : #'factory-methods' }
ParasolHelperForDataPreparation >> sampleUser [
	^ (GAFUser email: self sampleEmail fullname: self sampleFullname)
		hashedPassword:
			(SHA256 new hashMessage:
				self samplePassword asByteArray) asString;
		yourself
]
