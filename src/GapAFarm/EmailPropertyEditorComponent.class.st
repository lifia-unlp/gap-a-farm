Class {
	#name : #EmailPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #rendering }
EmailPropertyEditorComponent >> handleCallbackWith: aWAEmailAddress [
	problems := OrderedCollection new.
	aWAEmailAddress isNil & required
		ifTrue: [ problems add: label , ' es un dato obligatorio.'.
			^ self ].
	bufferedValue := aWAEmailAddress
]

{ #category : #hooks }
EmailPropertyEditorComponent >> renderInputOn: html [
	| input |
	input := html emailInput.
	input
		readonly: readOnly;
		formControl;
		callback: [ :value | self handleCallbackWith: value ];
		value: bufferedValue;
		id: self id.
	required
		ifTrue: [ input attributeAt: 'required' put: 'on' ]
]
