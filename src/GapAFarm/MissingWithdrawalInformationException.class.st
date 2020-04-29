Class {
	#name : #MissingWithdrawalInformationException,
	#superclass : #Error,
	#instVars : [
		'crop',
		'substance'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance creation' }
MissingWithdrawalInformationException class >> crop: aCrop substance: aSubstance [
	^ self new
		crop: aCrop;
		substance: aSubstance;
		yourself
]

{ #category : #accessing }
MissingWithdrawalInformationException >> crop [
	^ crop
]

{ #category : #accessing }
MissingWithdrawalInformationException >> crop: anObject [
	crop := anObject
]

{ #category : #accessing }
MissingWithdrawalInformationException >> substance [
	^ substance
]

{ #category : #accessing }
MissingWithdrawalInformationException >> substance: anObject [
	substance := anObject
]
