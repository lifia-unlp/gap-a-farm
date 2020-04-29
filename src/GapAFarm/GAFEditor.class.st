Class {
	#name : #GAFEditor,
	#superclass : #WAPluggableEditor,
	#instVars : [
		'commentEditorComponent'
	],
	#category : #'GapAFarm-ui-editors'
}

{ #category : #'subclass-responsibility' }
GAFEditor >> children [
	"Return all property editors in this editor, in the order you want them to be rendered"

	^ {commentEditorComponent}
]

{ #category : #'ui requests' }
GAFEditor >> confirm: message [
	^ self call: (FOMYesNoDialog message: message)
]

{ #category : #initialization }
GAFEditor >> initializeComponents [
	commentEditorComponent := TextAreaPropertyEditorComponent 
	   id: 'commentEditor'
		subject: subject
		selector: #comment
		label: 'Notas'
		required: false.
]
