Class {
	#name : #NumberPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #hooks }
NumberPropertyEditorComponent >> obtainValueFromString: aString [
	| newNumber |
	(aString includes: $,)
		ifTrue: [ problems
				add:
					'No utilice '','' para indicar los decimales en ' , label
						, '. Utilice ''.'''.
			^ bufferedValue ].
	aString isEmpty
		ifTrue: [ ^ bufferedValue ].
	[ newNumber := aString asNumber ]
		on: Error
		do: [ problems add: label , ' debe ser un numero valido.'.
			^ bufferedValue ].
	^ newNumber
]

{ #category : #hooks }
NumberPropertyEditorComponent >> renderInputOn: html [
	| input |
	input := html numberInput.
	input
		formControl;
		step: 0.01;
		placeholder: '0.00';
		noAutocomplete;
		callback: [ :value | self handleCallbackWith: value ];
		value: (bufferedValue ifNil: [ '' ] ifNotNil: [ :it | it printString ]);
		id: self id.

]
