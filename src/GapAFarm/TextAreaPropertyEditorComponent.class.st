Class {
	#name : #TextAreaPropertyEditorComponent,
	#superclass : #PropertyEditorComponent,
	#category : #'GapAFarm-widgets'
}

{ #category : #rendering }
TextAreaPropertyEditorComponent >> renderInputOn: html [
	^ html textArea
		rows: 3;
		readonly: readOnly;
		formControl;
		noAutocomplete;
		callback: [ :value | self handleCallbackWith: value ];
		value: bufferedValue;
		id: self id
]
