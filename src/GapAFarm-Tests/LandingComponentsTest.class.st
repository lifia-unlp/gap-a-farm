Class {
	#name : #LandingComponentsTest,
	#superclass : #GAFComponentTestCase,
	#category : #'GapAFarm-Tests-parasol'
}

{ #category : #running }
LandingComponentsTest >> componentClass [
	^ GAFLandingComponent
]

{ #category : #scripts }
LandingComponentsTest >> loginFarmer [
	(driver findElementByID: 'email')
		clear;
		sendKeys: helper sampleEmail.
	(driver findElementByID: 'password')
		clear;
		sendKeys: helper samplePassword.
	(driver findElementByID: 'login') click
]

{ #category : #scripts }
LandingComponentsTest >> registerFarmer [
	(driver findElementByPartialLinkText: 'registrarse') click.
	(driver findElementByID: 'fullname') sendKeys: helper sampleFullname.
	(driver findElementByID: 'email') sendKeys: helper sampleEmail.
	(driver findElementByID: 'repeatEmail') sendKeys: helper sampleEmail.
	(driver findElementByID: 'password') sendKeys: helper samplePassword.
	(driver findElementByID: 'login') click
]

{ #category : #running }
LandingComponentsTest >> setUp [
	GAFStorage inMemory.
	helper := ParasolHelperForDataPreparation new.
	super setUp
]

{ #category : #tests }
LandingComponentsTest >> testLogin [
	| user |
	self loginFarmer.
	self
		assert: (driver getPageSource includesSubstring: 'El usuario no existe').
	user := helper sampleUser.
	user addFarm: (Farm name: 'test') save.
	user save.
	self loginFarmer.
	self assert: (driver getPageSource includesSubstring: 'Eventos')
]

{ #category : #tests }
LandingComponentsTest >> testRegister [
	self registerFarmer.
	self assert: (driver getPageSource includesSubstring: 'Eventos')
]
