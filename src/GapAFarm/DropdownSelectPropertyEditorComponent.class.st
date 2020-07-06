Class {
	#name : #DropdownSelectPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#instVars : [
		'possibleValuesBlock',
		'labelsBlock',
		'dependentWidget'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> dependentWidget [
	^ dependentWidget
]

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> dependentWidget: anObject [
	dependentWidget := anObject
]

{ #category : #hooks }
DropdownSelectPropertyEditorComponent >> handleCallbackWith: anObject [
	problems := OrderedCollection new.
	anObject isNil & required
		ifTrue: [ problems add: label , ' es un dato obligatorio.'.
			^ self ].
	bufferedValue := anObject
]

{ #category : #hooks }
DropdownSelectPropertyEditorComponent >> initialize [
	possibleValuesBlock := [ OrderedCollection new ]
]

{ #category : #rendering }
DropdownSelectPropertyEditorComponent >> labelFor: each [
	^ labelsBlock
		ifNil: [ each greaseString ]
		ifNotNil: [ labelsBlock value: each ]
]

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> labelsBlock [
	^ labelsBlock
]

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> labelsBlock: anObject [
	labelsBlock := anObject
]

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> possibleValuesBlock [
	^ possibleValuesBlock
]

{ #category : #accessing }
DropdownSelectPropertyEditorComponent >> possibleValuesBlock: anObject [
	possibleValuesBlock := anObject
]

{ #category : #rendering }
DropdownSelectPropertyEditorComponent >> renderInputOn: html [
	| select |
	readOnly
		ifFalse: [ select := html select.
			select
				formControl;
				list: possibleValuesBlock value;
				callback: [ :value | self handleCallbackWith: value ];
				selected: bufferedValue;
				id: self id.
			labelsBlock ifNotNil: [ select labels: labelsBlock ].
			dependentWidget
				ifNotNil: [ select
						onChange:
							((html jQuery id: dependentWidget id) load
								serializeForm;
								html: [ :widgetCanvas | widgetCanvas render: dependentWidget ];
								yourself) ] ]
		ifTrue: [ html textInput
				formControl;
				readonly: true;
				with: (self labelFor: bufferedValue) ]
]
