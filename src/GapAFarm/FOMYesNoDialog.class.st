Class {
	#name : #FOMYesNoDialog,
	#superclass : #GAFAbstractComponent,
	#instVars : [
		'message'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #'instance creation' }
FOMYesNoDialog class >> message: aString [
	^ self new
		message: aString;
		yourself
]

{ #category : #accessing }
FOMYesNoDialog >> message [
	^ message
]

{ #category : #accessing }
FOMYesNoDialog >> message: anObject [
	message := anObject
]

{ #category : #callbacks }
FOMYesNoDialog >> no [
	self answer: false
]

{ #category : #rendering }
FOMYesNoDialog >> renderContentOn: html [
	html
		container: [ html paragraph: [ html html: message ].
			html
				paragraph: [ html anchor
						callback: [ self yes ];
						with: [ html formButton
								bePrimary;
								with: 'Si' ].
					html space.
					html anchor
						callback: [ self no ];
						with: [ html formButton
								beSecondary;
								with: 'No' ] ] ]
]

{ #category : #callbacks }
FOMYesNoDialog >> yes [
	self answer: true
]
