| port adminEmail demoMode mongoDB route|

port := 8080.
adminEmail := 'admin@gapafarm.com'.
demoMode := false. 
mongoDB := 'gapafarm'.

"DO NOT CHANGE FROM HERE ON"

WAAdmin defaultServerManager adaptors
	do: [ :each | WAAdmin defaultServerManager unregister: each ].
ZnZincServerAdaptor startOn: port.
	
(WAAdmin defaultDispatcher handlers keys copyWithoutAll: #('files'))
	do: [ :appName | 
		WAAdmin defaultDispatcher
			unregister: (WAAdmin defaultDispatcher handlerAt: appName) ].

WAAdmin applicationDefaults
	removeParent: WADevelopmentConfiguration instance.

GAFDeployer new
	adminEmail: adminEmail;
	database: mongoDB;
	deploy.

WAAdmin defaultDispatcher defaultName: 'gaf'.

GAFDeployer demoMode: demoMode.
