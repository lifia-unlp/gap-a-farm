Extension { #name : #BPKeyboard }

{ #category : #'*GapAFarm-Tests' }
BPKeyboard >> sendKeys: aString modifiedBy: aControlCharacter [
	self sendKeys: {aControlCharacter} , aString , {BPKeys null}
]
