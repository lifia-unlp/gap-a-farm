Class {
	#name : #TextLinePropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #'subclass-responsibility' }
TextLinePropertyEditorComponent >> obtainValueFromString: aString [
	^ aString trimBoth
]

{ #category : #'subclass-responsibility' }
TextLinePropertyEditorComponent >> renderInputOn: html [
	| input |
	input := html textInput.
	input
		noAutocomplete;
		readonly: readOnly;
		formControl;
		callback: [ :value | self handleCallbackWith: value ];
		value: bufferedValue;
		id: self id.
	required
		ifTrue: [ input attributeAt: 'required' put: 'on' ]
]
