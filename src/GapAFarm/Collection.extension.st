Extension { #name : #Collection }

{ #category : #'*GapAFarm' }
Collection >> ifNotNilNeitherEmpty: aBlock [
	"Evaluate the given block with the receiver as argument, answering its value
    unless the receiver is empty, in which case answer the receiver."

	^ self ifNotEmpty: aBlock
]
