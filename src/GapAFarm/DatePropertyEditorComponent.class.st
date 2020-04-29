Class {
	#name : #DatePropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #hooks }
DatePropertyEditorComponent >> obtainValueFromString: aString [
	| newDate |
	[ newDate := (DateParser
		readingFrom: aString readStream
		pattern: 'd/m/y') parse ]
		on: Error
		do: [ problems
				add: label , ' debe ser una fecha valida en formato dd/mm/aaaa.'.
			^ bufferedValue ].
	^ newDate asDate
]

{ #category : #hooks }
DatePropertyEditorComponent >> renderInputOn: html [
	| input |
	input := html textInput.
	readOnly
		ifTrue: [ input
				formControl;
				readonly: readOnly;
				value: (bufferedValue ifNil: [ '' ] ifNotNil: [ :it | it asDate ddmmyyyy ]);
				id: self id.
			^ self ].
	input
		noAutocomplete;
		formControl;
		readonly: readOnly;
		placeholder: 'dd/mm/aaaa';
		value: (bufferedValue ifNil: [ '' ] ifNotNil: [ :it | it asDate ddmmyyyy ]);
		callback: [ :value | self handleCallbackWith: value ];
		id: self id;
		script:
			(html jQuery new datepicker
				dateFormat: 'dd/mm/yy';
				onSelect: html jQuery ajax serializeThis).
	required
		ifTrue: [ input attributeAt: 'required' put: 'on' ]
]

{ #category : #hooks }
DatePropertyEditorComponent >> renderReadOnlyOn: html [
	html textInput
		formControl;
		readonly: readOnly;
		value: (bufferedValue ifNil: [ '' ] ifNotNil: [ :it | it asDate ddmmyyyy ]);
		id: self id
]
