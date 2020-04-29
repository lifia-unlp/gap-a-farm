Class {
	#name : #MultipleSelectPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#instVars : [
		'possibleValuesBlock',
		'rows',
		'labelsBlock'
	],
	#category : #'GapAFarm-widgets'
}

{ #category : #rendering }
MultipleSelectPropertyEditorComponent >> handleCallbackWith: anObject [
	problems := OrderedCollection new.
	anObject isEmpty & required
		ifTrue: [ problems add: label , ' es un dato obligatorio - debe seleccionarl al menos un elemento.'.
			^ self ].
	bufferedValue := anObject
]

{ #category : #initialization }
MultipleSelectPropertyEditorComponent >> initialize [
	possibleValuesBlock := [ OrderedCollection new ].
	rows := 5
]

{ #category : #hooks }
MultipleSelectPropertyEditorComponent >> labelFor: each [
	^ labelsBlock
		ifNil: [ each printString ]
		ifNotNil: [ labelsBlock value: each ]
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> labelsBlock [
	^ labelsBlock
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> labelsBlock: anObject [
	labelsBlock := anObject
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> possibleValuesBlock [
	^ possibleValuesBlock
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> possibleValuesBlock: anObject [
	possibleValuesBlock := anObject
]

{ #category : #hooks }
MultipleSelectPropertyEditorComponent >> renderInputOn: html [
	| select |
	readOnly
		ifTrue: [ self renderReadOnlyOn: html.
			^ self ].
	select := html multiSelect.
	select
		formControl;
		size: rows;
		list: possibleValuesBlock value;
		callback: [ :value | self handleCallbackWith: value ];
		selected: bufferedValue;
		id: self id.
	labelsBlock ifNotNil: [ select labels: labelsBlock ]
]

{ #category : #hooks }
MultipleSelectPropertyEditorComponent >> renderReadOnlyOn: html [
	bufferedValue
		ifNotEmpty: [ html textInput
				formControl;
				readonly: true;
				with:
					(bufferedValue collect: [ :each | self labelFor: each ])
						asCommaString ]
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> rows [
	^ rows
]

{ #category : #accessing }
MultipleSelectPropertyEditorComponent >> rows: anObject [
	rows := anObject
]
