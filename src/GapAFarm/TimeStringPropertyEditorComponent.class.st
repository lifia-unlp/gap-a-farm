Class {
	#name : #TimeStringPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #hooks }
TimeStringPropertyEditorComponent >> obtainValueFromString: aString [

	(aString matchesRegex: '^([1-9]|[0-1][0-9]|[2][0-3])\:([0-5][0-9])$')
		ifFalse: [ problems add: 'La hora debe debe ingresarse en formato HH:MM de 24 hrs'.
			^ bufferedValue ].
	aString isEmpty
		ifTrue: [ ^ bufferedValue ].
	^ aString asTime
]

{ #category : #hooks }
TimeStringPropertyEditorComponent >> renderInputOn: html [
	html textInput
		noAutocomplete;
		readonly: readOnly ;
		formControl;
		placeholder: 'hh:mm';
		value:
			(bufferedValue
				ifNil: [ nil ]
				ifNotNil: [ :it | it print24WithoutSeconds ]);
		callback: [ :value | self handleCallbackWith: value ];
		id: self id
]
