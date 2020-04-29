Class {
	#name : #TestGAFSessionForSampleUser,
	#superclass : #GAFSession,
	#category : #'GapAFarm-Tests-helpers'
}

{ #category : #initialization }
TestGAFSessionForSampleUser >> initialize [
	super initialize.
	user := GAFUser
		selectOne:
			[ :each | each email = ParasolHelperForDataPreparation new sampleEmail ]
]
