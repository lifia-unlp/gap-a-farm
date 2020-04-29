Class {
	#name : #WithdrawalRecommendation,
	#superclass : #GafObject,
	#instVars : [
		'daysToWait',
		'crop',
		'referenceUrl'
	],
	#category : #'GapAFarm-model'
}

{ #category : #'instance-creation' }
WithdrawalRecommendation class >> daysToWait: days crop: crop referenceUrl: url [
	^ self new
		daysToWait: days;
		crop: crop;
		referenceUrl: url;
		yourself
]

{ #category : #voyage }
WithdrawalRecommendation class >> isVoyageRoot [
	^ false
]

{ #category : #accessing }
WithdrawalRecommendation >> crop [
	^ crop
]

{ #category : #accessing }
WithdrawalRecommendation >> crop: anObject [
	crop := anObject
]

{ #category : #accessing }
WithdrawalRecommendation >> daysToWait [
	^ daysToWait
]

{ #category : #accessing }
WithdrawalRecommendation >> daysToWait: anObject [
	daysToWait := anObject
]

{ #category : #exporting }
WithdrawalRecommendation >> exportToJson [ 
	^ '{ "crop" : "',  crop vulgarName , '",  "daysToWait" : "',  daysToWait asString,  '",  "referenceUrl" : "' ,   referenceUrl ,  '"}'
]

{ #category : #accessing }
WithdrawalRecommendation >> referenceUrl [
	^ referenceUrl
]

{ #category : #accessing }
WithdrawalRecommendation >> referenceUrl: anObject [
	referenceUrl := anObject
]
